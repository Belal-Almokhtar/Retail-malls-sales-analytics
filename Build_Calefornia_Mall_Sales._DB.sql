Create database Calefornia_Mall_Sales;
ALTER TABLE Customers
alter column customer_id varchar(20) not null;

Alter table Customers
Add constraint PK_custom primary key (customer_id);


select * from Sales;
alter table Sales
alter column invoice_no Varchar(50) not null;
alter table Sales
Add constraint pk_Sales primary key (invoice_no);

select * from Shopping_Mall;
alter table Shopping_Mall
alter column shopping_mall varchar(90) not null;
alter table Shopping_Mall
Add constraint pk_shop primary key (shopping_mall);
-- ----------------------------------------------------------------
alter table Sales
alter column shop_mall varchar(90) null;

alter table Sales
add foreign key (shop_mall) references Shopping_Mall(shopping_mall);


-- ---------------------------------------------------------
alter table Sales 
alter column customer_id varchar(20) ;

alter table Sales 
add foreign key (customer_id) references Customers(customer_id);
-- --------------------------------------------------------------
select * from Shopping_Mall
where shopping_mall is null;
update Sales
set shop_mall = 'Irvine Spectrum Center'
where shop_mall = 'Irvine Spectrum';

