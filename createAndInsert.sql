-- Создание таблиц
CREATE TABLE MyRole (
    id BIGSERIAL PRIMARY KEY,
    Type VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL
);

CREATE TABLE MyUser (
    id BIGSERIAL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    SecondName VARCHAR(255) NOT NULL,
    LoginName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    PaymentInfo TEXT NOT NULL,
    RoleId BIGINT NOT NULL REFERENCES MyRole(id)
);

CREATE TABLE Manufacturer (
    id BIGSERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL
);

CREATE TABLE Supplier (
    id BIGSERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    PaymentAddress TEXT NOT NULL,
    Contract TEXT NOT NULL
);

CREATE TABLE Category (
    id BIGSERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Product (
    id BIGSERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Quantity BIGINT NOT NULL,
    Description TEXT NOT NULL,
    Price BIGINT NOT NULL,
    ManufacturerId BIGINT NOT NULL REFERENCES Manufacturer(id),
    SupplierId BIGINT NOT NULL REFERENCES Supplier(id),
    CategoryId BIGINT NOT NULL REFERENCES Category(id)
);

CREATE TABLE Favorite (
    id BIGSERIAL PRIMARY KEY,
    CustomerId BIGINT NOT NULL REFERENCES MyUser(id)
);

CREATE TABLE ProductsInFavorite (
    ProductId BIGINT NOT NULL REFERENCES Product(id),
    FavoriteId BIGINT NOT NULL REFERENCES Favorite(id),
    PRIMARY KEY (ProductId, FavoriteId)
);

CREATE TABLE ShoppingCart (
    id BIGSERIAL PRIMARY KEY,
    CustomerId BIGINT NOT NULL REFERENCES MyUser(id)
);

CREATE TABLE ProductsInCart (
    ProductId BIGINT NOT NULL REFERENCES Product(id),
    ShoppingCartId BIGINT NOT NULL REFERENCES ShoppingCart(id),
    Quantity BIGINT NOT NULL,
    PRIMARY KEY (ProductId, ShoppingCartId)
);

CREATE TABLE MyOrder (
    id BIGSERIAL PRIMARY KEY,
    UserId BIGINT NOT NULL REFERENCES MyUser(id),
    DeliveryId BIGINT NOT NULL,
    Status VARCHAR(255) NOT NULL,
    TotalCost BIGINT NOT NULL,
    Comment TEXT NOT NULL
);

CREATE TABLE Delivery (
    id BIGSERIAL PRIMARY KEY,
    OrderId BIGINT NOT NULL REFERENCES MyOrder(id),
    ArrivalDate TIMESTAMP NOT NULL,
    DeliveryType VARCHAR(255) NOT NULL,
    Address TEXT NOT NULL,
    Cost BIGINT NOT NULL
);

CREATE TABLE ProductInOrder (
    OrderId BIGINT NOT NULL REFERENCES MyOrder(id),
    ProductId BIGINT NOT NULL REFERENCES Product(id),
    Quantity BIGINT NOT NULL,
    PRIMARY KEY (OrderId, ProductId)
);

CREATE TABLE Review (
    id BIGSERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    ProductId BIGINT NOT NULL REFERENCES Product(id),
    UserId BIGINT NOT NULL REFERENCES MyUser(id)
);

-- Роли
INSERT INTO MyRole (Type, Description) VALUES
('Админ', 'Полный доступ к управлению магазином'),
('Покупатель', 'Может просматривать каталог товаров и оформлять заказы');

-- Пользователи
INSERT INTO MyUser (FirstName, SecondName, LoginName, Email, PhoneNumber, PaymentInfo, RoleId) VALUES
('Иван', 'Иванов', 'ivan_ivanov', 'ivan@example.com', '89001234567', 'Visa 1234', 2),
('Админ', 'Системы', 'admin', 'admin@example.com', '89007654321', 'MasterCard 5678', 1);

-- Производители
INSERT INTO Manufacturer (Name, Email) VALUES
('ASUS', 'contact@asus.com'),
('Dell', 'support@dell.com');

-- Поставщики
INSERT INTO Supplier (Name, Email, PaymentAddress, Contract) VALUES
('ТехноПоставщик', 'info@techdist.com', 'ул. Технологическая, д. 123', 'Договор №123'),
('ГигаПоставщик', 'sales@gigasupplier.com', 'пр. Гигабайт, д. 456', 'Договор №456');

-- Категории
INSERT INTO Category (Name) VALUES
('Ноутбуки'),
('Мониторы'),
('Аксессуары');

-- Продукты
INSERT INTO Product (Name, Quantity, Description, Price, ManufacturerId, SupplierId, CategoryId) VALUES
('Игровой ноутбук ASUS ROG', 10, 'Высокопроизводительный игровой ноутбук', 150000, 1, 1, 1),
('Монитор Dell UltraSharp', 20, '27-дюймовый 4K монитор', 50000, 2, 2, 2),
('Беспроводная мышь', 50, 'Эргономичная беспроводная мышь', 2000, 1, 1, 3);

-- Избранное
INSERT INTO Favorite (CustomerId) VALUES
(1);

INSERT INTO ProductsInFavorite (ProductId, FavoriteId) VALUES
(1, 1),
(3, 1);

-- Корзина
INSERT INTO ShoppingCart (CustomerId) VALUES
(1);

INSERT INTO ProductsInCart (ProductId, ShoppingCartId, Quantity) VALUES
(1, 1, 1),
(2, 1, 2);

-- Заказы
INSERT INTO MyOrder (UserId, DeliveryId, Status, TotalCost, Comment) VALUES
(1, 1, 'В ожидании', 200000, 'Доставьте как можно быстрее');

INSERT INTO Delivery (OrderId, ArrivalDate, DeliveryType, Address, Cost) VALUES
(1, '2024-11-25 10:00:00', 'Курьер', 'ул. Ленина, д. 1', 500);

INSERT INTO ProductInOrder (OrderId, ProductId, Quantity) VALUES
(1, 1, 1),
(1, 2, 2);

-- Отзывы
INSERT INTO Review (Title, Description, Rating, ProductId, UserId) VALUES
('Отличный ноутбук', 'Производительность на высоте!', 5, 1, 1),
('Хороший монитор', 'Четкость и цветопередача на уровне.', 4, 2, 1);
