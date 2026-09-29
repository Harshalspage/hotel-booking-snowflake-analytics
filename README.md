# Hotel Booking Analytics – Snowflake & Power BI

## 📌 Project Overview

This project demonstrates an end-to-end hotel booking data analytics pipeline using Snowflake and Power BI.

The project loads raw hotel booking data into Snowflake, performs data validation and cleaning through a Bronze and Silver layer, creates analytics-ready Gold tables, and visualizes booking and revenue metrics using Power BI.

---

## 🛠️ Technologies Used

- Snowflake
- SQL
- Power BI
- Microsoft Excel / CSV
- Git & GitHub

---

## 🏗️ Data Architecture

The project follows a Medallion-style data architecture:

Raw CSV  
↓  
**Bronze Layer**  
↓  
**Silver Layer**  
↓  
**Gold Layer**  
↓  
**Power BI Dashboard**

---

## 📂 Project Structure

```text
hotel-booking-snowflake-analytics/
│
├── PowerBI/
│   └── Hotel Booking Analytics.pbix
│
├── SQL/
│   └── 01_hotel_booking_pipeline.sql
│
├── Screeen Shot/
│   └── Screenshot 2026-09-29 130659.png
│
├── data/
│   └── hotel_bookings_raw.csv
│
└── LICENSE
```

---

## ❄️ Snowflake Data Pipeline

### 1. Database Setup

The project creates a Snowflake database named:

`HOTEL_DB`

A CSV file format and Snowflake stage are created to load the raw hotel booking data.

### 2. Bronze Layer

The raw booking data is loaded into:

`BRONZE_HOTEL_BOOKING`

The Bronze layer stores the incoming data before transformation and validation.

### 3. Silver Layer

The cleaned data is stored in:

`SILVER_HOTEL_BOOKINGS`

Data cleaning and validation include:

- Standardizing hotel city names
- Standardizing customer names
- Validating customer email addresses
- Converting check-in and check-out dates
- Converting booking amounts to numeric values
- Checking invalid check-in/check-out dates
- Standardizing booking status values

### 4. Gold Layer

The project creates the following analytics-ready tables:

#### `GOLD_AGG_DAILY_BOOKING`

Contains:

- Booking date
- Total bookings
- Total revenue

#### `GOLD_AGG_HOTEL_CITY_SALES`

Contains:

- Hotel city
- Total revenue

#### `GOLD_BOOKING_CLEAN`

Contains cleaned booking-level records.

---

## 📊 Power BI Dashboard

The Power BI dashboard is used to visualize hotel booking and revenue data.

The dashboard includes analysis such as:

- Total Bookings
- Total Revenue
- Average Booking Value
- Booking trends
- Revenue by hotel city
- Booking status
- Room type analysis

A dashboard screenshot is available in the `Screeen Shot` folder.

---

## 🔍 Data Quality Checks

The Snowflake pipeline includes checks for:

- Invalid customer email addresses
- Negative booking amounts
- Invalid check-in/check-out dates
- Invalid booking status values
- Missing or invalid dates

---

## 🚀 How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/Harshalspage/hotel-booking-snowflake-analytics.git
```

### 2. Load the dataset

The raw dataset is available in:

`data/hotel_bookings_raw.csv`

### 3. Run the Snowflake SQL

Open:

`SQL/01_hotel_booking_pipeline.sql`

Run the SQL in Snowflake to create the database, stage, Bronze table, Silver table, and Gold tables.

### 4. Open the Power BI dashboard

Open:

`PowerBI/Hotel Booking Analytics.pbix`

---

## 📁 Dataset

The dataset contains hotel booking information including:

- Booking ID
- Hotel ID
- Hotel City
- Customer ID
- Customer Name
- Customer Email
- Check-in Date
- Check-out Date
- Room Type
- Number of Guests
- Total Amount
- Currency
- Booking Status

---

## 🎯 Key Learning Outcomes

This project demonstrates practical experience with:

- Snowflake data loading
- SQL data transformation
- Medallion architecture
- Data quality validation
- Data cleaning
- Analytical table creation
- Data aggregation
- Power BI dashboard development
- Git and GitHub

---

## 👤 Author

**Harshal Shirsat**

GitHub:  
https://github.com/Harshalspage