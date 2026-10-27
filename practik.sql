DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    stock INTEGER DEFAULT 0 CHECK (stock >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    category_id INTEGER NOT NULL REFERENCES categories(id)
);
-- # связанно с целостностью данных


INSERT INTO categories (name) VALUES 
('Электроника'),
('Книги'),
('Аксессуары');

INSERT INTO products (name, price, stock, category_id) VALUES 
('Ноутбук', 85000.00, 10, 1),
('Смартфон', 45000.00, 25, 1),
('Наушники беспроводные', 7500.00, 50, 1),
('Изучаем SQL', 1200.00, 15, 2),
('Руководство по PostgreSQL', 1800.00, 8, 2),
('Мышь беспроводная', 2500.00, 30, 3),
('Клавиатура механика', 4500.00, 12, 3),
('Коврик для мыши', 800.00, 100, 3);


SELECT name, price 
FROM products 
WHERE price > 3000 
ORDER BY price DESC;


UPDATE products 
SET price = price * 1.10 
WHERE name = 'Ноутбук';


INSERT INTO products (name, price, stock, category_id) 
VALUES ('Тестовый товар', 500.00, 1, 3);

DELETE FROM products 
WHERE name = 'Тестовый товар';


INSERT INTO products (name, price, stock, category_id) 
VALUES ('Сломанный товар', -100.00, 5, 1);

INSERT INTO products (name, price, stock, category_id) 
VALUES ('Исправленный товар', 1500.00, 5, 1);

SELECT price FROM products WHERE name = 'Смартфон';
BEGIN;
UPDATE products SET price = price + 500 WHERE name = 'Смартфон';
SELECT price FROM products WHERE name = 'Смартфон';
ROLLBACK;
SELECT price FROM products WHERE name = 'Смартфон';
BEGIN;
UPDATE products SET price = price + 500 WHERE name = 'Смартфон';
COMMIT;
SELECT price FROM products WHERE name = 'Смартфон';
 -- из за объема 