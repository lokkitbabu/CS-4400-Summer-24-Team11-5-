-- CS4400: Introduction to Database Systems: Monday, July 1, 2024
-- Simple Cruise Management System Course Project Database (v0)

/* This is a standard preamble for most of our scripts.  The intent is to establish
a consistent environment for the database behavior. */
set global transaction isolation level serializable;
set global SQL_MODE = 'ANSI,TRADITIONAL';
set names utf8mb4;
set SQL_SAFE_UPDATES = 0;

set @thisDatabase = 'cruise_tracking';
drop database if exists cruise_tracking;
create database if not exists cruise_tracking;
use cruise_tracking;

-- Define the database structures
create table cruiseline (
	cruiselineID varchar(50),
    primary key (cruiselineID)
) engine = innodb;

insert into cruiseline values ('Royal Caribbean');
insert into cruiseline values ('Carnival');
insert into cruiseline values ('Norwegian');
insert into cruiseline values ('MSC');
insert into cruiseline values ('Princess');
insert into cruiseline values ('Celebrity');
insert into cruiseline values ('Disney');
insert into cruiseline values ('Holland America');
insert into cruiseline values ('Costa');
insert into cruiseline values ('P&O Cruises');
insert into cruiseline values ('AIDA');
insert into cruiseline values ('Viking Ocean');
insert into cruiseline values ('Silversea');
insert into cruiseline values ('Regent');
insert into cruiseline values ('Oceania');
insert into cruiseline values ('Seabourn');
insert into cruiseline values ('Cunard');
insert into cruiseline values ('Azamara');
insert into cruiseline values ('Windstar');
insert into cruiseline values ('Hurtigruten');
insert into cruiseline values ('Paul Gauguin Cruises');
insert into cruiseline values ('Celestyal Cruises');
insert into cruiseline values ('Saga Cruises');
insert into cruiseline values ('Ponant');
insert into cruiseline values ('Star Clippers');
insert into cruiseline values ('Marella Cruises');

create table location (
	locationID varchar(50),
    primary key (locationID)
) engine = innodb;

insert into location values ('ship_1');
insert into location values ('ship_2');
insert into location values ('ship_3');
insert into location values ('ship_4');
insert into location values ('ship_5');
insert into location values ('ship_6');
insert into location values ('ship_7');
insert into location values ('ship_8');
insert into location values ('ship_9');
insert into location values ('ship_10');
insert into location values ('ship_11');
insert into location values ('ship_12');
insert into location values ('ship_13');
insert into location values ('ship_14');
insert into location values ('ship_15');
insert into location values ('ship_16');
insert into location values ('ship_17');
insert into location values ('ship_18');
insert into location values ('ship_19');
insert into location values ('ship_20');
insert into location values ('ship_21');
insert into location values ('ship_22');
insert into location values ('ship_23');
insert into location values ('ship_24');
insert into location values ('ship_25');
insert into location values ('ship_26');
insert into location values ('ship_27');
insert into location values ('port_1');
insert into location values ('port_2');
insert into location values ('port_3');
insert into location values ('port_4');
insert into location values ('port_5');
insert into location values ('port_6');
insert into location values ('port_7');
insert into location values ('port_8');
insert into location values ('port_9');
insert into location values ('port_10');
insert into location values ('port_11');
insert into location values ('port_12');
insert into location values ('port_13');
insert into location values ('port_14');
insert into location values ('port_15');
insert into location values ('port_16');
insert into location values ('port_17');
insert into location values ('port_18');
insert into location values ('port_19');
insert into location values ('port_20');
insert into location values ('port_21');
insert into location values ('port_22');
insert into location values ('port_23');


create table ship (
	cruiselineID varchar(50),
    ship_name varchar(50),
    max_capacity integer not null check (max_capacity > 0),
    speed float not null check (speed > 0),
    locationID varchar(50) default null,
    ship_type varchar(100) default null,
    uses_paddles boolean default null,
    lifeboats integer default null,
    primary key (cruiselineID, ship_name),
    constraint fk1 foreign key (cruiselineID) references cruiseline (cruiselineID),
    constraint fk3 foreign key (locationID) references location (locationID)
) engine = innodb;

insert into ship values ('Royal Caribbean', 'Symphony of the Seas', 6680, 22, 'ship_1', 'ocean_liner', null, 20);
insert into ship values ('Carnival', 'Carnival Vista', 3934, 23, 'ship_23', 'ocean_liner', null, 2);
insert into ship values ('Norwegian', 'Norwegian Bliss', 4004, 22.5, 'ship_24', 'ocean_liner', null, 15);
insert into ship values ('MSC', 'Meraviglia', 4488, 22.7, 'ship_22', 'ocean_liner', null, 20);
insert into ship values ('Princess', 'Crown Princess', 3080, 23, 'ship_5', 'ocean_liner', null, 20);
insert into ship values ('Celebrity', 'Celebrity Edge', 2908, 22, 'ship_6', 'ocean_liner', null, 20);
insert into ship values ('Disney', 'Disney Dream', 4000, 23.5, 'ship_7', 'ocean_liner', null, 20);
insert into ship values ('Holland America', 'MS Nieuw Statendam', 2666, 23, 'ship_8', 'ocean_liner', null, 30);
insert into ship values ('Costa', 'Costa Smeralda', 6554, 23, 'ship_2', null, null, null);
insert into ship values ('P&O Cruises', 'Iona', 5200, 22.6, 'ship_3', 'ocean_liner', null, 20);
insert into ship values ('AIDA', 'AIDAnova', 6600, 21.5, 'ship_4', 'ocean_liner', null, 35);
insert into ship values ('Viking Ocean', 'Viking Orion', 930, 20, 'ship_9', 'ocean_liner', null, 20);
insert into ship values ('Silversea', 'Silver Muse', 596, 19.8, 'ship_13', 'ocean_liner', null, 30);
insert into ship values ('Regent', 'Seven Seas Explorer', 750, 19.5, 'ship_10', 'ocean_liner', null, 20);
insert into ship values ('Oceania', 'Marina', 1250, 20, 'ship_11', 'ocean_liner', null, 25);
insert into ship values ('Seabourn', 'Seabourn Ovation', 604, 19, 'ship_12', 'ocean_liner', null, 20);
insert into ship values ('Cunard', 'Queen Mary 2', 2691, 30, 'ship_14', 'ocean_liner', null, 40);
insert into ship values ('Azamara', 'Azamara Quest', 686, 18.5, 'ship_18', 'river', true, null);
insert into ship values ('Royal Caribbean', 'Oasis of the Seas', 1325, 18, 'ship_25', 'ocean_liner', null, 30);
insert into ship values ('Windstar', 'Wind Surf', 342, 15, 'ship_20', 'river', false, null);
insert into ship values ('Hurtigruten', 'MS Roald Amundsen', 530, 15.5, 'ship_21', 'ocean_liner', null, 10);
insert into ship values ('Paul Gauguin Cruises', 'Paul Gauguin', 332, 18, 'ship_15', null, null, null);
insert into ship values ('Celestyal Cruises', 'Celestyal Crystal', 1200, 18.5, 'ship_16', 'river', false, null);
insert into ship values ('Saga Cruises', 'Spirit of Discovery', 999, 21, 'ship_17', 'ocean_liner', null, 2);
insert into ship values ('Ponant', 'Le Lyrial', 264, 16, 'ship_26', 'river', true, null);
insert into ship values ('Star Clippers', 'Royal Clipper', 227, 17, 'ship_19', 'river', true, null);
insert into ship values ('Marella Cruises', 'Marella Explorer', 1924, 21.5, 'ship_27', 'ocean_liner', null, 2);

create table ship_port (
	portID char(3),
    port_name varchar(200),
    city varchar(100) not null,
    state varchar(100) not null,
    country char(3) not null,
    locationID varchar(50) default null,
    primary key (portID),
    constraint fk2 foreign key (locationID) references location (locationID)
) engine = innodb;

insert into ship_port values ('MIA', 'Port of Miami', 'Miami', 'Florida', 'USA', 'port_1');
insert into ship_port values ('EGS', 'Port Everglades', 'Fort Lauderdale', 'Florida', 'USA', 'port_2');
insert into ship_port values ('CZL', 'Port of Cozumel', 'Cozumel', 'Quintana Roo', 'MEX', 'port_3');
insert into ship_port values ('CNL', 'Port Canaveral', 'Cape Canaveral', 'Florida', 'USA', 'port_4');
insert into ship_port values ('NSU', 'Port of Nassau', 'Nassau', 'New Providence  ', 'BHS', 'port_5');
insert into ship_port values ('BCA', 'Port of Barcelona', 'Barcelona', 'Catalonia', 'ESP', 'port_6');
insert into ship_port values ('CVA', 'Port of Civitavecchia', 'Civitavecchia', 'Lazio', 'ITA', 'port_7');
insert into ship_port values ('VEN', 'Port of Venice', 'Venice', 'Veneto', 'ITA', 'port_14');
insert into ship_port values ('SHA', 'Port of Southampton', 'Southhampton', 'Hampshire', 'GBR', 'port_8');
insert into ship_port values ('GVN', 'Port of Galveston', 'Galveston', 'Texas', 'USA', 'port_10');
insert into ship_port values ('SEA', 'Port of Seattle', 'Seattle', 'Washington', 'USA', 'port_11');
insert into ship_port values ('SJN', 'Port of San Juan', 'San Juan', 'Puerto Rico', 'USA', 'port_12');
insert into ship_port values ('NOS', 'Port of New Orleans', 'New Orleans', 'Louisiana', 'USA', 'port_13');
insert into ship_port values ('SYD', 'Port of Sydney', 'Sydney', 'New South Wales', 'AUS', 'port_9');
insert into ship_port values ('TMP', 'Port of Tampa Bay', 'Tampa Bay', 'Florida', 'USA', 'port_15');
insert into ship_port values ('VAN', 'Port of Vancouver', 'Vancouver', 'British Columbia', 'CAN', 'port_16');
insert into ship_port values ('MAR', 'Port of Marseille', 'Marseille', 'Provence-Alpes-Côte d\'Azur', 'FRA', 'port_17');
insert into ship_port values ('COP', 'Port of Copenhagen', 'Copenhagen', 'Hovedstaden', 'DEN', 'port_18');
insert into ship_port values ('BRI', 'Port of Bridgetown', 'Bridgetown', 'Saint Michael', 'BRB', 'port_19');
insert into ship_port values ('PIR', 'Port of Piraeus', 'Piraeus', 'Attica', 'GRC', 'port_20');
insert into ship_port values ('STS', 'Port of St. Thomas', 'Charlotte Amalie', 'St. Thomas', 'USV', 'port_21');
insert into ship_port values ('STM', 'Port of Stockholm', 'Stockholm', 'Stockholm County', 'SWE', 'port_22');
insert into ship_port values ('LAS', 'Port of Los Angeles', 'Los Angeles', 'California', 'USA', 'port_23');

create table person (
	personID varchar(50),
    first_name varchar(100) not null,
    last_name varchar(100) default null,
    primary key (personID)
) engine = innodb;

insert into person values ('p0', 'Martin', 'van Basten');
insert into person values ('p1', 'Jeanne', 'Nelson');
insert into person values ('p2', 'Roxanne', 'Byrd');
insert into person values ('p3', 'Tanya', 'Nguyen');
insert into person values ('p4', 'Kendra', 'Jacobs');
insert into person values ('p5', 'Jeff', 'Burton');
insert into person values ('p6', 'Randal', 'Parks');
insert into person values ('p7', 'Sonya', 'Owens');
insert into person values ('p8', 'Bennie', 'Palmer');
insert into person values ('p9', 'Marlene', 'Warner');
insert into person values ('p10', 'Lawrence', 'Morgan');
insert into person values ('p11', 'Sandra', 'Cruz');
insert into person values ('p12', 'Dan', 'Ball');
insert into person values ('p13', 'Bryant', 'Figueroa');
insert into person values ('p14', 'Dana', 'Perry');
insert into person values ('p15', 'Matt', 'Hunt');
insert into person values ('p16', 'Edna', 'Brown');
insert into person values ('p17', 'Ruby', 'Burgess');
insert into person values ('p18', 'Esther', 'Pittman');
insert into person values ('p19', 'Doug', 'Fowler');
insert into person values ('p20', 'Thomas', 'Olson');
insert into person values ('p21', 'Mona', 'Harrison');
insert into person values ('p22', 'Arlene', 'Massey');
insert into person values ('p23', 'Judith', 'Patrick');
insert into person values ('p24', 'Reginald', 'Rhodes');
insert into person values ('p25', 'Vincent', 'Garcia');
insert into person values ('p26', 'Cheryl', 'Moore');
insert into person values ('p27', 'Michael', 'Rivera');
insert into person values ('p28', 'Luther', 'Matthews');
insert into person values ('p29', 'Moses', 'Parks');
insert into person values ('p30', 'Ora', 'Steele');
insert into person values ('p31', 'Antonio', 'Flores');
insert into person values ('p32', 'Glenn', 'Ross');
insert into person values ('p33', 'Irma', 'Thomas');
insert into person values ('p34', 'Ann', 'Maldonado');
insert into person values ('p35', 'Jeffrey', 'Cruz');
insert into person values ('p36', 'Sonya', 'Price');
insert into person values ('p37', 'Tracy', 'Hale');
insert into person values ('p38', 'Albert', 'Simmons');
insert into person values ('p39', 'Karen', 'Terry');
insert into person values ('p40', 'Glen', 'Kelley');
insert into person values ('p41', 'Brooke', 'Little');
insert into person values ('p42', 'Daryl', 'Nguyen');
insert into person values ('p43', 'Judy', 'Willis');
insert into person values ('p44', 'Marco', 'Klein');
insert into person values ('p45', 'Angelica', 'Hampton');
insert into person values ('p46', 'Peppermint', 'Patty');
insert into person values ('p47', 'Charlie', 'Brown');
insert into person values ('p48', 'Lucy', 'van Pelt');
insert into person values ('p49', 'Linus', 'van Pelt');

create table passenger (
	personID varchar(50),
    miles integer default 0,
    funds integer default 0,
    primary key (personID),
    constraint fk6 foreign key (personID) references person (personID)
) engine = innodb;

insert into passenger values ('p21', 771, 700);
insert into passenger values ('p22', 374, 200);
insert into passenger values ('p23', 414, 400);
insert into passenger values ('p24', 292, 500);
insert into passenger values ('p25', 390, 300);
insert into passenger values ('p26', 302, 600);
insert into passenger values ('p27', 470, 400);
insert into passenger values ('p28', 208, 400);
insert into passenger values ('p29', 292, 700);
insert into passenger values ('p30', 686, 500);
insert into passenger values ('p31', 547, 400);
insert into passenger values ('p32', 257, 500);
insert into passenger values ('p33', 564, 600);
insert into passenger values ('p34', 211, 200);
insert into passenger values ('p35', 233, 500);
insert into passenger values ('p36', 293, 400);
insert into passenger values ('p37', 552, 700);
insert into passenger values ('p38', 812, 700);
insert into passenger values ('p39', 541, 400);
insert into passenger values ('p40', 441, 700);
insert into passenger values ('p41', 875, 300);
insert into passenger values ('p42', 691, 500);
insert into passenger values ('p43', 572, 300);
insert into passenger values ('p44', 572, 500);
insert into passenger values ('p45', 663, 500);
insert into passenger values ('p46', 1002, 300);
insert into passenger values ('p47', 4000, 800);
insert into passenger values ('p48', 244, 650);

create table person_occupies (
	personID varchar(50),
    locationID varchar(50),
    primary key (personID, locationID),
    constraint fk21 foreign key (personID) references person (personID)
		on update cascade on delete cascade,
    constraint fk22 foreign key (locationID) references location (locationID)
) engine = innodb;

insert into person_occupies values ('p21', 'ship_1');
insert into person_occupies values ('p22', 'ship_1');
insert into person_occupies values ('p23', 'ship_1');
insert into person_occupies values ('p24', 'ship_1');
insert into person_occupies values ('p1', 'ship_1');
insert into person_occupies values ('p2', 'ship_1');
insert into person_occupies values ('p12', 'ship_1');
insert into person_occupies values ('p25', 'ship_23');
insert into person_occupies values ('p26', 'ship_23');
insert into person_occupies values ('p27', 'ship_23');
insert into person_occupies values ('p28', 'ship_23');
insert into person_occupies values ('p3', 'ship_23');
insert into person_occupies values ('p4', 'ship_23');
insert into person_occupies values ('p29', 'ship_7');
insert into person_occupies values ('p6', 'ship_7');
insert into person_occupies values ('p0', 'port_1');
insert into person_occupies values ('p29', 'port_1');
insert into person_occupies values ('p30', 'port_1');
insert into person_occupies values ('p31', 'port_1');
insert into person_occupies values ('p32', 'port_1');
insert into person_occupies values ('p5', 'port_1');
insert into person_occupies values ('p6', 'port_1');
insert into person_occupies values ('p33', 'ship_24');
insert into person_occupies values ('p34', 'ship_24');
insert into person_occupies values ('p35', 'ship_24');
insert into person_occupies values ('p36', 'ship_24');
insert into person_occupies values ('p7', 'ship_24');
insert into person_occupies values ('p9', 'ship_24');
insert into person_occupies values ('p15', 'ship_24');
insert into person_occupies values ('p10', 'ship_24');
insert into person_occupies values ('p37', 'ship_26');
insert into person_occupies values ('p38', 'ship_26');
insert into person_occupies values ('p39', 'ship_26');
insert into person_occupies values ('p40', 'ship_26');
insert into person_occupies values ('p11', 'ship_26');
insert into person_occupies values ('p13', 'ship_26');
insert into person_occupies values ('p14', 'ship_26');
insert into person_occupies values ('p41', 'ship_25');
insert into person_occupies values ('p42', 'ship_25');
insert into person_occupies values ('p43', 'ship_25');
insert into person_occupies values ('p44', 'ship_25');
insert into person_occupies values ('p16', 'ship_25');
insert into person_occupies values ('p17', 'ship_25');
insert into person_occupies values ('p18', 'ship_25');
insert into person_occupies values ('p41', 'port_14');
insert into person_occupies values ('p42', 'port_14');
insert into person_occupies values ('p43', 'port_14');
insert into person_occupies values ('p44', 'port_14');
insert into person_occupies values ('p16', 'port_14');
insert into person_occupies values ('p17', 'port_14');
insert into person_occupies values ('p18', 'port_14');
insert into person_occupies values ('p8', 'ship_21');
insert into person_occupies values ('p19', 'ship_21');
insert into person_occupies values ('p20', 'ship_21');
insert into person_occupies values ('p45', 'port_7');
insert into person_occupies values ('p46', 'port_7');
insert into person_occupies values ('p47', 'port_7');
insert into person_occupies values ('p48', 'port_7');
insert into person_occupies values ('p8', 'port_7');
insert into person_occupies values ('p19', 'port_7');
insert into person_occupies values ('p20', 'port_7');

create table leg (
	legID varchar(50),
    distance integer not null,
    departure char(3) not null,
    arrival char(3) not null,
    primary key (legID),
    constraint fk10 foreign key (departure) references ship_port (portID),
    constraint fk11 foreign key (arrival) references ship_port (portID)
) engine = innodb;

insert into leg values ('leg_1', 792, 'NSU', 'SJN');
insert into leg values ('leg_2', 190, 'MIA', 'NSU');
insert into leg values ('leg_31', 1139, 'LAS', 'SEA');
insert into leg values ('leg_4', 29, 'MIA', 'EGS');
insert into leg values ('leg_14', 126, 'SEA', 'VAN');
insert into leg values ('leg_15', 312, 'MAR', 'CVA');
insert into leg values ('leg_27', 941, 'CVA', 'VEN');
insert into leg values ('leg_33', 855, 'VEN', 'PIR');
insert into leg values ('leg_47', 185, 'BCA', 'MAR');
insert into leg values ('leg_64', 427, 'STM', 'COP');
insert into leg values ('leg_78', 803, 'COP', 'SHA');

create table route (
	routeID varchar(50),
    primary key (routeID)
) engine = innodb;

insert into route values ('americas_one');
insert into route values ('americas_three');
insert into route values ('americas_two');
insert into route values ('big_mediterranean_loop');
insert into route values ('euro_north');
insert into route values ('euro_south');

create table route_path (
	routeID varchar(50),
    legID varchar(50) not null,
    sequence integer check (sequence > 0),
    primary key (routeID, sequence),
    constraint fk12 foreign key (routeID) references route (routeID),
    constraint fk13 foreign key (legID) references leg (legID)
) engine = innodb;


insert into route_path values ('americas_one', 'leg_2', 1);
insert into route_path values ('americas_one', 'leg_1', 2);
insert into route_path values ('americas_three', 'leg_31', 1);
insert into route_path values ('americas_three', 'leg_14', 2);
insert into route_path values ('americas_two', 'leg_4', 1);
insert into route_path values ('big_mediterranean_loop', 'leg_47', 1);
insert into route_path values ('big_mediterranean_loop', 'leg_15', 2);
insert into route_path values ('big_mediterranean_loop', 'leg_27', 3);
insert into route_path values ('big_mediterranean_loop', 'leg_33', 4);
insert into route_path values ('euro_north', 'leg_64', 1);
insert into route_path values ('euro_north', 'leg_78', 2);
insert into route_path values ('euro_south', 'leg_47', 1);
insert into route_path values ('euro_south', 'leg_15', 2);

create table cruise (
	cruiseID varchar(50),
    routeID varchar(50) not null,
    support_cruiseline varchar(50) default null,
    support_ship_name varchar(50) default null,
    progress integer default null,
    ship_status varchar(100) default null,
    next_time time default null,
    cost integer default 0,
	primary key (cruiseID),
    constraint fk14 foreign key (routeID) references route (routeID) on update cascade,
    constraint fk15 foreign key (support_cruiseline, support_ship_name) references ship (cruiselineID, ship_name)
		on update cascade on delete cascade
) engine = innodb;

insert into cruise values ('rc_10', 'americas_one', 'Royal Caribbean', 'Symphony of the Seas', 1, 'sailing', '08:00:00', 200);
insert into cruise values ('cn_38', 'americas_three', 'Carnival', 'Carnival Vista', 2, 'sailing', '14:30:00', 200);
insert into cruise values ('dy_61', 'americas_two', 'Disney', 'Disney Dream', 0, 'docked', '09:30:00', 200);
insert into cruise values ('nw_20', 'euro_north', 'Norwegian', 'Norwegian Bliss', 2, 'sailing', '11:00:00', 300);
insert into cruise values ('pn_16', 'euro_south', 'Ponant', 'Le Lyrial', 1, 'sailing', '14:00:00', 400);
insert into cruise values ('rc_51', 'big_mediterranean_loop', 'Royal Caribbean', 'Oasis of the Seas', 3, 'docked', '11:30:00', 100);
insert into cruise values ('hg_99', 'euro_south', 'Hurtigruten', 'MS Roald Amundsen', 2, 'docked', '12:30:00', 150);
insert into cruise values ('mc_47', 'euro_south', 'Cunard', 'Queen Mary 2', 2, 'docked', '14:30:00', 150);

create table passenger_books (
	personID varchar(50),
    cruiseID varchar(50),
    primary key (personID, cruiseID),
    constraint fk19 foreign key (personID) references person (personID)
		on update cascade on delete cascade,
    constraint fk20 foreign key (cruiseID) references cruise (cruiseID)
) engine = innodb;

insert into passenger_books values ('p21', 'rc_10');
insert into passenger_books values ('p22', 'rc_10');
insert into passenger_books values ('p23', 'rc_10');
insert into passenger_books values ('p24', 'rc_10');
insert into passenger_books values ('p25', 'cn_38');
insert into passenger_books values ('p26', 'cn_38');
insert into passenger_books values ('p27', 'cn_38');
insert into passenger_books values ('p28', 'cn_38');
insert into passenger_books values ('p29', 'dy_61');
insert into passenger_books values ('p30', 'dy_61');
insert into passenger_books values ('p31', 'dy_61');
insert into passenger_books values ('p32', 'dy_61');
insert into passenger_books values ('p33', 'nw_20');
insert into passenger_books values ('p34', 'nw_20');
insert into passenger_books values ('p35', 'nw_20');
insert into passenger_books values ('p36', 'nw_20');
insert into passenger_books values ('p37', 'pn_16');
insert into passenger_books values ('p38', 'pn_16');
insert into passenger_books values ('p39', 'pn_16');
insert into passenger_books values ('p40', 'pn_16');
insert into passenger_books values ('p41', 'rc_51');
insert into passenger_books values ('p42', 'rc_51');
insert into passenger_books values ('p43', 'rc_51');
insert into passenger_books values ('p44', 'rc_51');
insert into passenger_books values ('p45', 'hg_99');
insert into passenger_books values ('p46', 'hg_99');
insert into passenger_books values ('p47', 'hg_99');
insert into passenger_books values ('p48', 'hg_99');

create table crew (
	personID varchar(50),
    taxID varchar(50) not null,
    experience integer default 0,
    assigned_to varchar(50) default null,
    primary key (personID),
    unique key (taxID),
    constraint fk4 foreign key (personID) references person (personID),
    constraint fk9 foreign key (assigned_to) references cruise (cruiseID)
) engine = innodb;

insert into crew values ('p0', '560-14-7807', 20, null);
insert into crew values ('p1', '330-12-6907', 31, 'rc_10');
insert into crew values ('p2', '842-88-1257', 9, 'rc_10');
insert into crew values ('p12', '680-92-5329', 24, 'rc_10');
insert into crew values ('p3', '750-24-7616', 11, 'cn_38');
insert into crew values ('p4', '776-21-8098', 24, 'cn_38');
insert into crew values ('p5', '933-93-2165', 27, 'dy_61');
insert into crew values ('p6', '707-84-4555', 38, 'dy_61');
insert into crew values ('p7', '450-25-5617', 13, 'nw_20');
insert into crew values ('p9', '936-44-6941', 13, 'nw_20');
insert into crew values ('p15', '153-47-8101', 30, 'nw_20');
insert into crew values ('p10', '769-60-1266', 15, 'nw_20');
insert into crew values ('p11', '369-22-9505', 22, 'pn_16');
insert into crew values ('p13', '513-40-4168', 24, 'pn_16');
insert into crew values ('p14', '454-71-7847', 13, 'pn_16');
insert into crew values ('p16', '598-47-5172', 28, 'rc_51');
insert into crew values ('p17', '865-71-6800', 36, 'rc_51');
insert into crew values ('p18', '250-86-2784', 23, 'rc_51');
insert into crew values ('p8', '701-38-2179', 12, 'hg_99');
insert into crew values ('p19', '386-39-7881', 2, 'hg_99');
insert into crew values ('p20', '522-44-3098', 28, 'hg_99');

create table licenses (
	personID varchar(50),
    license varchar(100),
    primary key (personID, license),
    constraint fk5 foreign key (personID) references crew (personID)
		on update cascade on delete cascade
) engine = innodb;

insert into licenses values ('p0', 'ocean_liner');
insert into licenses values ('p1', 'ocean_liner');
insert into licenses values ('p2', 'river');
insert into licenses values ('p2', 'ocean_liner');
insert into licenses values ('p3', 'ocean_liner');
insert into licenses values ('p4', 'ocean_liner');
insert into licenses values ('p4', 'river');
insert into licenses values ('p5', 'ocean_liner');
insert into licenses values ('p6', 'ocean_liner');
insert into licenses values ('p6', 'river');
insert into licenses values ('p7', 'ocean_liner');
insert into licenses values ('p8', 'ocean_liner');
insert into licenses values ('p10', 'ocean_liner');
insert into licenses values ('p11', 'ocean_liner');
insert into licenses values ('p11', 'river');
insert into licenses values ('p12', 'river');
insert into licenses values ('p13', 'river');
insert into licenses values ('p14', 'ocean_liner');
insert into licenses values ('p14', 'river');
insert into licenses values ('p15', 'ocean_liner');
insert into licenses values ('p15', 'river');
insert into licenses values ('p16', 'ocean_liner');
insert into licenses values ('p17', 'ocean_liner');
insert into licenses values ('p17', 'river');
insert into licenses values ('p18', 'ocean_liner');
insert into licenses values ('p19', 'ocean_liner');
insert into licenses values ('p20', 'ocean_liner');
