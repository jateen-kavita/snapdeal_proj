create schema snapdeal;

set search_path to snapdeal;

create table if not exists orderlist(
orderId varchar,
orderDate text,
CustomerName varchar,
State varchar,
City varchar
)

drop table if exists orderlist;

select * 
from orderlist
;

UPDATE orderlist
SET orderdate = TO_CHAR(TO_DATE(orderdate, 'DD/MM/YY'), 'DD/MM/YYYY')
WHERE LENGTH(orderdate) < 10;

alter table orderlist
alter column orderDate
type date
using to_date(orderDate,'dd-mm-yyyy')

create table if not exists orderDetails(
Order_ID varchar,
Amount integer,
Profit integer,
Quantity integer,
Category varchar,
SubCategory varchar
)

select *
from orderDetails
;

create table if not exists salesTarget(
monthOfOrder text,
Category varchar,
Target integer
)

alter table salesTarget
alter column monthOfOrder
type date
using to_date(monthOfOrder,'yyyy/mm/dd')

UPDATE salestarget
SET monthoforder = TO_DATE(monthoforder, 'Mon-YY');


select *
from salesTarget
;

-- 1. Best-Performing Product Categories
with ordercte as (
select 
od.category,sum(od.amount) as total_revenue
from orderdetails od
inner join orderlist ol
on od.order_id = ol.orderid
where extract(month from ol.orderdate)=04 and extract(year from ol.orderdate)=2018
group by od.category
),
targetcte as (
select oc.category,oc.total_revenue,sum(st.target) as target_revenue
from ordercte oc
inner join salestarget st
on oc.category=st.category
where extract(month from st.monthOfOrder)=04 and extract(year from st.monthOfOrder)=2018
group by oc.category,oc.total_revenue
)
select category,total_revenue,target_revenue
from targetcte		
order by target_revenue desc
;


-- 2.Customer Purchase Behavior by Location
select state,count(distinct orderid) as total_orders
from orderlist
group by state
order by total_orders desc
limit 3
;

-- 3. High Revenue, Low Profit Products
with revenueCTE as (
select category,subcategory,sum(amount) as total_revenue,sum(profit) as total_profit
from orderdetails
group by category,subcategory
order by category asc
)
select category,subcategory,total_revenue,total_profit,round((total_profit*100.0/total_revenue),2)as profit_margin,
case
	when round((total_profit*100.0/total_revenue),2)>=5.0 then 'High Margin Category'
	else 'Low Margin Category'
end as profit_margin_category
from revenueCTE
where total_revenue>10000
;

--4. Products with Highest Profit per Sale
select category,subcategory,sum(profit) as Total_Profit,sum(quantity) as Total_Quantity,round(sum(profit)*1.0/sum(quantity),2)as profit_per_unit
from orderdetails
group by category,subcategory
order by profit_per_unit desc
;


--5.Set Operations for Category Comparison
select ol.customername,count(distinct od.category)Unique_Categories
from orderlist ol
inner join orderdetails od
on ol.orderid = od.order_id
group by ol.customername
having count(distinct od.category)>1
order by Unique_Categories desc
;

--6. Product Revenue Comparison
with mainCTE as (
select category,subcategory,sum(amount) as total_revenue
from orderdetails
group by category,subcategory
),
avgCTE as (
select category,round(avg(total_revenue),2) as avg_revenue
from mainCTE
group by category
)s
select mcte.category,mcte.subcategory,mcte.total_revenue,acte.avg_revenue
from avgCTE acte
inner join mainCTE mcte
on acte.category = mcte.category
where mcte.total_revenue>acte.avg_revenue
order by mcte.total_revenue desc
;
