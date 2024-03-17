create database PizzaDeliverySystem;
use PizzaDeliverySystem;

create table INGREDIENT_SUPPLIER(
	Supplier_ID varchar(10) not null,
    Supplier_Name varchar(20),
    Phone varchar(10),
    Email varchar(50),
    Residential_No varchar(10),
    Street varchar(20),
    City varchar(20),
    primary key (Supplier_ID)
);


create table INGREDIENT_STOCK(
	Restaurant_ID varchar(10),
	IngredientID varchar(10),    
    Quantity_In_Stock integer
);

create table RESTAURANT(
	Restaurant_ID varchar(10) not null,
    Restaurant_Name varchar(20),
    Manager_ID varchar(10),
    Residential_No varchar(10),
    Street varchar(20),
    City varchar(20),
    primary key (Restaurant_ID)
);


create table RESTAURANT_PHONE_NUMBER(
	Restaurant_ID varchar(10),
    Phone varchar(10)
);


create table INGREDIENT(
	Ingredient_ID varchar(10) not null,
    Ingredient_Name varchar(20),
    Price_Per_Unit integer,
    Quantity_In_Stock integer,
    primary key (Ingredient_ID)
);


create table SUPPLIER(
	Ingredient_ID varchar(10),
    Supplier_ID varchar(10)
);


create table PIZZA(
	Pizza_ID varchar(10) not null,
    Pizza_Name varchar(20),
    Price integer,
    Size varchar(10),
    Category varchar(20),
    Promo_Code varchar(20),
    Descript varchar(50),
    primary key (Pizza_ID)
);


create table PIZZA_INGREDIENTS(
	Pizza_ID varchar(10),
    Ingredient_ID varchar(10)
);


create table RES_SCHEDULE(
	Restaurant_ID varchar(10),
    Opening_Time time,
    Closing_Time time
);


create table RESTAURANT_OPENING_DAYS(
	Restaurant_ID varchar(10),
    Open_days varchar(10)
);

create table PROMOTION(
	Promo_Code varchar(10) not null,
	Category varchar(20),
	Validity_Period varchar(10),
	Discount_Amount decimal(4,2),
	primary key(Promo_Code)
);



create table ORDERS(
	Order_ID varchar(10) not null,
    Order_Date date,
    Order_Time time,
    Customer_ID varchar(10),
    Pizza_ID varchar(10),
    Quantity integer,
    Promo_Code varchar(10),
    Total_Price decimal(7,2),
    Order_Status varchar(20),
    Residential_No varchar(10),
    Street varchar(20),
    City varchar(20),
    Estimated_Delivery_Time time,
    primary key (Order_ID)
);


create table CUSTOMER(
	Customer_ID varchar(10) not null,
    First_Name varchar(20),
    Last_Name varchar(20),
    Phone varchar(10),
    Email varchar(50),
    Residential_No varchar(10),
    Street varchar(20),
    City varchar(20),
    primary key (Customer_ID)
);


create table CUSTOMER_REVIEW(
	Customer_ID varchar(10),
    Descript varchar(50),
    Ratings integer
);



create table PAYMENT(
	Payment_ID varchar(10) not null,
    Order_ID varchar(10),
    Total_Price decimal(7,2),
    Payment_Date date,
    Payment_Method varchar(20),
    primary key (Payment_ID)
);

create table EMPLOYEE(
	Employee_ID varchar(10) not null,
    First_Name varchar(20),
    Last_Name varchar(20),
    Manager_ID varchar(10),
    Phone varchar(10),
    Age integer,
    Restaurant_ID varchar(10),
    Designation varchar(20),
    Salary integer,
    primary key (Employee_ID),
    foreign key(Manager_ID) references EMPLOYEE(Employee_ID)
);

create table DELIVERY(
	Delivery_ID varchar(10) not null,
    Order_ID varchar(10),
    Delivery_Person_ID varchar(10),
    Delivery_Status varchar(10),
    Residential_No varchar(10),
    Street varchar(20),
    City varchar(20),
    primary key (Delivery_ID)
);

create table DELIVERY_PERSON(
	Delivery_Person_ID varchar(10) not null,
    First_Name varchar(20),
    Last_Name varchar(20),
    Phone varchar(10),
    Licence_No varchar(20),
    Vehicle_No varchar(20),
    primary key (Delivery_Person_ID)
);


-- -------------------------------------------------------------------------------------------

alter table SUPPLIER add constraint FK1_Ingredient_ID 
foreign key(Ingredient_ID) references INGREDIENT(Ingredient_ID)
on delete set null on update cascade;

alter table SUPPLIER add constraint FK_Supplier_ID
foreign key(Supplier_ID) references INGREDIENT_SUPPLIER(Supplier_ID)
on delete set null on update cascade;

alter table INGREDIENT_STOCK add constraint FK1_Restaurant_ID
foreign key(Restaurant_ID) references RESTAURANT(Restaurant_ID)
on delete set null on update cascade;

alter table RESTAURANT_PHONE_NUMBER add constraint FK2_Restaurant_ID
foreign key(Restaurant_ID) references RESTAURANT(Restaurant_ID)
on delete set null on update cascade;

alter table PIZZA add constraint FK1_Promo_Code
foreign key(Promo_Code) references PROMOTION(Promo_Code)
on delete set null on update cascade;

alter table PIZZA_INGREDIENTS add constraint FK1_Pizza_ID
foreign key(Pizza_ID) references PIZZA(Pizza_ID)
on delete set null on update cascade;

alter table PIZZA_INGREDIENTS add constraint FK3_Ingredient_ID
foreign key(Ingredient_ID) references INGREDIENT(Ingredient_ID)
on delete set null on update cascade;

alter table RES_SCHEDULE add constraint FK3_Restaurant_ID 
foreign key(Restaurant_ID) references RESTAURANT(Restaurant_ID)
on delete set null on update cascade;

alter table RESTAURANT_OPENING_DAYS add constraint FK4_Restaurant_ID
foreign key(Restaurant_ID) references RESTAURANT(Restaurant_ID)
on delete set null on update cascade;

alter table ORDERS add constraint FK1_Customer_ID
foreign key(Customer_ID) references CUSTOMER(Customer_ID)
on delete set null on update cascade;

alter table ORDERS add constraint FK2_Promo_Code
foreign key(Promo_Code) references PROMOTION(Promo_Code)
on delete set null on update cascade;

alter table CUSTOMER_REVIEW add constraint FK2_Customer_ID
foreign key(Customer_ID) references CUSTOMER(Customer_ID)
on delete set null on update cascade;

alter table PAYMENT add constraint FK1_Order_ID
foreign key(Order_ID) references ORDERS(Order_ID)
on delete set null on update cascade;

alter table DELIVERY add constraint FK2_Order_ID
foreign key(Order_ID) references ORDERS(Order_ID)
on delete set null on update cascade;

alter table DELIVERY add constraint FK_Delivery_Person_ID
foreign key(Delivery_Person_ID) references DELIVERY_PERSON(Delivery_Person_ID)
on delete set null on update cascade;

alter table RESTAURANT add constraint FK_Manager_ID
foreign key(Manager_ID) references EMPLOYEE(Employee_ID) 
on delete set null on update cascade;

create table INGREDIENT_INGREDIENTSTOCK_Relation(     
Ingredient_ID varchar(10) NOT NULL, 
Restaurant_ID varchar(10) NOT NULL,    
PRIMARY KEY (Ingredient_ID, Restaurant_ID),     
constraint FK4_Ingredient_ID foreign key (Ingredient_ID) references INGREDIENT(Ingredient_ID),     
constraint FK6_Restaurant_ID foreign key (Restaurant_ID) references INGREDIENT_STOCK(Restaurant_ID)
);

create table PIZZA_RESTAURANT_RELATION(     
Pizza_ID varchar(10) NOT NULL, 
Restaurant_ID varchar(10) NOT NULL,    
PRIMARY KEY (Pizza_ID, Restaurant_ID),     
constraint FK_PIZZA foreign key (Pizza_ID) references PIZZA(Pizza_ID),     
constraint FK_RESTAURANT foreign key (Restaurant_ID) references RESTAURANT(Restaurant_ID)
);

create table INGREDIENT_INGREDIENTSUPPLIER_RELATION(     
Ingredient_ID varchar(10) NOT NULL, 
Supplier_ID varchar(10) NOT NULL,    
PRIMARY KEY (Ingredient_ID, Supplier_ID),     
constraint FK2_Ingredient_ID foreign key (Ingredient_ID) references INGREDIENT(Ingredient_ID),     
constraint FK1_Supplier_ID foreign key (Supplier_ID) references INGREDIENT_SUPPLIER(Supplier_ID)
);

create table PIZZA_ORDERS_RELATION(     
Pizza_ID varchar(10) NOT NULL, 
Order_ID varchar(10) NOT NULL,    
PRIMARY KEY (Pizza_ID, Order_ID),     
constraint FK3_Pizza_ID foreign key (Pizza_ID) references PIZZA(Pizza_ID),     
constraint FK3_Order_ID foreign key (Order_ID) references ORDERS(Order_ID)
);

create table PIZZA_INGREDIENT_RELATION(     
Pizza_ID varchar(10) NOT NULL, 
Ingredient_ID varchar(10) NOT NULL,    
PRIMARY KEY (Pizza_ID, Ingredient_ID),     
constraint FK4_Pizza_ID foreign key (Pizza_ID) references PIZZA(Pizza_ID),     
constraint FK5_Ingredient_ID foreign key (Ingredient_ID) references INGREDIENT(Ingredient_ID)
);

-- -------------------------------------------------------------------------------------------------------------------

insert into INGREDIENT_SUPPLIER (Supplier_ID, Supplier_Name, Phone, Email, Residential_No, Street, City)
values ('S001', 'Supplier_A', '0451122334', 'supplierA@gmail.com', 'No.S1', 'St1', 'Galle');
insert into INGREDIENT_SUPPLIER values ('S002', 'Supplier_B', '0451122448', 'supplierB@gmail.com', 'No.S2', 'St1', 'Galle');
insert into INGREDIENT_SUPPLIER values ('S003', 'Supplier_C', '0453366123', 'supplierC@gmail.com', 'No.S3', 'St2', 'Galle');
insert into INGREDIENT_SUPPLIER values ('S004', 'Supplier_D', '0459977546', 'supplierD@gmail.com', 'No.S4', 'St5', 'Matara');
insert into INGREDIENT_SUPPLIER values ('S005', 'Supplier_E', '0451345678', 'supplierE@gmail.com', 'No.S5', 'St5', 'Colombo');
insert into INGREDIENT_SUPPLIER values ('S006', 'Supplier_F', '0457695123', 'supplierF@gmail.com', 'No.S6', 'St6', 'Colombo');

insert into INGREDIENT (Ingredient_ID, Ingredient_Name, Price_Per_Unit, Quantity_In_Stock)
values ('I001', 'Ingredient 1', 20.50, 500);
insert into INGREDIENT values ('I002', 'Ingredient 2', 80.00, 750);
insert into INGREDIENT values ('I003', 'Ingredient 3', 560.00, 2200);
insert into INGREDIENT values ('I004', 'Ingredient 4', 220.50, 900);
insert into INGREDIENT values ('I005', 'Ingredient 5', 430.00, 1900);
insert into INGREDIENT values ('I006', 'Ingredient 6', 55.00, 1350);

insert into SUPPLIER (Ingredient_ID, Supplier_ID)
values ('I001', 'S001');   
insert into SUPPLIER values ('I002', 'S002');
insert into SUPPLIER values  ('I003', 'S003');
insert into SUPPLIER values  ('I004', 'S004');
insert into SUPPLIER values  ('I005', 'S005');
insert into SUPPLIER values  ('I006', 'S006');

insert into PROMOTION (Promo_Code, Category, Validity_Period, Discount_Amount)
values ('PROMO001', 'Classic', '30 days', 5.00);
insert into PROMOTION values ('PROMO002', 'Meat Lovers', '45 days', 7.50);
insert into PROMOTION values ('PROMO003', 'Vegetarian', '30 days', 6.00);
insert into PROMOTION values ('PROMO004', 'Specialty', '60 days', 8.00);
insert into PROMOTION values ('PROMO005', 'Classic', '45 days', 4.50);
insert into PROMOTION values ('PROMO006', 'Specialty', '30 days', 7.00);

insert into PIZZA (Pizza_ID, Pizza_Name, Price, Size, Category, Promo_Code, Descript)
values ('P001', 'Devilled Chicken', 1400, 'Medium', 'Classic', 'PROMO001', 'Classic Margherita Pizza');
insert into PIZZA values ('P002', 'Pepperoni', 2500, 'Large', '', 'PROMO002', 'Delicious Pepperoni Pizza');
insert into PIZZA values  ('P003', 'Veggie Deluxe', 1000, 'Medium', 'Vegetarian', 'PROMO003', 'Loaded Veggie Delight');
insert into PIZZA values  ('P004', 'BBQ Chicken', 2800, 'Large', 'Specialty', 'PROMO004', 'BBQ Chicken Sensation');
insert into PIZZA values ('P005', 'Hawaiian', 10.50, 'Medium', 'Classic', 'PROMO005', 'Classic Hawaiian Flavor');
insert into PIZZA values  ('P006', 'Sausage', 2400, 'Large', 'Specialty', 'PROMO006', 'Ultimate Supreme Pizza');

insert into PIZZA_INGREDIENTS (Pizza_ID, Ingredient_ID)
values('P001', 'I001');
insert into PIZZA_INGREDIENTS values('P001', 'I002');
insert into PIZZA_INGREDIENTS values('P001', 'I003');
insert into PIZZA_INGREDIENTS values('P002', 'I001');
insert into PIZZA_INGREDIENTS values('P002', 'I004');
insert into PIZZA_INGREDIENTS values('P003', 'I005');
insert into PIZZA_INGREDIENTS values('P003', 'I006');
insert into PIZZA_INGREDIENTS values('P004', 'I001');
insert into PIZZA_INGREDIENTS values('P004', 'I004');
insert into PIZZA_INGREDIENTS values('P005', 'I002');
insert into PIZZA_INGREDIENTS values('P005', 'I005');
insert into PIZZA_INGREDIENTS values('P006', 'I003');
insert into PIZZA_INGREDIENTS values('P006','I004');

insert into DELIVERY_PERSON (Delivery_Person_ID, First_Name, Last_Name, Phone, Licence_No, Vehicle_No)
values ('DP001', 'Kamal', 'Perera', '0771155462', 'DL001', 'Vehicle01');   
insert into DELIVERY_PERSON values ('DP002', 'John', 'Smith', '0774561238', 'DL002', 'Vehicle02');
insert into DELIVERY_PERSON values ('DP003', 'David', 'Black', '0778866495', 'DL003', 'Vehicle03');
insert into DELIVERY_PERSON values ('DP004', 'Amal', 'Silva', '0772233446', 'DL004', 'Vehicle04');
insert into DELIVERY_PERSON values('DP005', 'Ann', 'Brown', '0774433998', 'DL005', 'Vehicle05');
insert into DELIVERY_PERSON values('DP006', 'Jenny', 'Black', '0778822465', 'DL006', 'Vehicle06');

insert into CUSTOMER (Customer_ID, First_Name, Last_Name, Phone, Email, Residential_No, Street, City)
values ('C001', 'Sunil', 'Perera', '0774564564', 'sp@gmail.com', 'R007', 'St1', 'Matara');
insert into CUSTOMER values ('C002', 'Supun', 'Kalpana', '0767897897', 'jsk@gmail.com', 'R008', 'St2', 'Gampaha');
insert into CUSTOMER values ('C003', 'Nimal', 'Smith', '0711231231', 'ns@gmail.com', 'R009', 'Rd1', 'Gampaha');
insert into CUSTOMER values ('C004', 'Nimal', 'Perera', '0754564564', 'sarah.williams@email.com', 'R010', 'Rd2', 'Galle');
insert into CUSTOMER values ('C005', 'Minuri', 'Silva', '0721591591', 'np@gmail.com', 'R011', 'St23', 'Matara');
insert into CUSTOMER values ('C006', 'Eranda', 'Silva', '0774848484', 'es@gmail.com', 'R012', 'St6', 'Galle');

insert into ORDERS (Order_ID, Order_Date, Order_Time, Customer_ID, Pizza_ID, Quantity, Promo_Code, Total_Price, Order_Status, Residential_No, Street, City, Estimated_Delivery_Time)
values ('O001', '2023-09-01', '12:36:00', 'C001', 'P001', 2, 'PROMO001', 2020.00, 'Pending', 'No.25', 'St1', 'Matara', '13:45:00');
insert into ORDERS values ('O002', '2023-09-01', '13:45:00', 'C002', 'P002', 1, 'PROMO002', 1200.00, 'In Progress', 'No.5', 'St2', 'Gampaha', '14:56:00');
insert into ORDERS values ('O003', '2023-09-02', '09:15:00', 'C003', 'P003', 3, 'PROMO003', 3378.00, 'Delivered', 'No.14', 'Rd1', 'Gampaha', '10:36:00');
insert into ORDERS values ('O004', '2023-09-02', '15:27:00', 'C004', 'P004', 2, 'PROMO004', 247.00, 'In Progress', 'No.13', 'Rd2', 'Galle', '16:16:00');
insert into ORDERS values ('O005', '2023-09-03', '17:28:00', 'C005', 'P005', 1, 'PROMO005', 1005.50, 'Delivered', 'No.4', 'St23', 'Matara', '18:12:00');
insert into ORDERS values ('O006', '2023-09-05', '11:45:00', 'C006', 'P006', 2, 'PROMO006', 586.00, 'Pending', 'No.33', 'St6', 'Galle', '12:36:00');

insert into CUSTOMER_REVIEW (Customer_ID, Descript, Ratings)
values('C001', 'Great pizza!', 5);
insert into CUSTOMER_REVIEW values('C002', 'Awesome service', 4);
insert into CUSTOMER_REVIEW values('C003', 'Delicious and fast', 5);
insert into CUSTOMER_REVIEW values('C004', 'Good value', 4);
insert into CUSTOMER_REVIEW values('C005', 'Yummy pizza', 5);
insert into CUSTOMER_REVIEW values('C006', 'Quick delivery', 4);

insert into DELIVERY (Delivery_ID, Order_ID, Delivery_Person_ID, Delivery_Status, Residential_No, Street, City)
values   ('D001', 'O001', 'DP001', 'In Transit', 'No.D1', 'D.St1', 'Galle');  
insert into DELIVERY values ('D002', 'O002', 'DP002', 'Delivered', 'No.D2', 'D.St2', 'Hapugala');
insert into DELIVERY values ('D003', 'O003', 'DP003', 'Delivered', 'No.D33', 'D.St2', 'Galle');
insert into DELIVERY values ('D004', 'O004', 'DP003', 'In Transit', 'No.D4', 'D.St4', 'Hapugala');
insert into DELIVERY values ('D005', 'O005', 'DP005', 'Delivered', 'No.D2', 'D.St6', 'Matara');
insert into DELIVERY values ('D006', 'O006', 'DP006', 'In Transit', 'No.D4', 'D.St1', 'Galle');


insert into PAYMENT (Payment_ID, Order_ID, Total_Price, Payment_Date, Payment_Method)
values ('PAY001', 'O001', 20.00, '2023-09-05', 'Credit Card');
insert into PAYMENT values ('PAY002', 'O002', 1212.00, '2023-08-05', 'Credit Card');
insert into PAYMENT values ('PAY003', 'O003', 820.00, '2023-05-03', 'Cash');
insert into PAYMENT values ('PAY004', 'O004', 2700.00, '2023-08-25', 'Credit Card');
insert into PAYMENT values ('PAY005', 'O005', 1050.50, '2023-09-02', 'Cash');
insert into PAYMENT values ('PAY006', 'O006', 1550.00, '2023-07-08', 'Cash');

insert into EMPLOYEE (Employee_ID, First_Name, Last_Name, Manager_ID, Phone, Age, Restaurant_ID, Designation, Salary)
values ('E001', 'Kamal', 'Perera', null, '0778989898', 35, 'R001', 'Manager', 80000);
insert into EMPLOYEE values ('E002', 'Sunil', 'Lakmal', 'E001', '0723564561', 40, 'R002', 'Chef', 55000);
insert into EMPLOYEE values ('E004', 'Sanduni', 'Tharaka',null, '0457897894', 28, 'R004', 'Manager', 32000);
insert into EMPLOYEE values ('E005', 'Chathuni', 'Kavindi', 'E001', '0751231234', 22, 'R005', 'Cleaner', 36000);
insert into EMPLOYEE values ('E006', 'Dushan', 'Perera', 'E004', '0789642364', 33, 'R006', 'Worker', 39000);
insert into EMPLOYEE values ('E003', 'Nimal', 'Gayan','E004', '0789654123', 30, 'R003', 'Cashier', 48000);

insert into RESTAURANT (Restaurant_ID, Restaurant_Name, Manager_ID, Residential_No, Street, City)
values('R001', 'Restaurant_A', 'E001', 'No.R1', 'Lane1', 'Galle');
insert into RESTAURANT values('R002', 'Restaurant_B', 'E001', 'No.R2', 'Lane2', 'Matara');
insert into RESTAURANT values('R003', 'Restaurant_C', 'E004', 'No.R3', 'Lane1', 'Matara');
insert into RESTAURANT values('R004', 'Restaurant_D', 'E004', 'No.R4', 'Lane3', 'Galle');
insert into RESTAURANT values('R005', 'Restaurant_E', 'E001', 'No.R5', 'Lane10', 'Gampaha');
insert into RESTAURANT values('R006', 'Restaurant_F', 'E004', 'No.R6', 'Lane9', 'Gampaha');


alter table EMPLOYEE add constraint FK5_Restaurant_ID
foreign key(Restaurant_ID) references RESTAURANT(Restaurant_ID)
on delete set null on update cascade;

insert into RESTAURANT_PHONE_NUMBER (Restaurant_ID, Phone)
values('R001', '0765487855');
insert into RESTAURANT_PHONE_NUMBER values('R001', '0766896989');
insert into RESTAURANT_PHONE_NUMBER values('R002', '0763214521');
insert into RESTAURANT_PHONE_NUMBER values('R002', '0763256365');
insert into RESTAURANT_PHONE_NUMBER values('R005', '0765656568');
insert into RESTAURANT_PHONE_NUMBER values('R006', '0764489652');


insert into RES_SCHEDULE (Restaurant_ID, Opening_Time, Closing_Time)
values ('R001', '10:00:00', '22:00:00');
insert into RES_SCHEDULE values ('R002', '09:30:00', '21:30:00');
insert into RES_SCHEDULE values ('R003', '10:00:00', '22:00:00');
insert into RES_SCHEDULE values ('R004', '10:30:00', '22:30:00');
insert into RES_SCHEDULE values ('R005', '09:00:00', '21:00:00');
insert into RES_SCHEDULE values ('R006', '09:30:00', '21:30:00');


insert into RESTAURANT_OPENING_DAYS (Restaurant_ID, Open_days)
values ('R001', 'Monday');
insert into RESTAURANT_OPENING_DAYS values ('R002', 'Tuesday');
insert into RESTAURANT_OPENING_DAYS values ('R004', 'Saturday');
insert into RESTAURANT_OPENING_DAYS values ('R004', 'Sunday');
insert into RESTAURANT_OPENING_DAYS values ('R005', 'Sunday');
insert into RESTAURANT_OPENING_DAYS values ('R005', 'Monday');


insert into INGREDIENT_STOCK (Restaurant_ID, IngredientID, Quantity_In_Stock)
values ('R001', 'I001', 100);
insert into INGREDIENT_STOCK values ('R001', 'I002', 356);
insert into INGREDIENT_STOCK values ('R002', 'I003', 450);
insert into INGREDIENT_STOCK values ('R002', 'I004', 560);
insert into INGREDIENT_STOCK values ('R003', 'I005', 900);
insert into INGREDIENT_STOCK values ('R003', 'I006', 752);


-- --------------------------------------------------------------------------------------------------------------


update CUSTOMER
set First_Name = 'Amila' where Customer_ID = 'C002';
update CUSTOMER
set Email = 'np@gmail.com' where Customer_ID = 'C004';

delete from CUSTOMER
where Customer_Id = 'C006';


update CUSTOMER_REVIEW
set Ratings = 3 where Customer_ID = 'C001';
update CUSTOMER_REVIEW
set Descript = 'Delicious' where Customer_ID = 'C004';

delete from CUSTOMER_REVIEW
where Customer_ID = 'C005';


update RESTAURANT_PHONE_NUMBER
set Phone = '0451234567' where restaurant_ID = 'R002' ;
update RESTAURANT_PHONE_NUMBER
set Phone = '0777894561' where restaurant_ID = 'R005' ;

delete from RESTAURANT_PHONE_NUMBER
where Restaurant_ID = 'R006';


update RESTAURANT_OPENING_DAYS
set open_days = 'Thursday' where restaurant_ID = 'R001' ;
update RESTAURANT_OPENING_DAYS
set open_days = 'Monday' where restaurant_ID = 'R002' ;

delete from RESTAURANT_OPENING_DAYS
where Restaurant_ID = 'R002';


update RESTAURANT
set Manager_ID = 'E004' where restaurant_ID = 'R002' ;
update RESTAURANT
set Residential_No = 'No.R6' where restaurant_ID = 'R004' ;

delete from RESTAURANT
where Restaurant_ID = 'R004';


update RES_SCHEDULE
set opening_time = '09:00:00' where restaurant_ID = 'R003' ;
update RES_SCHEDULE
set closing_time = '22:00:00' where restaurant_ID = 'R006' ;

delete from RES_SCHEDULE
where restaurant_ID = 'R003';


update SUPPLIER
set supplier_ID = 'S005' where ingredient_ID = 'I002' ;
update SUPPLIER
set supplier_ID = 'S002' where ingredient_ID = 'I004' ;

delete from SUPPLIER
where Ingredient_ID = 'R006';


update PROMOTION
set Validity_Period = '30days' where Promo_Code = 'PROMO004' ;
update promotion
set Discount_Amount = '55.00' where Promo_Code = 'PROMO001' ;

delete from PROMOTION
where Promo_Code = 'PROMO003';


update PIZZA_INGREDIENTS
set Ingredient_ID = 'I002' where Pizza_ID = 'P003' ;
update PIZZA_INGREDIENTS
set Ingredient_ID = 'I005' where Pizza_ID = 'P002' ;

delete from PIZZA_INGREDIENTS
where Pizza_ID= 'P004';


update PIZZA
set Price = 1500  where Pizza_ID = 'P005' ;
update PIZZA
set Category = 'Classic' where Pizza_ID = 'P002' ;

delete from PIZZA
where Pizza_ID = 'P003';


update INGREDIENT 
set Price_Per_Unit = '200' where Ingredient_ID = 'I001';
update INGREDIENT 
set Quantity_In_Stock = '800' where Ingredient_ID = 'I005';

delete from INGREDIENT
where Ingredient_ID = 'I006';


update INGREDIENT_SUPPLIER 
set City = 'Hapugala' where supplier_ID = 'S001';
update INGREDIENT_SUPPLIER 
set supplier_Name = 'supplier_N' where supplier_ID = 'S004';

delete from ingredient_supplier
where Supplier_ID = 'S005';


update ORDERS
set Pizza_ID = 'P002' where Order_ID = 'O001';
update orders
set Customer_ID = 'C002' where Order_ID = 'O001';

delete from ORDERS
where Order_ID = 'O006';


update EMPLOYEE
set First_Name = 'Nipun' where Employee_ID = 'E002';
update employee
set Age = 20 where Employee_ID = 'E004';

delete from EMPLOYEE
where Employee_ID = 'E005';


update DELIVERY
set Residential_No = 'No.D15' where Delivery_ID = 'D001';
update DELIVERY
set Delivery_Person_ID = 'DP002' where Delivery_ID = 'D003';

delete from DELIVERY
where Delivery_ID = 'D005';


update DELIVERY_PERSON
set Last_Name = 'Perera' where Delivery_Person_ID = 'DP002';
update DELIVERY_PERSON
set Vehicle_No = 'Vehicle8' where Delivery_Person_ID = 'DP003';
delete from DELIVERY_PERSON
where Delivery_Person_ID = 'DP004';


update PIZZA_INGREDIENTS
set Ingredient_ID = 'I002' where Pizza_ID = 'P003' ;
update PIZZA_INGREDIENTS
set Ingredient_ID = 'I005' where Pizza_ID = 'P002' ;

delete from PIZZA_INGREDIENTS
where Pizza_ID = 'P004';


update PAYMENT
set Payment_Date = '2023-09-12' where Payment_ID = 'PAY003';
update PAYMENT
set Payment_Method = 'Cash' where Payment_ID = 'PAY002';

delete from PAYMENT
where Payment_ID = 'PAY004';

select * from PAYMENT;
-- ------------------------------------------------------------------------------------------------------------

-- simple queries

-- select operation
select order_id, customer_id, pizza_id,quantity,Total_price from orders;

-- project operation
select * from delivery_person;

 -- cartesian product
select * from customer cross join orders;

 -- creating user view
create view UV1 as select customer_id,descript from customer_review where ratings=5;
select * from UV1;

-- renaming operation
alter table payment
change payment_method payment_type varchar(20);

-- use of aggregation function
select employee_id,count(employee_id) as NoOf_Employees,avg(Age) as Average_Age from employee group by employee_id;

-- use like keyword
select order_id,order_date,order_time from orders where order_time like '0_:__:__';




-- complex queries 


-- union 
(select R.restaurant_id,R.manager_id from restaurant as R inner join 
employee as E on R.manager_id=E.employee_id where E.first_name ='Sanduni')
union
(select R.restaurant_id,K.Open_days from restaurant_opening_days as K natural join
restaurant as R where K.open_days = 'Sunday');

-- set difference
/*(select pro.category,pro.promo_code,pro.validity_period,p.pizza_name,p.size,pro.discount_amount from promotion as pro
natural join 
pizza as p where pro.discount_amount>5)
except
(select p.pizza_id,p.pizza_name, p.category,p.price,p.size,ing.ingredient_id from pizza as p
natural join pizza_ingredients as ing where p.pizza_id in ('P001','P002'));*/

-- intersect operation
/*(select restaurant_id from restaurant where city='Matara')
intersect
(select restaurant_id  from employee where designation='Chef');*/

-- division operation
select o.pizza_id, o.total_price/o.Quantity as average_price_per_order,o.order_status 
from orders as o where o.order_status='Delivered';

-- inner join

create view UV as select ING.Ingredient_Id,ING.Ingredient_Name,ING.Quantity_In_Stock,stk.Restaurant_Id,ing.price_per_unit 
from Ingredient as ING 
inner join
Ingredient_stock as stk on ING.ingredient_id=stk.IngredientID where ing.price_per_unit>100; 

select * from UV;


-- natural join
create view UV2 as select * from payment as PAY natural join 
delivery as D where d.city='Hapugala';
select * from UV2;

-- left outer join
create view UV4 as select ord.order_id,ord.pizza_id,ord.order_status,PAY.total_price,pay.payment_date from orders as ord
left outer join 
payment as PAY on ord.order_id=PAY.order_id where ord.city ='Gampaha';
select * from UV4;

-- right outer join
create view UV5 as select p.pizza_id,p.pizza_name,p.price,p.category,p.promo_code,pro.validity_period,pro.discount_amount from promotion as pro
right outer join 
pizza as p on pro.promo_code=p.promo_code where pro.validity_period>'40 days';
select * from UV5;

-- full outer join
create view UV6 as select odr.quantity,odr.order_status,odr.total_price,p.pizza_id from orders as odr
left outer join 
pizza as p on odr.pizza_id=p.pizza_id where odr.total_price>1000;

create view UV7 as select pay.payment_type,odr.order_id,odr.order_date,odr.order_time from orders as odr
right outer join 
payment as PAY on odr.order_id=PAY.order_id where PAY.payment_type = 'CreditCard';
select * from UV6 union select * from UV7; 

-- outer union
create view UV8 as select p.phone,res.city from restaurant_phone_number as p left join restaurant as res on p.restaurant_id=res.restaurant_id;
create view UV9 as select o.restaurant_id,o.open_days from restaurant_opening_days as o where o.open_days = 'sunday';
select * from UV8 union select * from UV9;

-- nested queries
select r.manager_id,r.restaurant_id,r.city from restaurant as r where r.restaurant_id 
in (select restaurant_id from employee as e where age>25);

select d.first_name,d.phone,d.licence_no from delivery_person as d where d.delivery_person_id in
(select delivery_person_id from delivery where residential_no ='No.D2'); 

select o.order_id,o.pizza_id,o.quantity,o.order_status,o.total_price from orders as o where o.order_status='In progress' 
and o.order_id in 
(select order_id from payment where payment_date<'2023-08-20');

-- --------------------------------------------------------------------------------------------------------------------------------


-- -------TUNING ----------

-- intersection

/*explain((select restaurant_id from restaurant where city='Matara')
intersect
(select restaurant_id  from employee where designation='Chef')); 
create index fk_rescity on restaurant(city);
create index fk_desig on employee(designation);*/

-- devision

explain(select o.pizza_id, o.total_price/o.Quantity as average_price_per_order,o.order_status 
from orders as o where o.order_status='Delivered');

create index fk_div on orders(order_status);

-- union

explain((select R.restaurant_id,R.manager_id from restaurant as R inner join 
employee as E on R.manager_id=E.employee_id where E.first_name ='Sanduni')
union
(select R.restaurant_id,K.Open_days from restaurant_opening_days as K natural join
restaurant as R where K.open_days = 'Sunday'));

create index res_id on employee(first_name);
create index res2_id on restaurant_opening_days(open_days);

-- inner join

explain(select * from UV);

create index fk_restaut2 on ingredient(price_per_unit);

-- natural join

explain select * from UV2;

create index fk_city on delivery(city);

-- left outer join

explain(select * from UV4);

create index fk_city on orders(city);

-- right outer join

explain(select * from UV5);

create index fk_days on promotion(validity_period);


-- full outer join

explain (select * from UV6 union select * from UV7); 

create index fk_tprice on orders(total_price);
create index fk_paymethod on payment(payment_type);

-- nested queries

explain(select r.manager_id,r.restaurant_id,r.city from restaurant as r where r.restaurant_id 
in (select restaurant_id from employee as e where age>25));

create index fk_age on employee(age);

explain(select d.first_name,d.phone,d.licence_no from delivery_person as d where d.delivery_person_id in
(select delivery_person_id from delivery where residential_no ='No.D2')); 

create index fk_residen on delivery(residential_no);