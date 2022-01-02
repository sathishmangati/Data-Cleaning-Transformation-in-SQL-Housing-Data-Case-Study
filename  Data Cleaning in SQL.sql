/*

Cleaning Data in SQL Queries

*/

SELECT *
FROM ProjectPortfolio..HousingData


------------------------------------------------------------------------------

--Standerdize Date Format

SELECT SaleDate, CONVERT(date, SaleDate)
FROM ProjectPortfolio..HousingData

UPDATE HousingData
SET SaleDate = CONVERT(date, SaleDate)

ALter TABLE HousingData
ADD SaleDateConverted Date;

UPDATE HousingData
SET SaleDateConverted = CONVERT(date, SaleDate)


------------------------------------------------------------------------------

-- property addresss data

SELECT *
FROM ProjectPortfolio..HousingData
--WHERE PropertyAddress is NULL
ORDER BY ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM ProjectPortfolio..HousingData a
JOIN ProjectPortfolio..HousingData b
  ON a.ParcelID = b.ParcelID
  AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is NULL


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM ProjectPortfolio..HousingData a
JOIN ProjectPortfolio..HousingData b
  ON a.ParcelID = b.ParcelID
  AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is NULL


------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns(Address, City, state)

SELECT PropertyAddress
FROM ProjectPortfolio..HousingData
--WHERE PropertyAddress is NULL
--ORDER BY ParcelID

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
FROM ProjectPortfolio..HousingData


ALter TABLE HousingData
ADD PropertySplitAddress Nvarchar(255);

UPDATE HousingData
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)


ALter TABLE HousingData
ADD PropertySplitCity Nvarchar(255);

UPDATE HousingData
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

SELECT *
FROM ProjectPortfolio..HousingData 
--SEE At the End of Table we can find PropertySplitAddress, PropertySplitCity


--Change Owner Address

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
FROM ProjectPortfolio..HousingData 


ALter TABLE HousingData
ADD OwnerSplitAddress Nvarchar(255);

UPDATE HousingData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALter TABLE HousingData
ADD OwnerSplitCity Nvarchar(255);

UPDATE HousingData
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALter TABLE HousingData
ADD OwnerSplitState Nvarchar(255);

UPDATE HousingData
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
 
SELECT *
FROM ProjectPortfolio..HousingData 

------------------------------------------------------------------------------

--Change Y nad N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM ProjectPortfolio..HousingData 
GROUP BY SoldAsVacant
ORDER BY 2


SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
       WHEN SoldAsVacant = 'N' THEN 'No'
       ELSE SoldAsVacant
       END
FROM ProjectPortfolio..HousingData 


UPDATE HousingData
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
       WHEN SoldAsVacant = 'N' THEN 'No'
       ELSE SoldAsVacant
       END


------------------------------------------------------------------------------

--Remove Duplicates

--Write an CTE

WITH RowNumCTE AS(
SELECT *, 
    ROW_NUMBER() OVER (
        PARTITION BY ParcelID,
                     PropertyAddress,
                     SalePrice,
                     SaleDate,
                     LegalReference
                     ORDER BY
                       UniqueID
                       ) row_num

FROM ProjectPortfolio..HousingData 
--ORDER BY ParcelID
)
SELECT *
--DELETE
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress

-- 104 DUPLICATES! ,, Instead of select Option.. USE DELETE TO REMOVE DUPLICATES

------------------------------------------------------------------------------

--Delete Unused Column
 

ALTER TABLE ProjectPortfolio..HousingData
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress








