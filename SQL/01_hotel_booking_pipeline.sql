create database Hotel_DB;

CREATE OR REPLACE FILE FORMAT FF_CSV
           TYPE = 'CSV'
           FIELD_OPTIONALLY_ENCLOSED_BY = '"'
           SKIP_HEADER = 1
           NULL_IF = ('NULL','null', '')

CREATE OR REPLACE STAGE STG_HOTEL_BOOKINGG
     FILE_FORMAT = FF_CSV;

CREATE TABLE BRONZE_HOTEL_BOOKING (
booking_id STRING,
hotel_id STRING,
hotel_city STRING,
customer_id STRING,
customer_name STRING,
customer_emial STRING,
check_in_date STRING,
check_out_date STRING,
room_type STRING,
num_guests STRING,
total_amount STRING,
currency STRING,
booking_status STRING
);


COPY INTO BRONZE_HOTEL_BOOKING
FROM @STG_HOTEL_BOOKINGG
FILE_FORMAT = (FORMAT_NAME = FF_CSV)
ON_ERROR = 'CONTINUE';

SELECT * FROM BRONZE_HOTEL_BOOKING LIMIT 50;

CREATE TABLE SILVER_HOTEL_BOOKING(
   booking_id VARCHAR,
   hotel_id VARCHAR,
   hotel_city VARCHAR,
   customer_id VARCHAR,
   customer_name VARCHAR,
   customer_emial VARCHAR,
   check_in_date DATE,
   check_out_date DATE,
   room_type VARCHAR,
   num_guests INTEGER,
   total_amount FLOAT,
   currency VARCHAR,
   booking_status VARCHAR
); 
     
     



SELECT customer_emial
FROM BRONZE_HOTEL_BOOKING
WHERE NOT (customer_emial LIKE '%@%.%')
   OR customer_emial IS NULL

SELECT total_amount
FROM BRONZE_HOTEL_BOOKING
WHERE TRY_TO_NUMBER(total_amount) <0;

SELECT check_in_date, check_out_date
FROM BRONZE_HOTEL_BOOKING
WHERE TRY_TO_DATE(check_out_date) < TRY_TO_DATE(check_in_date)

SELECT DISTINCT booking_status
FROM BRONZE_HOTEL_BOOKING;

INSERT INTO SILVER_HOTEL_BOOKING
SELECT 
   booking_id,
   hotel_id,
   INITCAP(TRIM(hotel_city)) As hotel_city,
   CUSTOMER_id,
   INITCAP(TRIM(hotel_city)) As CUSTOMER_name,
   CASE
       WHEN CUSTOMER_EMIAL LIKE '%@%.%' THEN LOWER(TRIM(CUSTOMER_EMIAL))
       ELSE NULL 
    END AS CUSTOMER_EMIAL,
    TRY_TO_DATE(NULLIF(check_in_date, '')) As check_in_date,
    TRY_TO_DATE(NULLIF(check_out_date, '')) As check_out_date,
    room_type,
    num_guests,
    ABS (TRY_TO_NUMBER(total_amount)) As total_amount,
    currency,
    CASE 
        WHEN LOWER(booking_status) in ('Confirmneeed','confirmd') THEN 'confirmed'
        ELSE booking_status
        END AS booking_status
        FROM  BRONZE_HOTEL_BOOKING
        WHERE 
            TRY_TO_DATE(check_in_date) IS NOT NULL
            AND TRY_TO_DATE(check_out_date) IS NOT NULL  
            AND TRY_TO_DATE(check_out_date) >= TRY_TO_DATE (check_in_date);


SELECT * FROM SILVER_HOTEL_BOOKING LIMIT 30;

CREATE TABLE GOLD_AGG_DAILY_BOOKING AS
SELECT 
      check_in_date As date,
      COUNT(*) AS total_booking,
      SUM(total_amount) AS total_revenue
FROM SILVER_HOTEL_BOOKING
   GROUP BY check_in_date
   ORDER BY date;


CREATE TABLE GOLD_AGG_HOTEL_CITY_SALES AS
SELECT 
      hotel_city,
      SUM(total_amount) AS total_revenue
FROM SILVER_HOTEL_BOOKING
GROUP BY hotel_city
ORDER BY total_revenue DESC;

CREATE TABLE GOLD_BOOKING_CLEAN AS 
SELECT
    booking_id,
   hotel_id,
   hotel_city,
   customer_id,
   customer_name,
   customer_emial,
   check_in_date,
   check_out_date,
   room_type,
   num_guests,
   total_amount,
   currency,
   booking_status
FROM SILVER_HOTEL_BOOKING;

SELECT *  FROM GOLD_AGG_DAILY_BOOKING LIMIT 30;

SELECT *  FROM GOLD_AGG_HOTEL_CITY_SALES LIMIT 30;



SELECT CURRENT_ORGANIZATION_NAME() || '-' || CURRENT_ACCOUNT_NAME() || '.snowflakecomputing.com' AS server_url;

SHOW REGIONS; -- or check your account locator

SHOW WAREHOUSES; 


CREATE SCHEMA IF NOT EXISTS HOTEL_ANALYTICS;
USE SCHEMA HOTEL_ANALYTICS; 
