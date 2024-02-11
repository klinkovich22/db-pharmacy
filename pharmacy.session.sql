CREATE TABLE medicines(
  id serial PRIMARY KEY,
  name varchar(500) NOT NULL CHECK (name<>''),
  active_substance varchar(500) NOT NULL CHECK (active_substance<>''),
  dosage numeric(10,2) NOT NULL CHECK(dosage>0),
  price numeric(15,2) NOT NULL CHECK(price>0),
  quantity int NOT NULL CHECK(quantity>=0)
);

CREATE TABLE addresses (
  id serial PRIMARY KEY,
  town varchar(300) NOT NULL CHECK(town<>''),
  area varchar(300) NOT NULL CHECK(area<>''),
  street varchar(300) NOT NULL CHECK(street<>''),
  building varchar(20) NOT NULL CHECK(building<>'')
);


CREATE TABLE pharmacies (
  id serial PRIMARY KEY,
  name varchar(300) NOT NULL CHECK(name<>''),
  address_id int NOT NULL REFERENCES addresses(id),
  phone varchar(20) NOT NULL CHECK(phone<>'')
);

CREATE TABLE pharmacy_to_medicine (
  pharmacy_id int REFERENCES pharmacies(id),
  medicine_id int REFERENCES medicines(id),
  PRIMARY KEY (pharmacy_id, medicine_id)
);

CREATE TABLE customers(
  id serial PRIMARY KEY,
  first_name varchar(300) NOT NULL CHECK(first_name<>''),
  last_name varchar(300) NOT NULL CHECK(last_name<>''),
  address_id int REFERENCES addresses(id),
  phone varchar(20) NOT NULL CHECK(phone<>'')
);

CREATE TABLE orders (
  id serial PRIMARY KEY,
  customer_id int REFERENCES customers(id)
);

CREATE TABLE order_to_medecine (
  order_id int REFERENCES orders(id),
  medicine_id int REFERENCES medicines(id),
  pharmacy_id int REFERENCES pharmacies(id),
  quantity int NOT NULL CHECK(quantity>0),
  FOREIGN KEY(medicine_id, pharmacy_id) REFERENCES pharmacy_to_medicine(medicine_id, pharmacy_id),
  PRIMARY KEY (order_id, medicine_id)
);


INSERT INTO medicines (name, active_substance, dosage, price, quantity) VALUES
('Flucanazol', 'Flukanaz', 100, 15.45, 50),
('Citramon', 'Paracetamol', 35.5, 20.75, 148), 
('Cetrin', 'Paracetamol', 70, 70, 500);

INSERT INTO addresses (town, area, street, building) VALUES
('Ternovka', 'Pavlogradskiy', 'Dniprovskaya', '5'), 
('Dnipro', 'Levoberezhniy', 'Panikahi', '7a'), 
('Harkiv', 'Shevchik', 'Lermontova', '24b'), 
('Kiyv', 'Darnickiy', 'Harkovskoe shosse', '8');

INSERT INTO pharmacies (name, address_id, phone) VALUES
('Mother and child', 1, '0958857172'), 
('Ledi Bug', 3, '0675718259');

INSERT INTO pharmacy_to_medicine (pharmacy_id, medicine_id) VALUES
(1, 1), (1, 3), (2, 2), (2, 3);

INSERT INTO customers (first_name, last_name, address_id, phone) VALUES
('Andriy', 'Danilenko', 2, '0751861112'), 
('Dima', 'Zubarev', 4, '0658459691'), 
('Polina', 'Nazarenko', NULL, '0852470159');


INSERT INTO orders (customer_id) VALUES
(1), (2), (3);

INSERT INTO order_to_medecine (order_id, medicine_id, pharmacy_id, quantity) VALUES
(1, 1, 1, 10), (2, 3, 1, 5), (3, 3, 1, 5);
