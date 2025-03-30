# Data Cleaning & Transformation in SQL: Housing Data Case Study  

## 📌 Project Overview  
This project focuses on cleaning and transforming raw housing data using SQL. The dataset contains inconsistencies such as missing values, improper formatting, duplicate records, and redundant columns. Using SQL queries, we systematically clean and refine the data to make it more usable for analysis.

## 🛠️ Key Data Cleaning Steps  

### ✅ 1. Standardizing Date Format  
- Converted `SaleDate` to a standardized `DATE` format for consistency.  

### ✅ 2. Handling Missing Property Addresses  
- Used `JOIN` with `ParcelID` to fill missing addresses from duplicate entries.  

### ✅ 3. Splitting Property & Owner Addresses  
- Extracted `Street Address`, `City`, and `State` from concatenated address fields using `SUBSTRING()` and `PARSENAME()`.  

### ✅ 4. Standardizing Categorical Data  
- Replaced `'Y'` and `'N'` values in the `SoldAsVacant` field with `'Yes'` and `'No'` for better readability.  

### ✅ 5. Removing Duplicate Records  
- Implemented a `CTE` with `ROW_NUMBER()` to identify and remove duplicate records.  

### ✅ 6. Dropping Unused Columns  
- Removed unnecessary fields such as `OwnerAddress`, `TaxDistrict`, and `PropertyAddress` to optimize the dataset.  

## 📂 Dataset Source  
The dataset used in this project is a simulated housing data file used for SQL data transformation exercises.  

## 📌 Technologies Used  
- **SQL Server** (for query execution and transformation)  

