-- Second Dashboard

SELECT 
    o.item_id,
    i.item_sku,
    i.item_name,
    SUM(o.quantity) AS order_quantity
FROM
    Orders o
        LEFT JOIN
    Items i ON o.item_id = i.item_id
GROUP BY o.item_id , i.item_sku , i.item_name
ORDER BY o.item_id;


-- Total quantity by ingredients
SELECT 
    o.item_id,
    i.item_sku,
    i.item_name,
    r.ing_id,
    ing.ing_name,
    r.quantity AS recipe_quantity,
    SUM(o.quantity) AS order_quantity
FROM
    Orders o
        LEFT JOIN
    Items i ON o.item_id = i.item_id
        LEFT JOIN
    Recipe r ON i.item_sku = r.recipe_id
        LEFT JOIN
    Ingredients ing ON ing.ing_id = r.ing_id
GROUP BY o.item_id , i.item_sku , i.item_name , r.ing_id , r.quantity , ing.ing_name
ORDER BY o.item_id;


-- Total quantity and cost of ingredients
SELECT 
    o.item_id,
    i.item_sku,
    i.item_name,
    r.ing_id,
    ing.ing_name,
    r.quantity AS recipe_quantity,
    SUM(o.quantity) AS order_quantity,
    ing.ing_weight,
    ing.ing_price
FROM
    Orders o
        LEFT JOIN
    Items i ON o.item_id = i.item_id
        LEFT JOIN
    Recipe r ON i.item_sku = r.recipe_id
        LEFT JOIN
    Ingredients ing ON ing.ing_id = r.ing_id
GROUP BY o.item_id , i.item_sku , i.item_name , r.ing_id , r.quantity , ing.ing_name , ing.ing_weight , ing.ing_price
ORDER BY o.item_id;


-- Total quantity and cost of ingredients with calculated cost of the item
-- Creating a view of the above query

create view Stock1 as 
SELECT 
    s1.item_name,
    s1.ing_id,
    s1.ing_name,
    s1.ing_weight,
    s1.ing_price,
    s1.order_quantity,
    s1.recipe_quantity,
    (s1.order_quantity * s1.recipe_quantity) AS ordered_weight,
    (s1.ing_price / s1.ing_weight) AS unit_cost,
    ((s1.order_quantity * s1.recipe_quantity) * (s1.ing_price / s1.ing_weight)) AS ingredient_cost
FROM
    (SELECT 
        o.item_id,
            i.item_sku,
            i.item_name,
            r.ing_id,
            ing.ing_name,
            r.quantity AS recipe_quantity,
            SUM(o.quantity) AS order_quantity,
            ing.ing_weight,
            ing.ing_price
    FROM
        Orders o
    LEFT JOIN Items i ON o.item_id = i.item_id
    LEFT JOIN Recipe r ON i.item_sku = r.recipe_id
    LEFT JOIN Ingredients ing ON ing.ing_id = r.ing_id
    GROUP BY o.item_id , i.item_sku , i.item_name , r.ing_id , r.quantity , ing.ing_name , ing.ing_weight , ing.ing_price
    ORDER BY o.item_id) s1;
    
select * from pizza_shop.stock1;

-- Now we have to figure out:
-- a. Total weight ordered
-- b. Inventory Amount
-- c. Inventory remaining per ingredient

select s2.ing_name, s2.ordered_weight,
ing.ing_weight * inv.quantity as total_inv_weight,
(ing.ing_weight * inv.quantity) - s2.ordered_weight as remaining_weight
 from
( SELECT
	ing_id,
	ing_name,
    sum(ordered_weight) as ordered_weight
from
	Stock1
    group by ing_name,ing_id ) s2
LEFT JOIN Inventory inv ON inv.item_id = s2.ing_id
LEFT JOIN ingredients ing ON ing.ing_id = s2.ing_id;