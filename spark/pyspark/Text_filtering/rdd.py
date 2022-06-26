from pyspark import SparkContext, SparkConf
from collections import Counter

sc = SparkContext('local', 'news')

text = sc.textFile("abcnews.txt")
stopwords = sc.textFile("stopwords.txt")
sw = stopwords.collect()

## Stopword filter function
def sw_filter(key):
    if key[1] not in sw:
        return True

## Functions for marshalling tuple-key
def to_list(a):
    return [a]

def append(a, b):
    a.append(b)
    return a

def extend(a, b):
    a.extend(b)
    return a

## Map function for 3rd most frequent count
def mf(rdd):
    values = dict(rdd[1])
    counter = Counter(values)
    top3 = sorted(counter.most_common(3), key = lambda x: (-x[1],x[0]))
    words, ordinals = zip(*top3)
    return (rdd[0], " ".join(words))

## Map function to format the output
def to_tab_line(data):
  return '\t'.join(str(d) for d in data)

## RDD operations
year_headline = text.map(lambda x: (x.split(",")[0][0:4], x.split(",")[1]))
words = year_headline.flatMapValues(lambda x: x.split()).filter(sw_filter)
tuplekey = words.map(lambda x: (x, 1))
tuplekey = tuplekey.reduceByKey(lambda t, v : t + v)
singlekey = tuplekey.map(lambda x: (x[0][0],(x[0][1],x[1]))).combineByKey(to_list,append,extend)
results = singlekey.map(mf)

## Format output and save to file
results.map(to_tab_line).saveAsTextFile("result-rdd")

sc.stop()
