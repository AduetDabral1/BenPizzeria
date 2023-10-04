-- BEN's PIZZERIA

CREATE DATABASE pizza_shop;
USE pizza_shop;

CREATE TABLE `Orders` (
    `row_id` int  NOT NULL ,
    `order_id` varchar(10)  NOT NULL ,
    `cust_id` int  NOT NULL ,
    `created_date` date NOT NULL,
    `created_at` time  NOT NULL,
    `item_id` varchar(15)  NOT NULL ,
    `quantity` int  NOT NULL ,
    `delivery` boolean  NOT NULL ,
    `add_id` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `Customers` (
    `customer_id` int  NOT NULL ,
    `customer_first_name` varchar(50)  NOT NULL ,
    `customer_last_name` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `customer_id`
    )
);

CREATE TABLE `Address` (
    `address_id` int  NOT NULL ,
    `delivery_address1` varchar(200)  NOT NULL ,
    `delivery_address2` varchar(200)  NULL ,
    `delivery_city` varchar(50)  NOT NULL ,
    `delivery_zipcode` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `address_id`
    )
);

CREATE TABLE `Items` (
    `item_id` varchar(15)  NOT NULL ,
    `item_sku` varchar(50)  NOT NULL UNIQUE,
    `item_name` varchar(50)  NOT NULL ,
    `item_category` varchar(50)  NOT NULL ,
    `item_size` varchar(20)  NOT NULL ,
    `item_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `item_id`
    )
);

CREATE TABLE `Ingredients` (
    `ing_id` varchar(20)  NOT NULL ,
    `ing_name` varchar(20)  NOT NULL ,
    `ing_weight` int  NOT NULL ,
    `ing_measurements` varchar(20)  NOT NULL ,
    `ing_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `ing_id`
    )
);

CREATE TABLE `Recipe` (
    `row_id` int  NOT NULL ,
    `recipe_id` varchar(50)  NOT NULL ,
    `ing_id` varchar(20)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `Inventory` (
    `inv_id` int  NOT NULL ,
    `item_id` varchar(20)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `inv_id`
    )
);

CREATE TABLE `Staff` (
    `staff_id` varchar(10)  NOT NULL ,
    `fist_name` varchar(30)  NOT NULL ,
    `last_name` varchar(30)  NOT NULL ,
    `position` varchar(20)  NOT NULL ,
    `hourly_rate` decimal(6,2)  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    )
);

CREATE TABLE `Shifts` (
    `shift_id` varchar(10)  NOT NULL ,
    `day_of_the_week` varchar(10)  NOT NULL ,
    `start_time` time  NOT NULL ,
    `end_time` time  NOT NULL ,
    PRIMARY KEY (
        `shift_id`
    )
);

CREATE TABLE `Rotations` (
    `row_id` int  NOT NULL ,
    `rota_id` varchar(10)  NOT NULL ,
    `date` datetime  NOT NULL ,
    `shift_id` varchar(10)  NOT NULL ,
    `staff_id` varchar(10)  NOT NULL 
);

ALTER TABLE `Orders` ADD CONSTRAINT `fk_Orders_cust_id` FOREIGN KEY(`cust_id`)
REFERENCES `Customers` (`customer_id`);

ALTER TABLE `Rotations` ADD CONSTRAINT `fk_Rotations_date` FOREIGN KEY(`date`)
REFERENCES `Orders` (`created_at`);

ALTER TABLE `Orders` ADD CONSTRAINT `fk_Orders_item_id` FOREIGN KEY(`item_id`)
REFERENCES `Items` (`item_id`);

ALTER TABLE `Orders` ADD CONSTRAINT `fk_Orders_add_id` FOREIGN KEY(`add_id`)
REFERENCES `Address` (`address_id`);

ALTER TABLE `Recipe` ADD CONSTRAINT `fk_Recipe_recipe_id` FOREIGN KEY(`recipe_id`)
REFERENCES `Items` (`item_sku`);

ALTER TABLE `Recipe` ADD CONSTRAINT `fk_Recipe_ing_id` FOREIGN KEY(`ing_id`)
REFERENCES `Ingredients` (`ing_id`);

ALTER TABLE `Inventory` ADD CONSTRAINT `fk_Inventory_item_id` FOREIGN KEY(`item_id`)
REFERENCES `Recipe` (`ing_id`);

ALTER TABLE `Rotations` ADD CONSTRAINT `fk_Rotations_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `Shifts` (`shift_id`);

ALTER TABLE `Rotations` ADD CONSTRAINT `fk_Rotations_staff_id` FOREIGN KEY(`staff_id`)
REFERENCES `Staff` (`staff_id`);


ALTER TABLE `Orders` DROP CONSTRAINT fk_Orders_cust_id;

ALTER TABLE `Rotations` DROP CONSTRAINT fk_Rotations_date;

ALTER TABLE `Orders` DROP CONSTRAINT fk_Orders_item_id;

ALTER TABLE `Orders` DROP CONSTRAINT fk_Orders_add_id;

ALTER TABLE `Recipe` DROP CONSTRAINT fk_Recipe_recipe_id;

ALTER TABLE `Recipe` DROP CONSTRAINT fk_Recipe_ing_id;

ALTER TABLE `Inventory` DROP CONSTRAINT fk_Inventory_item_id;

ALTER TABLE `Rotations` DROP CONSTRAINT fk_Rotations_shift_id;

ALTER TABLE `Rotations` DROP CONSTRAINT fk_Rotations_staff_id;
