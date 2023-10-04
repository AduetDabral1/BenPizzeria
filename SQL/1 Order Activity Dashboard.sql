-- First Dashboard
use pizza_Shop;
select 
o.order_id, i.item_price, o.quantity, i.item_category,
i.item_name, o.created_at, o.created_date,  a.delivery_address1, a.delivery_address2, a.delivery_city,
a.delivery_zipcode, o.delivery
from Orders o
LEFT JOIN Items i ON o.item_id = i.item_id
LEFT JOIN Address a ON o.add_id = a.address_id;