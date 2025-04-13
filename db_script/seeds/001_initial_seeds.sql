INSERT INTO Person (FirstName, LastName, Email, Phone, Address) VALUES
('John', 'Doe', 'john.doe@email.com', '12345678901', '123 Main St'),
('Jane', 'Smith', 'jane.smith@email.com', '98765432100', '456 Elm St'),
('Alice', 'Johnson', 'alice.johnson@email.com', '11223344556', '789 Oak St'),
('Bob', 'Brown', 'bob.brown@email.com', '22334455667', '101 Maple St'),
('Charlie', 'Davis', 'charlie.davis@email.com', '33445566778', '202 Pine St'),
('Daniel', 'Wilson', 'daniel.wilson@email.com', '44556677889', '303 Cedar St'),
('Emma', 'Moore', 'emma.moore@email.com', '55667788990', '404 Birch St'),
('Frank', 'Taylor', 'frank.taylor@email.com', '66778899001', '505 Walnut St'),
('Grace', 'Anderson', 'grace.anderson@email.com', '77889900112', '606 Cherry St'),
('Henry', 'Thomas', 'henry.thomas@email.com', '88990011223', '707 Spruce St');


INSERT INTO Legal_Person (Person_idPerson, CorporateName, CNPJ) VALUES
(6, 'Tech Solutions Ltda', '12.345.678/0001-99'),
(7, 'Global Trading Inc.', '98.765.432/0001-88');

INSERT INTO Natural_Person (Person_idPerson, CPF, BirthDate) VALUES
(1, '111.222.333-44', '1990-01-01'),
(2, '555.666.777-88', '1985-05-20'),
(3, '999.888.777-66', '1992-07-15'),
(4, '333.444.555-66', '1988-03-10'),
(5, '777.888.999-00', '1995-09-25');

INSERT INTO Client (Natural_Person_idNaturalPerson, Legal_Person_idLegalPerson, ClientType) VALUES
(1, NULL, 'Individual'),
(2, NULL, 'Individual'),
(NULL, 1, 'Company');

INSERT INTO Seller (Legal_Person_idLegalPerson, Name, Email, Phone) VALUES
(1, 'Daniel Wilson', 'daniel.wilson@techsolutions.com', '44556677889'),
(2, 'Emma Moore', 'emma.moore@globaltrading.com', '55667788990');

INSERT INTO Supplier (Legal_Person_idLegalPerson) VALUES
(1),
(2);

INSERT INTO Product (Name, Category, Rating, Description, Price, Quantity) VALUES
('Smartphone', 'Electronics', 4.5, 'Latest model with advanced features', 1500.00, 50),
('Laptop', 'Electronics', 4.8, 'High-performance laptop', 3500.00, 30),
('Headphones', 'Electronics', 4.2, 'Noise-canceling wireless headphones', 500.00, 100),
('Smart TV', 'Electronics', 4.6, '4K Ultra HD Smart TV', 2500.00, 20),
('Gaming Console', 'Electronics', 4.7, 'Next-gen gaming console', 3000.00, 25);

INSERT INTO Orders (Client_idClient, Status, Description, TotalAmount, Paid) VALUES
(1, 'Processing', 'Order of a smartphone and headphones', 2000.00, 1),
(2, 'Shipped', 'Order of a laptop', 3500.00, 1);

INSERT INTO Payment (Order_idOrder, Amount, PaymentMethod, PaymentStatus) VALUES
(1, 2000.00, 'Credit Card', 'Completed'),
(2, 3500.00, 'Pix', 'Completed');
