CREATE SCHEMA Digital_Textile_Production_Monitoring_Platform;	
USE Digital_Textile_Production_Monitoring_Platform;
CREATE TABLE DESIGN (
    Design_ID INT AUTO_INCREMENT PRIMARY KEY,
    Designer_Name VARCHAR(100) NOT NULL,
    Design_Date DATE NOT NULL,
    Fabric_Type VARCHAR(50),
    Color VARCHAR(30),
    Description TEXT
);

-- 2. Tablo: ORDER
CREATE TABLE `ORDER` (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Order_Date DATE NOT NULL,
    Total_Ordered INT NOT NULL,
    Sales_Ready_Date DATE,
    Delivery_Status VARCHAR(50) DEFAULT 'Pending',
    -- Kural 100: Design_Date <= Sales_Date mantığı için tarih kontrolü
    CONSTRAINT check_order_dates CHECK (Order_Date <= Sales_Ready_Date)
);

-- 3. Tablo: PRODUCT
CREATE TABLE PRODUCT (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Design_ID INT NOT NULL,
    Order_ID INT NOT NULL,
    Product_Code VARCHAR(50) UNIQUE NOT NULL, -- Kural 89: Benzersiz Ürün Kodu
    Product_Name VARCHAR(100),
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (Design_ID) REFERENCES DESIGN(Design_ID),
    FOREIGN KEY (Order_ID) REFERENCES `ORDER`(Order_ID)
);

-- 4. Tablo: PRODUCTION
CREATE TABLE PRODUCTION (
    Production_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_ID INT UNIQUE NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Sewing_Status VARCHAR(50),
    Ironing_Status VARCHAR(50),
    Finish_Status_QC VARCHAR(50),
    Total_Quantity INT NOT NULL DEFAULT 0,
    Defective_Quantity INT NOT NULL DEFAULT 0,
    -- Kural 106: Approved = Total - Defective (Otomatik Hesaplama)
    Approved_Quantity INT AS (Total_Quantity - Defective_Quantity) STORED,
    
    FOREIGN KEY (Product_ID) REFERENCES PRODUCT(Product_ID),
    
    -- Kural 105: Kusurlu miktar toplam miktardan büyük olamaz
    CONSTRAINT check_defective CHECK (Defective_Quantity <= Total_Quantity),
    -- Kural 101: Başlangıç tarihi bitişten önce olmalı
    CONSTRAINT check_prod_dates CHECK (Start_Date <= End_Date)
);

-- 5. Tablo: SALES
CREATE TABLE SALES (
    Sales_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Order_ID INT NOT NULL,
    Sales_Date DATE NOT NULL,
    Quantity_Sold INT NOT NULL,
    Revenue DECIMAL(15, 2) NOT NULL,
    
    FOREIGN KEY (Product_ID) REFERENCES PRODUCT(Product_ID),
    FOREIGN KEY (Order_ID) REFERENCES `ORDER`(Order_ID)
);