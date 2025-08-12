-- 1. Crear base de datos
CREATE DATABASE DW_Ventas_TailspinToys2020;
GO

USE DW_Ventas_TailspinToys2020;
GO

-- 2. Dimensión: Fecha
CREATE TABLE dbo.dim_date (
    date_key INT NOT NULL PRIMARY KEY,  -- Formato: YYYYMMDD
    full_date DATE NOT NULL,
    day VARCHAR(10) NOT NULL,
    month VARCHAR(10) NOT NULL,
    month_name VARCHAR(10) NOT NULL,
    quarter VARCHAR(3) NOT NULL,
    year VARCHAR(50) NOT NULL
);
GO

-- 3. Dimensión: Producto
CREATE TABLE dbo.dim_product (
    product_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    product_id INT NOT NULL,
    product_sku VARCHAR(50) NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    product_category VARCHAR(100) NULL,
    item_group VARCHAR(100) NULL,
    kit_type VARCHAR(50) NULL,
    channels VARCHAR(50) NULL,
    demographic VARCHAR(50) NULL,
    retail_price DECIMAL(10, 2) NOT NULL
);
GO

-- 4. Dimensión: Estado
CREATE TABLE dbo.dim_state (
    state_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    state_id INT NOT NULL,
    state_code VARCHAR(10) NOT NULL,
    state_name VARCHAR(100) NOT NULL,
    time_zone VARCHAR(50) NULL,
    region_name VARCHAR(50) NULL
);
GO

-- 5. Tabla de hechos: Ventas
CREATE TABLE dbo.fact_sales (
    sales_key INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    order_date_key INT NOT NULL,
    ship_date_key INT NOT NULL,
    product_key INT NOT NULL,
    customer_state_key INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    discount_amount DECIMAL(10, 2) NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL,
    order_number VARCHAR(10) NULL,
    promotion_code VARCHAR(50) NULL
);
GO

-- 6. Llaves foráneas
ALTER TABLE dbo.fact_sales
    ADD CONSTRAINT FK_fact_sales_dim_product
    FOREIGN KEY (product_key) REFERENCES dbo.dim_product(product_key);

ALTER TABLE dbo.fact_sales
    ADD CONSTRAINT FK_fact_sales_dim_state
    FOREIGN KEY (customer_state_key) REFERENCES dbo.dim_state(state_key);

ALTER TABLE dbo.fact_sales
    ADD CONSTRAINT FK_fact_sales_order_date
    FOREIGN KEY (order_date_key) REFERENCES dbo.dim_date(date_key);

ALTER TABLE dbo.fact_sales
    ADD CONSTRAINT FK_fact_sales_ship_date
    FOREIGN KEY (ship_date_key) REFERENCES dbo.dim_date(date_key);
GO