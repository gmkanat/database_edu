drop table customers;
create table customers(
    customer_id int not null primary key,
    first_name varchar not null ,
    last_name varchar not null,
    country varchar not null,
    city varchar not null,
    street_name varchar not null,
    home_number int,
    number varchar not null
);

drop table cards;
create table cards(
    card_id int not null primary key ,
    card_type varchar not null,
    card_number varchar not null ,
    card_date date not null,
    card_code int not null
);

drop table card;
create table card(
    customer_id int references customers(customer_id),
    card_id int references cards(card_id),
    primary key (customer_id, card_id)
);


drop table company;
create table company(
    company_id int not null primary key,
    account_number int not null,
    billy_date date
);

drop table contract;
create table contract(
    customer_id int references customers(customer_id),
    company_id int references company(company_id),
    primary key (customer_id, company_id)
);

drop table sales;
create table sales(
    sale_id int not null primary key,
    tracking_number varchar,
    type_of_sale varchar not null check(type_of_sale = 'Online' or type_of_sale = 'Offline') ,
    season date
);

drop table to_customer;
create table to_customer(
    customer_id int references customers(customer_id),
    sale_id int references sales(sale_id),
    primary key (customer_id, sale_id)
);

drop table shipper;
create table shipper(
    shipper_id int not null primary key,
    shipper_name varchar not null
);

drop table ship_company;
create table ship_company(
    shipper_id int references shipper(shipper_id),
    sale_id int references sales(sale_id),
    primary key (shipper_id, sale_id),
    date_destination date
);

drop table stores;
create table stores(
    store_id int not null primary key,
    store_name varchar not null
);

drop table store_address;
create table store_address(
    address_id int not null primary key,
    country varchar not null,
    state varchar not null,
    city varchar not null,
    street_name varchar not null,
    apart int
);

drop table address;
create table address(
    store_id int references stores(store_id),
    address_id int references store_address(address_id),
    primary key (store_id, address_id)
);

drop table buy;
create table buy(
    store_id int references stores(store_id),
    sale_id int references sales(sale_id),
    primary key (store_id, sale_id)
);

drop table product;
create table product(
    product_id int not null primary key ,
    name varchar not null,
    amount int check(amount > 0),
    price int not null check(price > 0)
);

drop table categories;
create table categories(
    category_id int not null primary key,
    category_name varchar not null
);

drop table category;
create table category(
    product_id int references product(product_id),
    category_id int references categories(category_id),
    primary key (product_id, category_id)
);


drop table manufactures;
create table manufactures(
    manufacture_id int not null primary key,
    manufacture_name varchar not null
);

drop table manufacture;
create table manufacture(
    manufacture_id int references manufactures(manufacture_id),
    product_id int references product(product_id),
    primary key (product_id, manufacture_id)
);

drop table warehouses;
create table warehouses(
    warehouse_id int not null primary key ,
    warehouse_name varchar not null
);

drop table warehouse;
create table warehouse(
    warehouse_id int references warehouses(warehouse_id),
    store_id int references stores(store_id),
    primary key (store_id, warehouse_id)
);

drop table store;
create table store(
    product_id int references product(product_id),
    store_id int references stores(store_id),
    primary key (store_id, product_id)
);




delete from categories where category_id > 10;
delete from category where category_id = 1;

insert into cards (card_id, card_type, card_number, card_date, card_code)
values  (1, 'jcb', '3530495470364873', '2021-10-30', 725),
        (2, 'bankcard', '5610544180695775', '2021-04-02', 394),
        (3, 'jcb', '3532730305112222', '2020-12-06', 370),
        (4, 'americanexpress', '374622184530987', '2021-01-02', 509),
        (5, 'jcb', '3546521845823905', '2021-02-19', 504),
        (6, 'americanexpress', '348728534767253', '2021-03-27', 804),
        (7, 'jcb', '3568263188894465', '2021-10-16', 953),
        (8, 'jcb', '3581244205325900', '2020-12-19', 320),
        (9, 'diners-club-enroute', '201486892933944', '2021-01-29', 554),
        (10, 'mastercard', '5217280339656171', '2021-08-21', 653),
        (11, 'solo', '6767828844629745', '2020-12-16', 841),
        (12, 'switch', '6333159951104644', '2021-04-01', 339),
        (13, 'jcb', '3568867715638961', '2021-01-05', 666),
        (14, 'jcb', '3551289251795098', '2021-09-28', 380),
        (15, 'maestro', '5020773922591914893', '2020-12-06', 364),
        (16, 'americanexpress', '379640418234833', '2021-08-21', 263),
        (17, 'jcb', '3564796910122113', '2020-12-21', 932),
        (18, 'jcb', '3568617853444072', '2020-12-29', 691),
        (19, 'maestro', '6762633902115818073', '2021-01-16', 269),
        (20, 'mastercard', '5192954843949152', '2021-04-02', 284);

insert into categories (category_id, category_name)
values  (1, 'Framing (Steel)'),
        (2, 'Wall Protection'),
        (3, 'Epoxy Flooring'),
        (4, 'Rebar & Wire Mesh Install'),
        (5, 'Ornamental Railings'),
        (6, 'Masonry'),
        (7, 'Electrical and Fire Alarm'),
        (8, 'Fire Sprinkler System'),
        (9, 'Fire Sprinkler System'),
        (10, 'Roofing (Metal)');

insert into company (company_id, account_number, billy_date)
values  (1, 72400, '2021-04-23'),
        (2, 52130, '2021-06-18'),
        (3, 73890, '2021-11-05');

insert into customers (customer_id, first_name, last_name, country, city, street_name, home_number, number)
values  (1, 'Burnard', 'Correy', 'Peru', 'Pallanchacra', 'Farwell', 1670, '2109179864'),
        (2, 'Tracy', 'Gonzales', 'France', 'Crépy-en-Valois', 'Crownhardt', 1325, '3407851820'),
        (3, 'Mario', 'Launce', 'Indonesia', 'Pancur', 'Bunker Hill', 1982, '5762814165'),
        (4, 'Laurens', 'Fitz', 'Lebanon', 'Marjayoûn', 'Bonner', 1611, '2877095150'),
        (5, 'Stevana', 'Ervin', 'China', 'Gurinai', '1st', 1218, '7427615468'),
        (6, 'Brien', 'Helen', 'United States', 'Los Angeles', 'Independence', 1355, '3845378492'),
        (7, 'Liza', 'Carroll', 'Czech Republic', 'Radiměř', 'Crescent Oaks', 1291, '0312473346'),
        (8, 'Neala', 'Dominica', 'Botswana', 'Letsheng', 'Sachtjen', 1614, '7947313857'),
        (9, 'Valeda', 'Michell', 'China', 'Gonghe', 'Mcguire', 1641, '1226188621'),
        (10, 'Bear', 'Mel', 'New Zealand', 'Waitangi', 'Steensland', 1358, '4152256354'),
        (11, 'Torey', 'Grethel', 'Portugal', 'Ponte', '4th', 1175, '3326695802'),
        (12, 'Ali', 'Rona', 'Indonesia', 'Beringin', 'Morrow', 1487, '1093421215'),
        (13, 'Adelina', 'Mel', 'France', 'Le Mans', 'Walton', 1861, '1891577018'),
        (14, 'Northrup', 'Jamesy', 'China', 'Daqiao', 'Mifflin', 1870, '6510411504'),
        (15, 'Massimo', 'Dolph', 'Slovenia', 'Razvanje', 'Bluestem', 1007, '5331052002'),
        (16, 'Whitney', 'Katuscha', 'Russia', 'Gremyachinsk', 'Dryden', 1187, '6617160630'),
        (17, 'Nerta', 'Deanne', 'Indonesia', 'Teluksantong', 'Merrick', 1360, '7037341568'),
        (18, 'Felic', 'Ralina', 'Indonesia', 'Banjar Sandinggianyar', 'Muir', 1265, '3907988086'),
        (19, 'Buckie', 'Mort', 'Poland', 'Mrzezino', 'Pankratz', 1464, '0137540469'),
        (20, 'Merrie', 'Torie', 'Russia', 'Irkutsk', 'Russell', 1723, '1038033578');

insert into manufactures (manufacture_id, manufacture_name)
values  (1, 'Buzzster'),
        (2, 'BlogXS'),
        (3, 'Quamba'),
        (4, 'Thoughtsphere'),
        (5, 'Skiptube'),
        (6, 'Tagtune'),
        (7, 'Vidoo'),
        (8, 'Livepath'),
        (9, 'Bubbletube'),
        (10, 'Skyvu');

insert into product (product_id, name, amount, price)
values  (7, 'Nissan', 322, 4234),
        (11, 'Mercury', 338, 6623),
        (16, 'Mercedes-Benz', 375, 431),
        (5, 'Chevrolet', 239, 32423),
        (9, 'Chevrolet', 272, 4234),
        (12, 'Hyundai', 313, 4234),
        (14, 'Chrysler', 342, 523),
        (17, 'BMW', 325, 4113),
        (8, 'Ford', 368, 8784),
        (3, 'Chevrolet', 306, 423),
        (19, 'Volvo', 232, 413),
        (18, 'Hummer', 253, 5143),
        (4, 'Mitsubishi', 354, 8747),
        (10, 'Nissan', 252, 7654),
        (6, 'Mercury', 283, 3456),
        (1, 'Aston Martin', 395, 545),
        (2, 'Mazda', 145, 4543),
        (15, 'Volvo', 247, 4312),
        (20, 'GMC', 215, 4144),
        (13, 'Hyundai', 356, 545);

insert into sales (sale_id, tracking_number, type_of_sale, season)
values  (1, '18851', 'Online', '2021-10-08'),
        (2, '19691', 'Online', '2021-03-18'),
        (3, null, 'Offline', '2021-02-17'),
        (4, '11096', 'Online', '2021-02-09'),
        (5, '10770', 'Online', '2021-04-07'),
        (6, '11402', 'Online', '2021-02-04'),
        (7, null, 'Offline', '2021-08-30'),
        (8, '12641', 'Online', '2021-05-01'),
        (9, null, 'Offline', '2021-04-22'),
        (10, '19781', 'Online', '2021-03-20'),
        (11, null, 'Offline', '2021-05-20'),
        (12, null, 'Offline', '2021-02-06'),
        (13, '11942', 'Online', '2021-02-23'),
        (14, null, 'Offline', '2021-11-26'),
        (15, null, 'Offline', '2021-05-28'),
        (16, '17587', 'Online', '2021-08-08'),
        (17, '16816', 'Online', '2021-11-13'),
        (18, '17655', 'Offline', '2021-10-26'),
        (19, null, 'Offline', '2021-10-31'),
        (20, '12371', 'Online', '2021-01-15');
insert into shipper (shipper_id, shipper_name)
values  (1, 'Puerto Rico Peperomia'),
        (2, 'Hairy Braya'),
        (3, 'Ecotone Blackberry'),
        (4, 'Halberd Fern'),
        (5, 'Broom');

insert into store_address (address_id, country, state, city, street_name, apart)
values  (1, 'Thailand', 'TH', 'Chok Chai', 'South', 7049),
        (2, 'Indonesia', 'ID', 'Pajaten', 'South', 786),
        (3, 'Peru', 'PE', 'Yanac', 'Brown', 67027),
        (4, 'China', 'CN', 'Beizi', 'Larry', 636),
        (5, 'Croatia', 'HR', 'Koška', 'Thompson', 29230),
        (6, 'Indonesia', 'ID', 'Bedayutalang', 'Clarendon', 5),
        (7, 'Russia', 'RU', 'Mogocha', 'Bartelt', 7),
        (8, 'China', 'CN', 'Guanlu', 'Troy', 41849),
        (9, 'China', 'CN', 'Liaoyang', 'John Wall', 52),
        (10, 'China', 'CN', 'Dalongzhan', '3rd', 34265),
        (11, 'Indonesia', 'ID', 'Pasrukrajan Satu', 'Susan', 34),
        (12, 'Serbia', 'RS', 'Vršac', 'Monica', 769),
        (13, 'Brazil', 'BR', 'Bertioga', 'Trailsway', 43978),
        (14, 'Russia', 'RU', 'Bira', 'Farmco', 2398),
        (15, 'Brazil', 'BR', 'Itarana', 'Duke', 84516),
        (16, 'Bulgaria', 'BG', 'Razgrad', 'Maple', 552),
        (17, 'Barbados', 'BB', 'Speightstown', 'Hanover', 76420),
        (18, 'Japan', 'JP', 'Usuki', '1st', 5970),
        (19, 'Russia', 'RU', 'Shikhazany', 'Northridge', 9227),
        (20, 'Thailand', 'TH', 'Sahatsakhan', 'Forest Run', 446);

insert into stores (store_id, store_name)
values  (1, 'Crawler'),
        (2, 'Skid-Steer'),
        (3, 'Crawler'),
        (4, 'Dragline'),
        (5, 'Bulldozer'),
        (6, 'Compactor'),
        (7, 'Excavator'),
        (8, 'Dragline'),
        (9, 'Dragline'),
        (10, 'Grader'),
        (11, 'Skid-Steer'),
        (12, 'Dump Truck'),
        (13, 'Excavator'),
        (14, 'Trencher'),
        (15, 'Backhoe'),
        (16, 'Dragline'),
        (17, 'Skid-Steer'),
        (18, 'Grader'),
        (19, 'Skid-Steer'),
        (20, 'Scraper');

insert into warehouses (warehouse_id, warehouse_name)
values  (1, 'Zboncak-Wunsch'),
        (2, 'Adams-Erdman'),
        (3, 'Haag LLC'),
        (4, 'Ruecker-Schinner'),
        (5, 'Schiller-Hilll'),
        (6, 'Jakubowski-Torphy'),
        (7, 'Wolff-Armstrong'),
        (8, 'Koss, Gutkowski and Hayes'),
        (9, 'Purdy Inc'),
        (10, 'Langworth Group');
insert into category values  (1, 1);
insert into category values  (2, 1);
insert into category values  (3, 2);
insert into category values  (4, 2);
insert into category values  (5, 3);
insert into category values  (6, 3);
insert into category values  (7, 4);
insert into category values  (8, 4);
insert into category values  (9, 5);
insert into category values  (10, 5);
insert into category values  (11, 6);
insert into category values  (12, 6);
insert into category values  (13, 7);
insert into category values  (14, 7);
insert into category values  (15, 8);
insert into category values  (16, 8);
insert into category values  (17, 9);
insert into category values  (18, 9);
insert into category values  (19, 10);
insert into category values  (20, 10);


insert into manufacture values  (1, 1);
insert into manufacture values  (1, 2);
insert into manufacture values  (2, 3);
insert into manufacture values  (2, 4);
insert into manufacture values  (3, 5);
insert into manufacture values  (3, 6);
insert into manufacture values  (4, 7);
insert into manufacture values  (4, 8);
insert into manufacture values  (5, 9);
insert into manufacture values  (5, 10);
insert into manufacture values  (6, 11);
insert into manufacture values  (6, 12);
insert into manufacture values  (7, 13);
insert into manufacture values  (7, 14);
insert into manufacture values  (8, 15);
insert into manufacture values  (8, 16);
insert into manufacture values  (9, 17);
insert into manufacture values  (9, 18);
insert into manufacture values  (10, 19);
insert into manufacture values  (10, 20);



insert into address values  (1, 1);
insert into address values  (2, 2);
insert into address values  (3, 3);
insert into address values  (4, 4);
insert into address values  (5, 5);
insert into address values  (6, 6);
insert into address values  (7, 7);
insert into address values  (8, 8);
insert into address values  (9, 9);
insert into address values  (10, 10);
insert into address values  (11, 11);
insert into address values  (12, 12);
insert into address values  (13, 13);
insert into address values  (14, 14);
insert into address values  (15, 15);
insert into address values  (16, 16);
insert into address values  (17, 17);
insert into address values  (18, 18);
insert into address values  (19, 19);
insert into address values  (20, 20);

insert into warehouse values  (1, 11);
insert into warehouse values  (2, 12);
insert into warehouse values  (3, 13);
insert into warehouse values  (4, 14);
insert into warehouse values  (5, 15);
insert into warehouse values  (6, 16);
insert into warehouse values  (7, 17);
insert into warehouse values  (8, 18);
insert into warehouse values  (9, 19);
insert into warehouse values  (10, 20);

insert into buy values  (1, 1);
insert into buy values  (1, 2);
insert into buy values  (2, 3);
insert into buy values  (2, 4);
insert into buy values  (3, 5);
insert into buy values  (3, 6);
insert into buy values  (4, 7);
insert into buy values  (4, 8);
insert into buy values  (5, 9);
insert into buy values  (5, 10);
insert into buy values  (6, 11);
insert into buy values  (6, 12);
insert into buy values  (7, 13);
insert into buy values  (7, 14);
insert into buy values  (8, 15);
insert into buy values  (8, 16);
insert into buy values  (9, 17);
insert into buy values  (9, 18);
insert into buy values  (10, 19);
insert into buy values  (10, 20);

insert into ship_company values  (1, 1, '12-12-2021');
insert into ship_company values  (2, 2, '12-12-2021');
insert into ship_company values  (3, 4, '12-12-2021');
insert into ship_company values  (4, 5, '12-12-2021');
insert into ship_company values  (5, 6, '12-12-2021');
insert into ship_company values  (1, 8, '12-12-2021');
insert into ship_company values  (2, 10, '12-12-2021');
insert into ship_company values  (3, 13, '12-12-2021');
insert into ship_company values  (4, 16, '12-12-2021');
insert into ship_company values  (5, 17, '12-12-2021');
insert into ship_company values  (1, 18, '12-12-2021');
insert into ship_company values  (2, 20, '12-12-2021');


insert into card values  (1, 1);
insert into card values  (2, 2);
insert into card values  (3, 3);
insert into card values  (4, 4);
insert into card values  (5, 5);
insert into card values  (6, 6);
insert into card values  (7, 7);
insert into card values  (8, 8);
insert into card values  (9, 9);
insert into card values  (10, 10);
insert into card values  (11, 11);
insert into card values  (12, 12);
insert into card values  (13, 13);
insert into card values  (14, 14);
insert into card values  (15, 15);
insert into card values  (16, 16);
insert into card values  (17, 17);
insert into card values  (18, 18);
insert into card values  (19, 19);
insert into card values  (20, 20);

insert into to_customer values  (1, 1);
insert into to_customer values  (1, 2);
insert into to_customer values  (1, 3);
insert into to_customer values  (1, 4);
insert into to_customer values  (1, 5);

insert into to_customer values  (2, 6);
insert into to_customer values  (2, 7);
insert into to_customer values  (2, 8);
insert into to_customer values  (2, 9);
insert into to_customer values  (12, 10);
insert into to_customer values  (13, 11);
insert into to_customer values  (14, 12);
insert into to_customer values  (15, 13);
insert into to_customer values  (16, 14);
insert into to_customer values  (17, 15);
insert into to_customer values  (18, 16);
insert into to_customer values  (19, 17);
insert into to_customer values  (20, 18);
insert into to_customer values  (20, 19);
insert into to_customer values  (20, 20);

insert into contract values(16, 1);
insert into contract values(17, 2);
insert into contract values(18, 3);

insert into store values  (1, 20);
insert into store values  (2, 19);
insert into store values  (3, 18);
insert into store values  (4, 17);
insert into store values  (5, 16);
insert into store values  (6, 15);
insert into store values  (7, 14);
insert into store values  (8, 13);
insert into store values  (9, 12);
insert into store values  (10, 11);
insert into store values  (11, 10);
insert into store values  (12, 9);
insert into store values  (13, 8);
insert into store values  (14, 7);
insert into store values  (15, 6);
insert into store values  (16, 5);
insert into store values  (17, 4);
insert into store values  (18, 3);
insert into store values  (19, 2);
insert into store values  (20, 1);


-- 4.1
select customers.* from shipper join ship_company sc on shipper.shipper_id = sc.shipper_id and shipper.shipper_name = 'Broom'
join sales on sc.sale_id = sales.sale_id and sales.tracking_number = '11402' join
    to_customer tc on sales.sale_id = tc.sale_id join customers on tc.customer_id = customers.customer_id;

-- 4.2
select customers.first_name, sum(p.price) from customers join to_customer tc on customers.customer_id = tc.customer_id join sales s on tc.sale_id = s.sale_id
and season > current_date - interval '1' year join buy on s.sale_id = buy.sale_id join stores on buy.store_id = stores.store_id join
    store on stores.store_id = store.store_id join product p on store.product_id = p.product_id group by customers.first_name order by sum(-p.price) limit 1;

-- 4.3
select p.name, sum(p.price) as ss from sales join buy b on sales.sale_id = b.sale_id join stores s on b.store_id = s.store_id join store s2 on s.store_id = s2.store_id join
    product p on s2.product_id = p.product_id group by p.name order by ss desc limit 2;

-- 4.4
select p.name, count(p.price) as ss from sales join buy b on sales.sale_id = b.sale_id join stores s on b.store_id = s.store_id join store s2 on s.store_id = s2.store_id join
    product p on s2.product_id = p.product_id group by p.name order by ss desc limit 2;

-- 4.5
select product.name from product where product.name not in (select p.name from store_address join address a on store_address.address_id = a.address_id and store_address.country ='China' join
    stores s on a.store_id = s.store_id join
    store s2 on s.store_id = s2.store_id join product p on s2.product_id = p.product_id group by p.name) group by product.name;

-- 4.6
select p.name from ship_company join sales on ship_company.sale_id = sales.sale_id and ship_company.date_destination - interval '1' month < sales.season join
    buy b on sales.sale_id = b.sale_id join stores s on b.store_id = s.store_id join store s2 on s.store_id = s2.store_id join
    product p on s2.product_id = p.product_id;

-- 4.7
select sales.sale_id, tracking_number, p.name, s.store_name, c.customer_id, c.first_name, c.number, c2.card_number from sales join to_customer tc on sales.sale_id = tc.sale_id join
    customers c on tc.customer_id = c.customer_id join buy on sales.sale_id = buy.sale_id
join stores s on buy.store_id = s.store_id join store s2 on s.store_id = s2.store_id join
    product p on s2.product_id = p.product_id join card on c.customer_id = card.customer_id
join cards c2 on card.card_id = c2.card_id;