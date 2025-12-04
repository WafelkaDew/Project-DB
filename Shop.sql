CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    recommended_by INT,
    FOREIGN KEY (recommended_by) REFERENCES Customers(customer_id)
);

-- Создание таблицы Товаров
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Создание таблицы Заказов
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Создание таблицы Состава Заказа
CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Наполнение таблиц данными
INSERT INTO Customers (customer_id, full_name, email, registration_date, recommended_by) VALUES
(1, 'Иван Иванов', 'ivan.ivanov@example.com', '2023-01-15', NULL),
(2, 'Мария Петрова', 'maria.petrova@example.com', '2023-02-20', 1),
(3, 'Алексей Смирнов', 'alex.smirnov@example.com', '2023-03-10', 1),
(4, 'Елена Васильева', 'elena.v@example.com', '2023-04-01', 2),
(5, 'Андрей Николаев', 'andrey.n@example.com', '2023-05-01', NULL);

INSERT INTO Products (product_name, category, price) VALUES
('Смартфон', 'Электроника', 70000.00),
('Ноутбук', 'Электроника', 120000.00),
('Кофемашина', 'Бытовая техника', 25000.00),
('Книга "Основы SQL"', 'Книги', 1500.00),
('Фен', 'Бытовая техника', 4500.00),
('Пылесос', 'Бытовая техника', 15000.00);

INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2024-05-10', 'Доставлен'),
(2, '2024-05-12', 'В обработке'),
(1, '2024-05-15', 'Отправлен'),
(3, '2024-05-16', 'Доставлен');

INSERT INTO Order_Items (order_id, product_id, quantity, price_per_unit) VALUES
(1, 1, 1, 70000.00),  -- Иван купил Смартфон
(1, 4, 2, 1400.00),   -- и 2 книги
(2, 2, 1, 120000.00), -- Мария купила Ноутбук
(3, 3, 1, 25000.00),  -- Иван купил Кофемашину
(4, 1, 1, 70000.00),  -- Алексей купил Смартфон
(4, 5, 1, 4500.00);   -- и Фен


SELECT
    c.full_name,
    o.order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;


SELECT
    c.full_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE order_id is null;

SELECT
    p.product_name,
    o.quantity,
    o.price_per_unit
FROM order_items c 
FROM 
RIGHT JOIN Orders o ON o.order_id = o.order_id
where order_id = 1;


Задание 3: Состав конкретного заказа (Multi-JOIN)
Напишите запрос для вывода всех позиций заказа с 
`order_id = 1`. Результат должен включать название товара 
(`product_name`), количество (`quantity`) и цену за единицу 
(`price_per_unit`).

Задание 4: Покупатели определенного товара (Подзапрос с IN)
С помощью подзапроса найдите имена всех покупателей, которые заказывали 'Смартфон'.

Задание 5: Дорогие товары (Скалярный подзапрос)
Напишите запрос, который находит все товары, цена которых выше средней цены всех товаров в магазине.

Задание 6: Заказы с дорогими товарами (Коррелирующий подзапрос c EXISTS)
Используя коррелирующий подзапрос с оператором `EXISTS`, найдите все заказы (`order_id`, `order_date`), которые содержат хотя бы один товар дороже 100 000.

Задание 7 (со звездочкой): Сравнение подходов
Найдите всех покупателей, которые НЕ заказывали 'Ноутбук'. Решите эту задачу двумя способами:

Используя `LEFT JOIN`.
Используя подзапрос с `NOT IN`.
Задание 8: Товары, которые еще никто не заказывал (RIGHT JOIN или LEFT JOIN с IS NULL)
Найдите все товары, которые еще ни разу не были заказаны. Выведите их названия. Решите задачу, используя `RIGHT JOIN` (или `LEFT JOIN` с соответствующим условием).

Задание 9: Полный список активности (FULL OUTER JOIN)
Выведите полный список всех покупателей, всех товаров и все их заказы. Включите покупателей, которые не делали заказов, и товары, которые не были заказаны. Для записей без совпадений должны быть `NULL` значения. Выведите имя покупателя, название товара и количество.

Задание 10: Покупатели, купившие самый дорогой товар (JOIN vs Подзапрос)
Найдите имена покупателей, которые купили самый дорогой товар. Решите задачу двумя способами:

Используя `JOIN` с подзапросом.
Используя только подзапросы (без явного `JOIN` в основном запросе, если возможно).
Задание 11: Все возможные пары "покупатель-категория" (CROSS JOIN)
Напишите запрос, который выведет все возможные комбинации имен покупателей и категорий товаров. Это может быть полезно для создания отчета, где нужно показать все возможные варианты, даже если покупок в данной категории не было.

Задание 12: Кто кого порекомендовал (SELF JOIN)
Используя `SELF JOIN` на таблице `Customers`,
 выведите список покупателей и тех, 
кто их порекомендовал. Результат должен содержать два
 столбца: `new_customer` (имя нового покупателя) и `recommended_by` 
 (имя того, кто его порекомендовал).