use db_ecommerce;
-- Queries solicitadas

-- 1. Quem são Clientes e status dos seus pedidos
select concat(FirstName,' ',LastName) as Clientes, idOrder as Pedido, status as Status_do_pedido
from  person p, orders o
where  idPerson = idOrder;

-- 2. Quantos Clientes estão cadastrados?
SELECT COUNT(*) AS Total_Clientes FROM Client;


-- 3. Quantos pedidos foram feitos por cada cliente?
SELECT 
    c.idClient,
    CONCAT(p.FirstName, ' ', p.LastName) AS Nome_Cliente,
    COUNT(o.idOrder) AS Total_Pedidos
FROM Client c
LEFT JOIN Natural_Person np ON c.Natural_Person_idNaturalPerson = np.idNaturalPerson
LEFT JOIN Person p ON np.Person_idPerson = p.idPerson
LEFT JOIN Orders o ON c.idClient = o.Client_idClient
GROUP BY c.idClient, Nome_Cliente;


-- 4. Nome, id e email do fornecedor
SELECT 
    s.idSupplier,
    lp.CorporateName AS Nome_Empresa,
    p.Email
FROM Supplier s
JOIN Legal_Person lp ON s.Legal_Person_idLegalPerson = lp.idLegalPerson
JOIN Person p ON lp.Person_idPerson = p.idPerson;


-- 5. Algum vendedor também é fornecedor?
SELECT 
    s.idSeller,
    s.Name AS Vendedor,
    f.idSupplier AS Fornecedor
FROM Seller s
JOIN Supplier f ON s.Legal_Person_idLegalPerson = f.Legal_Person_idLegalPerson;


-- 6. Relação de produtos, fornecedores e estoques
SELECT 
    p.Name AS Produto,
    s.idSupplier AS Fornecedor,
    ps.AvailableQuantity AS Quantidade,
    st.Location AS Estoque
FROM Supplier_Product sp
JOIN Supplier s ON sp.Supplier_idSupplier = s.idSupplier
JOIN Product p ON sp.Product_idProduct = p.idProduct
JOIN Product_Stock ps ON ps.Product_idProduct = p.idProduct
JOIN Stock st ON ps.Stock_idStock = st.idStock;


-- 7. Relação de nomes dos fornecedores e nomes dos produtos
SELECT 
    s.idSupplier,
    per.FirstName AS Nome_Fornecedor,
    p.Name AS Produto
FROM Supplier s
JOIN Legal_Person lp ON s.Legal_Person_idLegalPerson = lp.idLegalPerson
JOIN Person per ON lp.Person_idPerson = per.idPerson
JOIN Supplier_Product sp ON s.idSupplier = sp.Supplier_idSupplier
JOIN Product p ON sp.Product_idProduct = p.idProduct;

-- 8. Valor total de cada pedido
SELECT 
    o.idOrder, 
    SUM(op.Quantity * op.UnitPrice) AS Valor_Total
FROM Orders o
JOIN Order_Product op ON o.idOrder = op.Order_idOrder
GROUP BY o.idOrder;

-- 9. Listar pedidos que ainda não foram entregues
SELECT 
    o.idOrder, 
    d.DeliveryStatus, 
    s.ShippingStatus
FROM Orders o
LEFT JOIN Delivery d ON o.idOrder = d.Order_idOrder
LEFT JOIN Shipping s ON o.idOrder = s.Order_idOrder
WHERE d.DeliveryStatus IS NULL OR d.DeliveryStatus != 'Delivered';


-- 10. Quantidade de produtos em estoque por fornecedor
SELECT 
    s.idSupplier,
    SUM(ps.AvailableQuantity) AS Quantidade_Em_Estoque
FROM Supplier s
JOIN Supplier_Product sp ON s.idSupplier = sp.Supplier_idSupplier
JOIN Product_Stock ps ON sp.Product_idProduct = ps.Product_idProduct
GROUP BY s.idSupplier;

-- 11. Clientes que fizeram ao menos um pedido
SELECT 
    c.idClient,
    CONCAT(p.FirstName, ' ', p.LastName) AS Nome_Cliente,
    COUNT(o.idOrder) AS Total_Pedidos
FROM Client c
JOIN Orders o ON c.idClient = o.Client_idClient
JOIN Natural_Person np ON c.Natural_Person_idNaturalPerson = np.idNaturalPerson
JOIN Person p ON np.Person_idPerson = p.idPerson
GROUP BY c.idClient, Nome_Cliente;

-- 12. Produtos mais vendidos
SELECT 
    p.idProduct,
    p.Name AS Produto,
    SUM(op.Quantity) AS Total_Vendido
FROM Order_Product op
JOIN Product p ON op.Product_idProduct = p.idProduct
GROUP BY p.idProduct, p.Name
ORDER BY Total_Vendido DESC;

-- 13. Pedidos e suas formas de pagamento
SELECT 
    o.idOrder,
    o.Client_idClient,
    o.Description,
    GROUP_CONCAT(p.PaymentMethod SEPARATOR ', ') AS Formas_Pagamento
FROM Orders o
JOIN Payment p ON o.idOrder = p.Order_idOrder
GROUP BY o.idOrder, o.Client_idClient, o.Description;





