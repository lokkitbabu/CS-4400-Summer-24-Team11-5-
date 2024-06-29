-- CS4400: Introduction to Database Systems: Monday, June 10, 2024
-- Simple Cruise Management System Course Project Database TEMPLATE (v0)
-- Team 11-5
-- Brady Thomas Coogan (bcoogan3)
-- Jeffrey William Craycraft (jcraycraft6)
-- Jeramy Alexander Jimenez (jjimenez76)
-- Luis Camilo Velez (lvelez9)
-- Lokkit Sanjay Babu Narayanan (lnarayanan7)
-- Directions:
-- Please follow all instructions for Phase II as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.
/* This is a standard preamble for most of our scripts. The intent is to establish
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
/* You must enter your tables definitions, along with your primary, unique and
foreign key
declarations, and data insertion statements here. You may sequence them in any
order that
works for you. When executed, your statements must create a functional database
that contains
all of the data, and supports as many of the constraints as reasonably possible. */

CREATE TABLE ROUTE (
    routeID VARCHAR(255) PRIMARY KEY
);

CREATE TABLE LEG (
    legID INT PRIMARY KEY,
    distance INT
);

CREATE TABLE contain (
    rID VARCHAR(255),
    lID INT,
    sequence INT,
    PRIMARY KEY (rID, lID),
    FOREIGN KEY (rID) REFERENCES ROUTE(routeID),
    FOREIGN KEY (lID) REFERENCES LEG(legID)
);

CREATE TABLE LOCATION (
    locID VARCHAR(255) PRIMARY KEY
);

CREATE TABLE prt (
    portID VARCHAR(255) PRIMARY KEY,
    pname VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    locID VARCHAR(255),
    FOREIGN KEY (locID) REFERENCES LOCATION(locID)
);

CREATE TABLE DEPARTS (
    lID INT,
    pID VARCHAR(255),
    PRIMARY KEY (lID, pID),
    FOREIGN KEY (lID) REFERENCES LEG(legID),
    FOREIGN KEY (pID) REFERENCES prt(portID)
);

CREATE TABLE ARRIVES (
    lID INT,
    pID VARCHAR(255),
    PRIMARY KEY (lID, pID),
    FOREIGN KEY (lID) REFERENCES LEG(legID),
    FOREIGN KEY (pID) REFERENCES prt(portID)
);

CREATE TABLE CRUISELINE (
    cruiselineID VARCHAR(255) PRIMARY KEY
);

CREATE TABLE SHIP (
    sname VARCHAR(255) PRIMARY KEY,
    max_cap INT,
    speed DECIMAL(5, 2),
    locID VARCHAR(255),
    cruiselineID VARCHAR(255),
    FOREIGN KEY (locID) REFERENCES LOCATION(locID),
    FOREIGN KEY (cruiselineID) REFERENCES CRUISELINE(cruiselineID)
);

CREATE TABLE RIVER (
    uses_paddles BOOLEAN,
    sname VARCHAR(255),
    cID VARCHAR(255),
    PRIMARY KEY (sname, cID),
    FOREIGN KEY (sname) REFERENCES SHIP(sname),
    FOREIGN KEY (cID) REFERENCES SHIP(cruiselineID)
);

CREATE TABLE OCEAN_LINER (
    lifeboats INT,
    sname VARCHAR(255),
    cID VARCHAR(255),
    PRIMARY KEY (sname, cID),
    FOREIGN KEY (sname) REFERENCES SHIP(sname),
    FOREIGN KEY (cID) REFERENCES SHIP(cruiselineID)
);

CREATE TABLE CRUISE (
    cruiseID VARCHAR(255) PRIMARY KEY,
    cost INT,
    rID VARCHAR(255),
    FOREIGN KEY (rID) REFERENCES ROUTE(routeID)
);

CREATE TABLE SUPPORTS (
    cID VARCHAR(255),
    sname VARCHAR(255),
    clineID VARCHAR(255),
    progress INT,
    sstatus VARCHAR(255),
    next_time TIME,
    PRIMARY KEY (cID, sname, clineID),
    FOREIGN KEY (cID) REFERENCES CRUISE(cruiseID),
    FOREIGN KEY (sname) REFERENCES SHIP(sname),
    FOREIGN KEY (cID) REFERENCES SHIP(cruiselineID)
);

CREATE TABLE PERSON (
    personID VARCHAR(255) PRIMARY KEY,
    plast VARCHAR(255),
    pfirst VARCHAR(255)
);

CREATE TABLE OCCUPIES (
    pID VARCHAR(255),
    lID VARCHAR(255),
    PRIMARY KEY (pID, lID),
    FOREIGN KEY (pID) REFERENCES PERSON(personID),
    FOREIGN KEY (lID) REFERENCES LOCATION(locID)
);

CREATE TABLE CREW (
    taxID VARCHAR(255) PRIMARY KEY,
    experience INT,
    pID VARCHAR(255),
    cID VARCHAR(255),
    FOREIGN KEY (pID) REFERENCES PERSON(personID),
    FOREIGN KEY (cID) REFERENCES CRUISE(cruiseID)
);

CREATE TABLE CREW_LICENSE (
    pID VARCHAR(255),
    license_name VARCHAR(255),
    PRIMARY KEY (pID, license_name),
    FOREIGN KEY (pID) REFERENCES PERSON(personID)
);

CREATE TABLE PASSENGER (
    pID VARCHAR(255) PRIMARY KEY,
    miles INT,
    funds INT,
    FOREIGN KEY (pID) REFERENCES PERSON(personID)
);

CREATE TABLE BOOKED (
    pID VARCHAR(255),
    cID VARCHAR(255),
    PRIMARY KEY (pID, cID),
    FOREIGN KEY (pID) REFERENCES PERSON(personID),
    FOREIGN KEY (cID) REFERENCES CRUISE(cruiseID)
);

insert into route values 
('americas_one'), ('americas_three'), ('americas_two'), 
('big_mediterranean_loop'), ('euro_north'), ('euro_south');

insert into cruise values
('rc_10', 1000, 'americas_one'),
('cn_38', 1200, 'americas_three'),
('dy_61', 1500, 'americas_two'),
('nw_20', 1800, 'americas_two'),
('pn_16', 2000, 'big_mediterranean_loop'),
('rc_51', 2200, 'americas_one');

insert into location values
('port_1'), ('port_2'), ('port_3'), ('port_10'), ('port_17'), 
('ship_1'), ('ship_5'), ('ship_8'), ('ship_13'), ('ship_20'),
('port_12'), ('port_14'), ('port_15'), ('port_20'), ('port_4'), 
('port_16'), ('port_11'), ('port_23'), ('port_7'), ('port_6'),
('port_13'), ('port_21'), ('port_18'), ('port_22'), ('ship_6'),
('ship_25'), ('ship_7'), ('ship_21'), ('ship_24'), ('ship_23'), 
('ship_18'), ('ship_22'), ('ship_26');

insert into leg values
(2,190),   -- mia(d) nsu(a)
(1,792),   -- nsu (d) sjn (a)  
(31,1139), -- las (d) sea(a)
(14,126),  -- sea(d) van(a)
(4,29),    -- mia (d) egs(a)
(47,185),  -- bca (d) mar (a)
(15,312),  -- mar(d) cva(a)
(27,941),  -- cva(d) ven(a) 
(33,855),  -- ven (d) pir(a)
(64,427),  -- stm(d) cop(a)
(78,803);  -- cop(d) sha(a)

insert into prt values
('MIA', 'Port of Miami', 'Miami', 'Florida', 'USA', 'port_1'),
('EGS', 'Port Everglades', 'Fort Lauderdale', 'Florida', 'USA', 'port_2'),
('CZL', 'Port of Cozumel', 'Cozumel', 'Quintana Roo', 'MEX', 'port_3'),
('CNL', 'Port Canaveral', 'Cape Canaveral', 'Florida', 'USA', 'port_4'),
('NSU', 'Port of Nassau', 'Nassau', 'New Providence', 'BHS', NULL),  
('BCA', 'Port of Barcelona', 'Barcelona', 'Catalonia', 'ESP', 'port_6'),
('CVA', 'Port of Civitavecchia', 'Civitavecchia', 'Lazio', 'ITA', 'port_7'),
('VEN', 'Port of Venice', 'Venice', 'Veneto', 'ITA', 'port_14'),
('SHA', 'Port of Southampton', 'Southampton', NULL, 'GBR', NULL),
('GVN', 'Port of Galveston', 'Galveston', 'Texas', 'USA', 'port_10'),
('SEA', 'Port of Seattle', 'Seattle', 'Washington', 'USA', 'port_11'),
('SJN', 'Port of San Juan', 'San Juan', 'Puerto Rico', 'USA', 'port_12'),
('NOS', 'Port of New Orleans', 'New Orleans', 'Louisiana', 'USA', 'port_13'),
('SYD', 'Port of Sydney', 'Sydney', 'New South Wales', 'AUS', NULL),
('TMP', 'Port of Tampa Bay', 'Tampa Bay', 'Florida', 'USA', 'port_15'),  
('VAN', 'Port of Vancouver', 'Vancouver', 'British Columbia', 'CAN', 'port_16'),
('MAR', 'Port of Marseille', 'Marseille', 'Provence-Alpes-Côte d''Azur', 'FRA', 'port_17'),
('COP', 'Port of Copenhagen', 'Copenhagen', 'Hovedstaden', 'DEN', 'port_18'),
('BRI', 'Port of Bridgetown', 'Bridgetown', 'Saint Michael', 'BRB', NULL),
('PIR', 'Port of Piraeus', 'Piraeus', 'Attica', 'GRC', 'port_20'),
('STS', 'Port of St. Thomas', 'Charlotte Amalie', 'St. Thomas', 'USVI', 'port_21'),  
('STM', 'Port of Stockholm', 'Stockholm', 'Stockholm County', 'SWE', 'port_22'),
('LAS', 'Port of Los Angeles', 'Los Angeles', 'California', 'USA', 'port_23');

insert into cruiseline values
('Royal Caribbean'), ('Carnival'), ('Norwegian'), ('MSC'), 
('Princess'), ('Celebrity'), ('Disney'), ('Holland America'),
('Costa'), ('P&O Cruises'), ('AIDA'), ('Viking Ocean'), 
('Silversea'), ('Regent'), ('Oceania'), ('Seabourn'),
('Cunard'), ('Azamara'), ('Windstar'), ('Hurtigruten'),  
('Paul Gauguin Cruises'), ('Celestyal Cruises'), ('Saga Cruises'),
('Ponant'), ('Star Clippers'), ('Marella Cruises');

insert into ship values
('Symphony of the Seas', 6680, 22, 'ship_1', 'Royal Caribbean'),
('Carnival Vista', 3934, 23, 'ship_23', 'Carnival'),
('Norwegian Bliss', 4004, 22.5, 'ship_24', 'Norwegian'),
('Meraviglia', 4488, 22.7, 'ship_22', 'MSC'),
('Crown Princess', 3080, 23, 'ship_5', 'Princess'),
('Celebrity Edge', 2908, 22, 'ship_6', 'Celebrity'),
('Disney Dream', 4000, 23.5, 'ship_7', 'Disney'),
('MS Nieuw Statendam', 2666, 23, 'ship_8', 'Holland America'),
('Costa Smeralda', 6554, 23, NULL, 'Costa'),  
('Iona', 5200, 22.6, NULL, 'P&O Cruises'),
('AIDAnova', 6600, 21.5, NULL, 'AIDA'),
('Viking Orion', 930, 20, NULL, 'Viking Ocean'),
('Silver Muse', 596, 19.8, 'ship_13', 'Silversea'),
('Seven Seas Explorer', 750, 19.5, NULL, 'Regent'),
('Marina', 1250, 20, NULL, 'Oceania'),  
('Seabourn Ovation', 604, 19, NULL, 'Seabourn'),
('Queen Mary 2', 2691, 30, NULL, 'Cunard'),
('Azamara Quest', 686, 18.5, 'ship_18', 'Azamara'), 
('Oasis of the Seas', 1325, 18, 'ship_25', 'Royal Caribbean'),
('Wind Surf', 342, 15, 'ship_20', 'Windstar'),
('MS Roald Amundsen', 530, 15.5, 'ship_21', 'Hurtigruten'),
('Paul Gauguin', 332, 18, NULL, 'Paul Gauguin Cruises'),  
('Celestyal Crystal', 1200, 18.5, NULL, 'Celestyal Cruises'),
('Spirit of Discovery', 999, 21, NULL, 'Saga Cruises'),
('Le Lyrial', 264, 16, 'ship_26', 'Ponant'),
('Royal Clipper', 227, 17, NULL, 'Star Clippers'),
('Marella Explorer', 1924, 21.5, NULL, 'Marella Cruises');

insert into river values
(TRUE, 'Azamara Quest', 'Azamara'),
(FALSE, 'Wind Surf', 'Windstar'),  
(False,'Celestyal Crystal','Celestyal Cruises' ),
(TRUE, 'MS Roald Amundsen', 'Hurtigruten'),
(TRUE, 'Le Lyrial', 'Ponant');

insert into ocean_liner values
(20, 'Symphony of the Seas', 'Royal Caribbean'),
(20, 'Carnival Vista', 'Carnival'),
(15, 'Norwegian Bliss', 'Norwegian'), 
(20, 'Meraviglia', 'MSC'),
(20, 'Crown Princess', 'Princess'),
(20, 'Celebrity Edge', 'Celebrity'),
(20, 'Disney Dream', 'Disney'),
(30, 'MS Nieuw Statendam', 'Holland America'), 
(30, 'Silver Muse', 'Silversea'),
(20, 'Costa Smeralda', 'Costa'),
(20, 'Iona', 'P&O Cruises'),
(35, 'AIDAnova', 'AIDA'), 
(20, 'Viking Orion', 'Viking Ocean'),
(20, 'Seven Seas Explorer', 'Regent'),
(25, 'Marina', 'Oceania'),
(20, 'Seabourn Ovation', 'Seabourn'),
(40, 'Queen Mary 2', 'Cunard'),
(30, 'Oasis of the Seas', 'Royal Caribbean');

insert into person values
('p1', 'Nelson', 'Jeanne'), ('p2', 'Byrd', 'Roxanne'), 
('p3', 'Nguyen', 'Tanya'), ('p4', 'Jacobs', 'Kendra'),
('p5', 'Burton', 'Jeff'), ('p6', 'Parks', 'Randal'), 
('p7', 'Owens', 'Sonya'), ('p8', 'Palmer', 'Bennie'),
('p9', 'Warner', 'Marlene'), ('p10', 'Morgan', 'Lawrence'),
('p11', 'Cruz', 'Sandra'), ('p12', 'Ball', 'Dan'),
('p13', 'Figueroa', 'Bryant'), ('p14', 'Perry', 'Dana'), 
('p15', 'Hunt', 'Matt'), ('p16', 'Brown', 'Edna'),
('p17', 'Burgess', 'Ruby'), ('p18', 'Pittman', 'Esther'),
('p19', 'Fowler', 'Doug'), ('p20', 'Olson', 'Thomas'), 
('p21', 'Harrison', 'Mona'), ('p22', 'Massey', 'Arlene'),
('p23', 'Patrick', 'Judith'), ('p24', 'Rhodes', 'Reginald'), 
('p25', 'Garcia', 'Vincent'), ('p26', 'Moore', 'Cheryl'),
('p27', 'Rivera', 'Michael'), ('p28', 'Matthews', 'Luther'),
('p29', 'Parks', 'Moses'), ('p30', 'Steele', 'Ora'), 
('p31', 'Flores', 'Antonio'), ('p32', 'Ross', 'Glenn'),
('p33', 'Thomas', 'Irma'), ('p34', 'Maldonado', 'Ann'), 
('p35', 'Cruz', 'Jeffrey'), ('p36', 'Price', 'Sonya'),
('p37', 'Hale', 'Tracy'), ('p38', 'Simmons', 'Albert'),
('p39', 'Terry', 'Karen'), ('p40', 'Kelley', 'Glen'), 
('p41', 'Little', 'Brooke'), ('p42', 'Nguyen', 'Daryl'),
('p43', 'Willis', 'Judy'), ('p44', 'Klein', 'Marco'), 
('p45', 'Hampton', 'Angelica');

insert into contain values
('americas_one', 2, 1), 
('americas_one', 1, 2),
('americas_three', 31, 1), 
('americas_three', 14, 2),
('americas_two', 4, 1),
('big_mediterranean_loop', 47, 1),
('big_mediterranean_loop', 15, 2), 
('big_mediterranean_loop', 27, 3),
('big_mediterranean_loop', 33, 4),
('euro_north', 64, 1), 
('euro_north', 78, 2),
('euro_south', 47, 1),
('euro_south', 15, 2);

insert into departs values
(2, 'MIA'),
(1, 'NSU'),
(31, 'LAS'),
(14, 'SEA'), 
(4, 'MIA'),
(47, 'BCA'), 
(15, 'MAR'),
(27, 'CVA'), 
(33, 'VEN'),
(64, 'STM'),
(78, 'COP');

insert into arrives values
(2, 'NSU'),
(1, 'SJN'), 
(31, 'SEA'),
(14, 'VAN'),
(4, 'EGS'),
(47, 'MAR'),
(15, 'CVA'),
(27, 'VEN'), 
(33, 'PIR'), 
(64, 'COP'),
(78, 'SHA');
  
insert into occupies values
('p1', 'ship_1'), ('p10', 'ship_24'), ('p13', 'ship_26'),
('p14', 'ship_26'), ('p16', 'ship_25'), ('p16', 'port_14'),  
('p17', 'ship_25'), ('p17', 'port_14'), ('p18', 'ship_25'),
('p18', 'port_14'), ('p21', 'ship_24'), ('p23', 'ship_1'), 
('p25', 'ship_1'), ('p37', 'ship_26'), ('p38', 'ship_26'),
('p2', 'ship_1'), ('p3', 'ship_23'), ('p4', 'ship_23'), 
('p5', 'ship_7'), ('p5', 'port_1'), ('p6', 'ship_7'), 
('p6', 'port_1'), ('p7', 'ship_24'), ('p9', 'ship_24');

insert into crew values
('330-12-6907', 31, 'p1', 'rc_10'), 
('842-88-1257', 9, 'p2', 'rc_10'),
('750-24-7616', 11, 'p3', 'cn_38'),
('776-21-8098', 24, 'p4', 'cn_38'),
('933-93-2165', 27, 'p5', 'dy_61'),
('707-84-4555', 38, 'p6', 'dy_61'),
('450-25-5617', 13, 'p7', 'nw_20'),
('701-38-2179', 12, 'p8', NULL),
('936-44-6941', 13, 'p9', 'nw_20'), 
('769-60-1266', 15, 'p10', 'nw_20'),
('369-22-9505', 22, 'p11', 'pn_16'),
('680-92-5329', 24, 'p12', NULL), 
('513-40-4168', 24, 'p13', 'pn_16'),
('454-71-7847', 13, 'p14', 'pn_16'),
('153-47-8101', 30, 'p15', NULL),
('598-47-5172', 28, 'p16', 'rc_51'), 
('865-71-6800', 36, 'p17', 'rc_51'),
('250-86-2784', 23, 'p18', 'rc_51'),
('386-39-7881', 2, 'p19', NULL),
('522-44-3098', 28, 'p20', NULL);

insert into crew_license values
('p1', 'ocean_liner'),
('p2', 'ocean_liner'), 
('p2', 'river'),
('p3', 'ocean_liner'),
('p4', 'ocean_liner'),
('p4', 'river'), 
('p5', 'ocean_liner'),
('p6', 'ocean_liner'),
('p6', 'river'),
('p7', 'ocean_liner'),
('p8', 'river'),
('p9', 'ocean_liner'),
('p9', 'river'), 
('p10', 'ocean_liner'),
('p11', 'ocean_liner'),
('p11', 'river'),
('p12', 'river'), 
('p13', 'river'),
('p14', 'ocean_liner'),
('p14', 'river'),
('p15', 'ocean_liner'), 
('p15', 'river'),
('p16', 'ocean_liner'),
('p17', 'ocean_liner'),
('p17', 'river'),
('p18', 'ocean_liner'),
('p19', 'ocean_liner'),
('p20', 'ocean_liner');

insert into passenger values
('p21', 771, 700),
('p22', 374, 200),
('p23', 414, 400),
('p24', 292, 500), 
('p25', 390, 300),
('p26', 302, 600),
('p27', 470, 400),
('p28', 208, 400),
('p29', 292, 700),
('p30', 686, 500), 
('p31', 547, 400),
('p32', 257, 500),
('p33', 564, 600),
('p34', 211, 200), 
('p35', 233, 500),
('p36', 293, 400),
('p37', 552, 700),
('p38', 812, 700),
('p39', 541, 400),
('p40', 441, 700), 
('p41', 875, 300),
('p42', 691, 500),
('p43', 572, 300),
('p44', 572, 500),
('p45', 663, 500);

insert into booked values
('p21', 'nw_20'),
('p23', 'rc_10'),
('p25', 'rc_10'),
('p37', 'pn_16'), 
('p38', 'pn_16');