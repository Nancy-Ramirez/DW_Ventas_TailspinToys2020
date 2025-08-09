-- Crear base de datos
CREATE DATABASE DW_Ventas_TailspinToys2020;
GO

USE DW_Ventas_TailspinToys2020;
GO

--Dimensi�n de fechas
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY, -- Formato: YYYYMMDD
    full_date DATE NOT NULL,
    day INT NOT NULL,
    month INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL,
);
GO
--Dimensi�n de productos
CREATE TABLE dim_product (
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL, -- Business Key
    product_sku VARCHAR(50) NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    product_category VARCHAR(100),
    item_group VARCHAR(100),
    kit_type VARCHAR(50),
    channels VARCHAR(50),
    demographic VARCHAR(50),
    retail_price DECIMAL(10,2) NOT NULL
);
GO

--Dimensi�n de ubicacion
CREATE TABLE dim_state (
    state_key INT IDENTITY(1,1) PRIMARY KEY,
    state_id INT NOT NULL, -- Business Key
    state_code VARCHAR(10) NOT NULL,
    state_name VARCHAR(100) NOT NULL,
    time_zone VARCHAR(50),
    region_name VARCHAR(50)
);
GO

--Dimensi�n de salas de venta
CREATE TABLE dim_sales_office (
    sales_office_key INT IDENTITY(1,1) PRIMARY KEY,
    sales_office_id INT NOT NULL, -- Business Key
    address_line1 VARCHAR(200),
    address_line2 VARCHAR(200),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    telephone VARCHAR(50),
    facsimile VARCHAR(50),
    email VARCHAR(100),
    state_code VARCHAR(10),
    state_name VARCHAR(100),
    time_zone VARCHAR(50),
    region_name VARCHAR(50)
);
GO

--Tabla de hechos: Ventas
CREATE TABLE fact_sales (
    sales_key INT IDENTITY(1,1) PRIMARY KEY,
    date_id INT NOT NULL,
    product_key INT NOT NULL,
    state_key INT NOT NULL,
    sales_office_key INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    -- Llaves for�neas
    CONSTRAINT FK_fact_sales_dim_date 
        FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    CONSTRAINT FK_fact_sales_dim_product 
        FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    CONSTRAINT FK_fact_sales_dim_state 
        FOREIGN KEY (state_key) REFERENCES dim_state(state_key),
    CONSTRAINT FK_fact_sales_dim_sales_office 
        FOREIGN KEY (sales_office_key) REFERENCES dim_sales_office(sales_office_key)
);
GO