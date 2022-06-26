from pyspark import SparkContext, SparkConf

## Initialising Spark Context
sc = SparkContext("local", "news")
csv = sc.textFile("cases-locations.csv")

## Functions for marhsalling tuple key
def to_list(a):
    return [a]

def append(a, b):
    a.append(b)
    return a

def extend(a, b):
    a.extend(b)
    return a

## Map function returns RDD as lhd key with tuple of dates and count for max daily increases.
def mf(rdd):
    values = dict(rdd[1])
    reduced = dict()
    top = max(values.values())
    for k, v in values.items():
        if v == top:
            reduced[k] = v
    return (rdd[0], list(reduced.items()))

## Map function to format the output
def to_csv_line(data):
  return ','.join(str(d) for d in data)

## RDD operations
rows = csv.map(lambda x: x.split(","))
header = rows.take(1)[0]
data = rows.filter(lambda x: x[0] != "notification_date")
kvpair = data.map(lambda x: ((x[3], x[2], x[0]), 1))
counted = kvpair.reduceByKey(lambda t, v : t + v)
singlekey = counted.map(lambda x: ((x[0][0],x[0][1]),(x[0][2],x[1]))).combineByKey(to_list,append,extend)
top1 = singlekey.map(mf)
flattened = top1.flatMapValues(lambda x: x).map(lambda x: (x[0][0],x[0][1],x[1][0],x[1][1])).collect()
results = sorted(flattened, key = lambda x: (x[3], -int(x[2].replace('-', '')), x[0]), reverse=True)

## Re parallelize, format, and save to file
tofile = sc.parallelize(results).map(to_csv_line).saveAsTextFile("result-rdd")
