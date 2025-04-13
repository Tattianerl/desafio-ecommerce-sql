-- Table: Person
CREATE TABLE Person (
    idPerson INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(15) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    Email VARCHAR(45) UNIQUE NOT NULL,
    Phone CHAR(15),
    Address VARCHAR(45)
);

-- Table: Legal_Person
CREATE TABLE Legal_Person (
    idLegalPerson INT AUTO_INCREMENT PRIMARY KEY,
    Person_idPerson INT UNIQUE NOT NULL,
    CorporateName VARCHAR(45) NOT NULL,
    CNPJ CHAR(18) UNIQUE NOT NULL,
    FOREIGN KEY (Person_idPerson) REFERENCES Person(idPerson) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Natural_Person
CREATE TABLE Natural_Person (
    idNaturalPerson INT AUTO_INCREMENT PRIMARY KEY,
    Person_idPerson INT UNIQUE NOT NULL,
    CPF CHAR(14) UNIQUE NOT NULL,
    BirthDate DATE NOT NULL,
    FOREIGN KEY (Person_idPerson) REFERENCES Person(idPerson) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Client
CREATE TABLE Client (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Natural_Person_idNaturalPerson INT UNIQUE,
    Legal_Person_idLegalPerson INT UNIQUE,
    RegisterDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ClientType ENUM('Individual', 'Company') NOT NULL,
    FOREIGN KEY (Natural_Person_idNaturalPerson) REFERENCES Natural_Person(idNaturalPerson) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Legal_Person_idLegalPerson) REFERENCES Legal_Person(idLegalPerson) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Seller
CREATE TABLE Seller (
    idSeller INT AUTO_INCREMENT PRIMARY KEY,
    Legal_Person_idLegalPerson INT UNIQUE,
    Name VARCHAR(45) NOT NULL,
    Email VARCHAR(45) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    RegisterDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Legal_Person_idLegalPerson) REFERENCES Legal_Person(idLegalPerson) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Supplier
CREATE TABLE Supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    Legal_Person_idLegalPerson INT UNIQUE NOT NULL,
    RegisterDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Legal_Person_idLegalPerson) REFERENCES Legal_Person(idLegalPerson) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Product
CREATE TABLE Product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(45) NOT NULL,
    Category ENUM('Electronics', 'Clothing', 'Home', 'Books', 'Toys', 'Other') NOT NULL,
    Rating FLOAT,
    Description VARCHAR(255),
    Price DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Supplier_Product
CREATE TABLE Supplier_Product (
    Supplier_idSupplier INT NOT NULL,
    Product_idProduct INT NOT NULL,
    SupplyPrice DECIMAL(10,2),
    SupplyTime INT,
    StockQuantity INT,
    PRIMARY KEY (Supplier_idSupplier, Product_idProduct),
    FOREIGN KEY (Supplier_idSupplier) REFERENCES Supplier(idSupplier) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Product_idProduct) REFERENCES Product(idProduct) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Seller_Product
CREATE TABLE Seller_Product (
    Seller_idSeller INT NOT NULL,
    Product_idProduct INT NOT NULL,
    Quantity INT NOT NULL,
    SalePrice DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Seller_idSeller, Product_idProduct),
    FOREIGN KEY (Seller_idSeller) REFERENCES Seller(idSeller) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Product_idProduct) REFERENCES Product(idProduct) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Orders
CREATE TABLE Orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    Client_idClient INT NOT NULL,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') NOT NULL,
    Description VARCHAR(255),
    TotalAmount DECIMAL(10,2) NOT NULL,
    Paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (Client_idClient) REFERENCES Client(idClient) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Order_Product
CREATE TABLE Order_Product (
    Order_idOrder INT NOT NULL,
    Product_idProduct INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    ProductStatus ENUM('Available', 'Out of Stock') NOT NULL,
    PRIMARY KEY (Order_idOrder, Product_idProduct),
    FOREIGN KEY (Order_idOrder) REFERENCES Orders(idOrder) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Product_idProduct) REFERENCES Product(idProduct) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Payment
CREATE TABLE Payment (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    Order_idOrder INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod ENUM('Credit Card', 'Debit Card', 'Bank Transfer', 'Pix', 'Boleto') NOT NULL,
    PaymentStatus ENUM('Pending', 'Completed', 'Failed') NOT NULL,
    FOREIGN KEY (Order_idOrder) REFERENCES Orders(idOrder) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Refund
CREATE TABLE Refund (
    idRefund INT AUTO_INCREMENT PRIMARY KEY,
    Payment_idPayment INT NOT NULL,
    Order_idOrder INT NOT NULL,
    RefundAmount DECIMAL(10,2) NOT NULL,
    RefundStatus ENUM('Pending', 'Completed', 'Denied') NOT NULL,
    RefundReason TEXT,
    RefundDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Payment_idPayment) REFERENCES Payment(idPayment) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Order_idOrder) REFERENCES Orders(idOrder) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Shipping
CREATE TABLE Shipping (
    idShipping INT AUTO_INCREMENT PRIMARY KEY,
    Order_idOrder INT NOT NULL,
    Client_idClient INT NOT NULL,
    Carrier VARCHAR(45) NOT NULL,
    ShippingCost DECIMAL(10,2) NOT NULL,
    TrackingCode VARCHAR(45) UNIQUE NOT NULL,
    EstimatedDelivery DATE NOT NULL,
    ShippingStatus ENUM('Processing', 'Shipped', 'In Transit', 'Delivered', 'Returned') NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Order_idOrder) REFERENCES Orders(idOrder) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Client_idClient) REFERENCES Client(idClient) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Delivery
CREATE TABLE Delivery (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    Order_idOrder INT NOT NULL,
    Shipping_idShipping INT NOT NULL,
    RecipientName VARCHAR(45) NOT NULL,
    DeliveryStatus ENUM('Pending', 'Out for Delivery', 'Delivered', 'Failed') NOT NULL,
    DeliveryAddress TEXT NOT NULL,
    ReceivedAt TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (Order_idOrder) REFERENCES Orders(idOrder) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Shipping_idShipping) REFERENCES Shipping(idShipping) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Table: Stock
CREATE TABLE Stock (
    idStock INT AUTO_INCREMENT PRIMARY KEY,
    Location VARCHAR(45) NOT NULL,
    Quantity INT NOT NULL,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Product_Stock
CREATE TABLE Product_Stock (
    Product_idProduct INT NOT NULL,
    Stock_idStock INT NOT NULL,
    AvailableQuantity INT NOT NULL,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Product_idProduct, Stock_idStock),
    FOREIGN KEY (Product_idProduct) REFERENCES Product(idProduct) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (Stock_idStock) REFERENCES Stock(idStock) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
