from pyspark.sql import SparkSession

## Set up Spark Session
spark = SparkSession.builder.master("local").appName("cases").getOrCreate()
cases = spark.read.format("csv").option("header", "true").load("cases-locations.csv")
cases.createOrReplaceTempView("cases")

## This view returns number of cases grouped by lhd code and date
cases_view = spark.sql(
    "create temporary view cases_view as " +
    "select first(lhd_2010_name) as lhd_name, lhd_2010_code, notification_date, count(num) as count_num " +
    "from cases " +
    "group by lhd_2010_code, notification_date"
)

## Query selects max daily cases number for each lhd
results = spark.sql(
    "select lhd_name, lhd_2010_code, notification_date, count_num " +
    "from cases_view " +
    "where (lhd_2010_code, count_num) in (select lhd_2010_code, max(count_num) from cases_view group by lhd_2010_code) " +
    "order by count_num desc, notification_date asc, lhd_name desc"
)

#results.show()
results.write.csv("result-sql")

spark.stop()