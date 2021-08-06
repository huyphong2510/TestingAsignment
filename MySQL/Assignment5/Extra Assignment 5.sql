use adventureworks;
-- Question 1:
-- Viết 1 query lấy thông tin "Name" từ bảng Production.Product có name của ProductSubcategory là 'Saddles'.

select * from product;

SELECT 
    `name`
FROM
    Product
WHERE
    ProductSubcategoryID = (SELECT 
            ProductSubcategoryID
        FROM
            ProductSubcategory
        WHERE
            `name` LIKE '%Saddles');

-- Thay đổi câu Query 1 để lấy được kết quả sau.

SELECT 
    `Name`
FROM
    Product
WHERE
    `name` LIKE '%Bo%'
        AND ProductSubcategoryID IS NOT NULL;

-- Viết câu query trả về tất cả các sản phẩm có giá rẻ nhất (lowest ListPrice) và Touring Bike (nghĩa là ProductSubcategoryID = 3)

Select `name`, min(listprice) from Product where ProductSubcategoryID=3 group by `name` having min(listprice) > 1214.85 ;



SELECT 
    `name`, MIN(listprice) as 'lowest ListPrice'
FROM
    Product
WHERE
    `name` IN (SELECT 
            `name`
        FROM
            Product
        WHERE
            `name` LIKE 'Touring-3000%')
GROUP BY `name`;

-- Exercise 2: JOIN nhiều bảng

-- Question 1: Viết query lấy danh sách tên country và province được lưu trong AdventureWorks2008sample database.

select * from address;
select * from stateprovince;
select * from countryregion;

SELECT 
    cr.`Name` as 'Country', st.`Name` as 'Province'
FROM
    StateProvince st
        JOIN
    CountryRegion cr ON st.countryregioncode = cr.countryregioncode;
    
-- Question 2: Tiếp tục với câu query trước và thêm điều kiện là chỉ lấy country Germany và Canada

SELECT 
    cr.`Name` as 'Country', st.`Name` as 'Province'
FROM
    StateProvince st
        JOIN
    CountryRegion cr ON st.countryregioncode = cr.countryregioncode
    WHERE cr.`name` IN ('Germany', 'Canada');
    
-- Question 3: Từ bảng SalesPerson, chúng ta lấy cột BusinessEntityID (là định danh của người sales), 
-- Bonus and the SalesYTD (là đã sale được bao nhiêu người trong năm nay)

Select * from SalesPerson;
Select * from SalesOrderHeader;


SELECT 
    so.SalesOrderID,
    so.OrderDate,
    so.SalesPersonID,
    sp.salesPersonID AS 'BusinessEntityID',
    sp.Bonus,
    sp.SalesYTD
FROM
    SalesOrderHeader so
        JOIN
    SalesPerson sp ON sp.salesPersonID = so.salesPersonID

;

-- Question 4: Sử dụng câu query ở question 3, thêm cột JobTitle and xóa cột SalesPersonID và BusinessEntityID.
Select * from employee;

SELECT 
	so.SalesOrderId, so.OrderDate, e.title as 'Job Title', sp.bonus, sp.SalesYTD
From SalesOrderHeader so
JOIN SalesPerson sp ON sp.salespersonID = so.salespersonID
JOIN Employee e ON so.salespersonID = e.employeeID;
