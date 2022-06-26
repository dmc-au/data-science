CREATE TABLE orders(
    OrderDate DATE,
    ISBN STRING,
    Title STRING,
    Category STRING,
    PriceEach FLOAT,
    Quantity INT,
    FirstName STRING,
    LastName STRING,
    City STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH 'orders.csv'
OVERWRITE INTO TABLE orders;

SELECT CONCAT_WS(' ', FirstName, LastName), ROUND(SUM(PriceEach*Quantity)/SUM(Quantity), 2)
FROM orders
GROUP BY CONCAT_WS(' ', FirstName, LastName)