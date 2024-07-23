-- CS4400: Introduction to Database Systems: Monday, July 1, 2024
-- Cruise Tracking Course Project: Limited Autograder [v3] OPEN to STUDENTS

/* This is a standard preamble for most of our scripts.  The intent is to establish
a consistent environment for the database behavior. */
set global transaction isolation level serializable;
set global SQL_MODE = 'ANSI,TRADITIONAL';
set names utf8mb4;
set SQL_SAFE_UPDATES = 0;

set @thisDatabase = 'cruise_tracking';
use cruise_tracking;
-- ----------------------------------------------------------------------------------
-- [1] Implement a capability to reset the database state easily
-- ----------------------------------------------------------------------------------

drop procedure if exists magic44_reset_database_state;
delimiter //
create procedure magic44_reset_database_state ()
begin
	-- Purge and then reload all of the database rows back into the tables.
    -- Ensure that the data is deleted in reverse order with respect to the
    -- foreign key dependencies (i.e., from children up to parents).
	delete from licenses;
	delete from crew;
	delete from route_path;
	delete from passenger_books;
    delete from cruise;
    delete from leg;
    delete from route;
    delete from person_occupies;
	delete from passenger;
	delete from person;
	delete from ship_port;
	delete from ship;
    delete from location;
    delete from cruiseline;

    -- Ensure that the data is inserted in order with respect to the
    -- foreign key dependencies (i.e., from parents down to children).
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

	insert into route values ('americas_one');
	insert into route values ('americas_three');
	insert into route values ('americas_two');
	insert into route values ('big_mediterranean_loop');
	insert into route values ('euro_north');
	insert into route values ('euro_south');

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

	insert into cruise values ('rc_10', 'americas_one', 'Royal Caribbean', 'Symphony of the Seas', 1, 'sailing', '08:00:00', 200);
	insert into cruise values ('cn_38', 'americas_three', 'Carnival', 'Carnival Vista', 2, 'sailing', '14:30:00', 200);
	insert into cruise values ('dy_61', 'americas_two', 'Disney', 'Disney Dream', 0, 'docked', '09:30:00', 200);
	insert into cruise values ('nw_20', 'euro_north', 'Norwegian', 'Norwegian Bliss', 2, 'sailing', '11:00:00', 300);
	insert into cruise values ('pn_16', 'euro_south', 'Ponant', 'Le Lyrial', 1, 'sailing', '14:00:00', 400);
	insert into cruise values ('rc_51', 'big_mediterranean_loop', 'Royal Caribbean', 'Oasis of the Seas', 3, 'docked', '11:30:00', 100);
	insert into cruise values ('hg_99', 'euro_south', 'Hurtigruten', 'MS Roald Amundsen', 2, 'docked', '12:30:00', 150);
    insert into cruise values ('mc_47', 'euro_south', 'Cunard', 'Queen Mary 2', 2, 'docked', '14:30:00', 150);

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

end //
delimiter ;

-- ----------------------------------------------------------------------------------
-- [2] Create views to evaluate the queries & transactions
-- ----------------------------------------------------------------------------------
    
-- Create one view per original base table and student-created view to be used
-- to evaluate the transaction results.
create or replace view practiceQuery10 as select * from cruiseline;
create or replace view practiceQuery11 as select * from location;
create or replace view practiceQuery12 as select * from ship;
create or replace view practiceQuery13 as select * from ship_port;
create or replace view practiceQuery14 as select * from person;
create or replace view practiceQuery15 as select * from passenger;
create or replace view practiceQuery16 as select * from person_occupies;
create or replace view practiceQuery17 as select * from leg;
create or replace view practiceQuery18 as select * from route;
create or replace view practiceQuery19 as select * from route_path;
create or replace view practiceQuery20 as select * from cruise;
create or replace view practiceQuery21 as select * from passenger_books;
create or replace view practiceQuery22 as select * from crew;
create or replace view practiceQuery23 as select * from licenses;

create or replace view practiceQuery30 as select * from cruises_at_sea;
create or replace view practiceQuery31 as select * from cruises_docked;
create or replace view practiceQuery32 as select * from people_at_sea;
create or replace view practiceQuery33 as select * from people_docked;
create or replace view practiceQuery34 as select * from route_summary;
create or replace view practiceQuery35 as select * from alternative_ports;

-- ----------------------------------------------------------------------------------
-- [3] Prepare to capture the query results for later analysis
-- ----------------------------------------------------------------------------------

-- The magic44_data_capture table is used to store the data created by the student's queries
-- The table is populated by the magic44_evaluate_queries stored procedure
-- The data in the table is used to populate the magic44_test_results table for analysis

drop table if exists magic44_data_capture;
create table magic44_data_capture (
	stepID integer, queryID integer,
    columnDump0 varchar(1000), columnDump1 varchar(1000), columnDump2 varchar(1000), columnDump3 varchar(1000), columnDump4 varchar(1000),
    columnDump5 varchar(1000), columnDump6 varchar(1000), columnDump7 varchar(1000), columnDump8 varchar(1000), columnDump9 varchar(1000),
	columnDump10 varchar(1000), columnDump11 varchar(1000), columnDump12 varchar(1000), columnDump13 varchar(1000), columnDump14 varchar(1000)
);

-- The magic44_column_listing table is used to help prepare the insert statements for the magic44_data_capture
-- table for the student's queries which may have variable numbers of columns (the table is prepopulated)

drop table if exists magic44_column_listing;
create table magic44_column_listing (
	columnPosition integer,
    simpleColumnName varchar(50),
    nullColumnName varchar(50)
);

insert into magic44_column_listing (columnPosition, simpleColumnName) values
(0, 'columnDump0'), (1, 'columnDump1'), (2, 'columnDump2'), (3, 'columnDump3'), (4, 'columnDump4'),
(5, 'columnDump5'), (6, 'columnDump6'), (7, 'columnDump7'), (8, 'columnDump8'), (9, 'columnDump9'),
(10, 'columnDump10'), (11, 'columnDump11'), (12, 'columnDump12'), (13, 'columnDump13'), (14, 'columnDump14');

drop function if exists magic44_gen_simple_template;
delimiter //
create function magic44_gen_simple_template(numberOfColumns integer)
	returns varchar(1000) reads sql data
begin
	return (select group_concat(simpleColumnName separator ', ') from magic44_column_listing
	where columnPosition < numberOfColumns);
end //
delimiter ;

-- Create a variable to effectively act as a program counter for the testing process/steps
set @stepCounter = 0;

-- The magic44_query_capture function is used to construct the instruction
-- that can be used to execute and store the results of a query

drop function if exists magic44_query_capture;
delimiter //
create function magic44_query_capture(thisQuery integer)
	returns varchar(2000) reads sql data
begin
	set @numberOfColumns = (select count(*) from information_schema.columns
		where table_schema = @thisDatabase
        and table_name = concat('practiceQuery', thisQuery));

	set @buildQuery = 'insert into magic44_data_capture (stepID, queryID, ';
    set @buildQuery = concat(@buildQuery, magic44_gen_simple_template(@numberOfColumns));
    set @buildQuery = concat(@buildQuery, ') select ');
    set @buildQuery = concat(@buildQuery, @stepCounter, ', ');
    set @buildQuery = concat(@buildQuery, thisQuery, ', practiceQuery');
    set @buildQuery = concat(@buildQuery, thisQuery, '.* from practiceQuery');
    set @buildQuery = concat(@buildQuery, thisQuery, ';');

return @buildQuery;
end //
delimiter ;

drop function if exists magic44_query_exists;
delimiter //
create function magic44_query_exists(thisQuery integer)
	returns integer deterministic
begin
	return (select exists (select * from information_schema.views
		where table_schema = @thisDatabase
        and table_name like concat('practiceQuery', thisQuery)));
end //
delimiter ;

-- Exception checking has been implemented to prevent (as much as reasonably possible) errors
-- in the queries being evaluated from interrupting the testing process
-- The magic44_log_query_errors table captures these errors for later review

drop table if exists magic44_log_query_errors;
create table magic44_log_query_errors (
	step_id integer,
    query_id integer,
    query_text varchar(2000),
    error_code char(5),
    error_message text
);

drop procedure if exists magic44_query_check_and_run;
delimiter //
create procedure magic44_query_check_and_run(in thisQuery integer)
begin
	declare err_code char(5) default '00000';
    declare err_msg text;

	declare continue handler for SQLEXCEPTION
    begin
		get diagnostics condition 1
			err_code = RETURNED_SQLSTATE, err_msg = MESSAGE_TEXT;
	end;

    declare continue handler for SQLWARNING
    begin
		get diagnostics condition 1
			err_code = RETURNED_SQLSTATE, err_msg = MESSAGE_TEXT;
	end;

	if magic44_query_exists(thisQuery) then
		set @sql_text = magic44_query_capture(thisQuery);
		prepare statement from @sql_text;
        execute statement;
        if err_code <> '00000' then
			insert into magic44_log_query_errors values (@stepCounter, thisQuery, @sql_text, err_code, err_msg);
		end if;
        deallocate prepare statement;
	end if;
end //
delimiter ;

-- ----------------------------------------------------------------------------------
-- [4] Organize the testing results by step and query identifiers
-- ----------------------------------------------------------------------------------

drop table if exists magic44_test_case_directory;
create table if not exists magic44_test_case_directory (
	base_step_id integer,
	number_of_steps integer,
    query_label char(20),
    query_name varchar(100),
    scoring_weight integer
);

insert into magic44_test_case_directory values
(0, 1, '[V_0]', 'initial_state_check', 0),
(20, 1, '[C_1]', 'add_ship', 4),
(40, 1, '[C_2]', 'add_port', 4),
(60, 1, '[C_3]', 'add_person', 4),
(80, 1, '[C_4]', 'grant_or_revoke_crew_license', 4),
(100, 1, '[C_5]', 'offer_cruise', 5),
(120, 1, '[U_1]', 'cruise_arriving', 7),
(140, 1, '[U_2]', 'cruise_departing', 7),
(160, 1, '[U_3]', 'person_boards', 10),
(180, 1, '[U_4]', 'person_disembarks', 10),
(200, 1, '[U_5]', 'assign_crew', 6),
(220, 1, '[R_1]', 'recycle_crew', 5),
(240, 1, '[R_2]', 'retire_cruise', 5),
(280, 1, '[V_1]', 'cruises_at_sea', 5),
(300, 1, '[V_2]', 'cruises_docked', 5),
(320, 1, '[V_3]', 'people_at_sea', 5),
(340, 1, '[V_4]', 'people_docked', 5),
(360, 1, '[V_5]', 'route_summary', 5),
(380, 1, '[V_6]', 'alternative_ports', 4);

drop table if exists magic44_scores_guide;
create table if not exists magic44_scores_guide (
    score_tag char(1),
    score_category varchar(100),
    display_order integer
);

insert into magic44_scores_guide values
('C', 'Create Transactions', 1), ('U', 'Use Case Transactions', 2),
('R', 'Remove Transactions', 3), ('V', 'Global Views/Queries', 4);

-- ----------------------------------------------------------------------------------
-- [5] Test the queries & transactions and store the results
-- ----------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------
/* Check that the initial state of their database matches the required configuration.
The magic44_reset_database_state() call is deliberately missing in order to evaluate
the state of the submitted database. */
-- ----------------------------------------------------------------------------------
set @stepCounter = 0;
call magic44_query_check_and_run(10); -- cruiseline
call magic44_query_check_and_run(11); -- location
call magic44_query_check_and_run(12); -- ship
call magic44_query_check_and_run(13); -- ship_port
call magic44_query_check_and_run(14); -- person
call magic44_query_check_and_run(15); -- passenger
call magic44_query_check_and_run(16); -- person_occupies
call magic44_query_check_and_run(17); -- leg
call magic44_query_check_and_run(18); -- route
call magic44_query_check_and_run(19); -- route_path
call magic44_query_check_and_run(20); -- cruise
call magic44_query_check_and_run(21); -- passenger_books
call magic44_query_check_and_run(22); -- crew
call magic44_query_check_and_run(23); -- licenses

-- ----------------------------------------------------------------------------------
/* Check the unit test cases here.  The magic44_reset_database_state() call is used
for each test to ensure that the database state is set to the initial configuration.
The @stepCounter is set to index the test appropriately, and then the test call is
performed.  Finally, calls are made to the appropriate database tables to compare the
actual state changes to the expected state changes per our answer key. */
-- ----------------------------------------------------------------------------------
-- [1] add_ship() SUCCESS case(s)
-- Add test cases that satisfy all guard conditions and change the database state
call magic44_reset_database_state();
set @stepCounter = 20;
call add_ship('Carnival', 'Firenze', 4126, 18, 'ship_41', 'ocean_liner', null, 20);
call magic44_query_check_and_run(12); -- ship

-- [2] add_ship_port() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 40;
call add_port('PDM', 'Port of The Balearic Islands', 'Palma', 'Majorca', 'ESP', 'port_33');
call magic44_query_check_and_run(13); -- ship_port

-- [3] add_person() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 60;
call add_person('p61', 'Sabrina', 'Duncan', 'port_1', '366-50-3732', 27, null, null);
call magic44_query_check_and_run(14); -- person
call magic44_query_check_and_run(16); -- person_occupies
call magic44_query_check_and_run(22); -- crew
call magic44_query_check_and_run(15); -- passenger

-- [4] grant_or_revoke_crew_license() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 80;
call grant_or_revoke_crew_license('p1','river');
call magic44_query_check_and_run(23); -- licenses

-- [5] offer_cruise() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 100;
call offer_cruise('ca_41', 'americas_three', 'Costa', 'Costa Smeralda', 0, '11:30:00', 400);
call magic44_query_check_and_run(20); -- cruise

-- [6] cruise_arriving() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 120;
call cruise_arriving('cn_38');
call magic44_query_check_and_run(22); -- crew
call magic44_query_check_and_run(15); -- passenger
call magic44_query_check_and_run(20); -- cruise
call magic44_query_check_and_run(16); -- person_occupies

-- [7] cruise_departing() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 140;
call cruise_departing('dy_61');
call magic44_query_check_and_run(20); -- cruise
call magic44_query_check_and_run(16); -- person_occupies

-- [8] person_boards() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 160;
call person_boards('p5', 'dy_61');
call magic44_query_check_and_run(16); -- person_occupies

-- [9] person_disembarks() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 180;
call person_disembarks('p41', 'rc_51');
call magic44_query_check_and_run(16); -- person_occupies

-- [10] assign_crew() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 200;
call assign_crew('dy_61', 'p0');
call magic44_query_check_and_run(14); -- person
call magic44_query_check_and_run(22); -- crew

-- [11] recycle_crew() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 220;
call recycle_crew('hg_99');
call magic44_query_check_and_run(14); -- person
call magic44_query_check_and_run(22); -- crew

-- [12] retire_cruise() SUCCESS case(s)
call magic44_reset_database_state();
set @stepCounter = 240;
call retire_cruise('mc_47');
call magic44_query_check_and_run(20); -- cruise

-- [13] cruises_at_sea() INITIAL case
call magic44_reset_database_state();
set @stepCounter = 280;
call magic44_query_check_and_run(30); -- cruises_at_sea

-- [14] cruises_docked() INITIAL case
call magic44_reset_database_state();
set @stepCounter = 300;
call magic44_query_check_and_run(31); -- cruises_docked

-- [15] people_at_sea() INITIAL case
call magic44_reset_database_state();
set @stepCounter = 320;
call magic44_query_check_and_run(32); -- people_at_sea

-- [16] people_docked() INITIAL case
call magic44_reset_database_state();
set @stepCounter = 340;
call magic44_query_check_and_run(33); -- people_docked

-- [17] route_summary() INITIAL case
call magic44_reset_database_state();
set @stepCounter = 360;
call magic44_query_check_and_run(34); -- route_summary

-- [18] alternative_ports() INITIAL case
call magic44_reset_database_state();
set @stepCounter = 380;
call magic44_query_check_and_run(35); -- alternative_ports

-- for consistency with the initial database state after testing
call magic44_reset_database_state();

-- ----------------------------------------------------------------------------------
-- [6] Collect and analyze the testing results for the student's submission
-- ----------------------------------------------------------------------------------

-- These tables are used to store the answers and test results.  The answers are generated by executing
-- the test script against our reference solution.  The test results are collected by running the test
-- script against your submission in order to compare the results.

-- The results from magic44_data_capture are transferred into the magic44_test_results table
drop table if exists magic44_test_results;
create table magic44_test_results (
	step_id integer not null,
    query_id integer,
	row_hash varchar(2000) not null
);

insert into magic44_test_results
select stepID, queryID, concat_ws('#', ifnull(columndump0, ''), ifnull(columndump1, ''), ifnull(columndump2, ''), ifnull(columndump3, ''),
ifnull(columndump4, ''), ifnull(columndump5, ''), ifnull(columndump6, ''), ifnull(columndump7, ''), ifnull(columndump8, ''), ifnull(columndump9, ''),
ifnull(columndump10, ''), ifnull(columndump11, ''), ifnull(columndump12, ''), ifnull(columndump13, ''), ifnull(columndump14, ''))
from magic44_data_capture;

-- the answers generated from the reference solution are loaded below
drop table if exists magic44_expected_results;
create table magic44_expected_results (
	step_id integer not null,
    query_id integer,
	row_hash varchar(2000) not null,
    index (step_id),
    index (query_id)
);

insert into magic44_expected_results values
(0,10,'aida##############'),
(0,10,'azamara##############'),
(0,10,'carnival##############'),
(0,10,'celebrity##############'),
(0,10,'celestyalcruises##############'),
(0,10,'costa##############'),
(0,10,'cunard##############'),
(0,10,'disney##############'),
(0,10,'hollandamerica##############'),
(0,10,'hurtigruten##############'),
(0,10,'marellacruises##############'),
(0,10,'msc##############'),
(0,10,'norwegian##############'),
(0,10,'oceania##############'),
(0,10,'p&ocruises##############'),
(0,10,'paulgauguincruises##############'),
(0,10,'ponant##############'),
(0,10,'princess##############'),
(0,10,'regent##############'),
(0,10,'royalcaribbean##############'),
(0,10,'sagacruises##############'),
(0,10,'seabourn##############'),
(0,10,'silversea##############'),
(0,10,'starclippers##############'),
(0,10,'vikingocean##############'),
(0,10,'windstar##############'),
(0,11,'port_1##############'),
(0,11,'port_10##############'),
(0,11,'port_11##############'),
(0,11,'port_12##############'),
(0,11,'port_13##############'),
(0,11,'port_14##############'),
(0,11,'port_15##############'),
(0,11,'port_16##############'),
(0,11,'port_17##############'),
(0,11,'port_18##############'),
(0,11,'port_19##############'),
(0,11,'port_2##############'),
(0,11,'port_20##############'),
(0,11,'port_21##############'),
(0,11,'port_22##############'),
(0,11,'port_23##############'),
(0,11,'port_3##############'),
(0,11,'port_4##############'),
(0,11,'port_5##############'),
(0,11,'port_6##############'),
(0,11,'port_7##############'),
(0,11,'port_8##############'),
(0,11,'port_9##############'),
(0,11,'ship_1##############'),
(0,11,'ship_10##############'),
(0,11,'ship_11##############'),
(0,11,'ship_12##############'),
(0,11,'ship_13##############'),
(0,11,'ship_14##############'),
(0,11,'ship_15##############'),
(0,11,'ship_16##############'),
(0,11,'ship_17##############'),
(0,11,'ship_18##############'),
(0,11,'ship_19##############'),
(0,11,'ship_2##############'),
(0,11,'ship_20##############'),
(0,11,'ship_21##############'),
(0,11,'ship_22##############'),
(0,11,'ship_23##############'),
(0,11,'ship_24##############'),
(0,11,'ship_25##############'),
(0,11,'ship_26##############'),
(0,11,'ship_27##############'),
(0,11,'ship_3##############'),
(0,11,'ship_4##############'),
(0,11,'ship_5##############'),
(0,11,'ship_6##############'),
(0,11,'ship_7##############'),
(0,11,'ship_8##############'),
(0,11,'ship_9##############'),
(0,12,'aida#aidanova#6600#21.5#ship_4#ocean_liner##35#######'),
(0,12,'azamara#azamaraquest#686#18.5#ship_18#river#1########'),
(0,12,'carnival#carnivalvista#3934#23#ship_23#ocean_liner##2#######'),
(0,12,'celebrity#celebrityedge#2908#22#ship_6#ocean_liner##20#######'),
(0,12,'celestyalcruises#celestyalcrystal#1200#18.5#ship_16#river#0########'),
(0,12,'costa#costasmeralda#6554#23#ship_2##########'),
(0,12,'cunard#queenmary2#2691#30#ship_14#ocean_liner##40#######'),
(0,12,'disney#disneydream#4000#23.5#ship_7#ocean_liner##20#######'),
(0,12,'hollandamerica#msnieuwstatendam#2666#23#ship_8#ocean_liner##30#######'),
(0,12,'hurtigruten#msroaldamundsen#530#15.5#ship_21#ocean_liner##10#######'),
(0,12,'marellacruises#marellaexplorer#1924#21.5#ship_27#ocean_liner##2#######'),
(0,12,'msc#meraviglia#4488#22.700000762939453#ship_22#ocean_liner##20#######'),
(0,12,'norwegian#norwegianbliss#4004#22.5#ship_24#ocean_liner##15#######'),
(0,12,'oceania#marina#1250#20#ship_11#ocean_liner##25#######'),
(0,12,'p&ocruises#iona#5200#22.600000381469727#ship_3#ocean_liner##20#######'),
(0,12,'paulgauguincruises#paulgauguin#332#18#ship_15##########'),
(0,12,'ponant#lelyrial#264#16#ship_26#river#1########'),
(0,12,'princess#crownprincess#3080#23#ship_5#ocean_liner##20#######'),
(0,12,'regent#sevenseasexplorer#750#19.5#ship_10#ocean_liner##20#######'),
(0,12,'royalcaribbean#oasisoftheseas#1325#18#ship_25#ocean_liner##30#######'),
(0,12,'royalcaribbean#symphonyoftheseas#6680#22#ship_1#ocean_liner##20#######'),
(0,12,'sagacruises#spiritofdiscovery#999#21#ship_17#ocean_liner##2#######'),
(0,12,'seabourn#seabournovation#604#19#ship_12#ocean_liner##20#######'),
(0,12,'silversea#silvermuse#596#19.799999237060547#ship_13#ocean_liner##30#######'),
(0,12,'starclippers#royalclipper#227#17#ship_19#river#1########'),
(0,12,'vikingocean#vikingorion#930#20#ship_9#ocean_liner##20#######'),
(0,12,'windstar#windsurf#342#15#ship_20#river#0########'),
(0,13,'bca#portofbarcelona#barcelona#catalonia#esp#port_6#########'),
(0,13,'bri#portofbridgetown#bridgetown#saintmichael#brb#port_19#########'),
(0,13,'cnl#portcanaveral#capecanaveral#florida#usa#port_4#########'),
(0,13,'cop#portofcopenhagen#copenhagen#hovedstaden#den#port_18#########'),
(0,13,'cva#portofcivitavecchia#civitavecchia#lazio#ita#port_7#########'),
(0,13,'czl#portofcozumel#cozumel#quintanaroo#mex#port_3#########'),
(0,13,'egs#porteverglades#fortlauderdale#florida#usa#port_2#########'),
(0,13,'gvn#portofgalveston#galveston#texas#usa#port_10#########'),
(0,13,'las#portoflosangeles#losangeles#california#usa#port_23#########'),
(0,13,'mar#portofmarseille#marseille#provence-alpes-côted\'azur#fra#port_17#########'),
(0,13,'mia#portofmiami#miami#florida#usa#port_1#########'),
(0,13,'nos#portofneworleans#neworleans#louisiana#usa#port_13#########'),
(0,13,'nsu#portofnassau#nassau#newprovidence#bhs#port_5#########'),
(0,13,'pir#portofpiraeus#piraeus#attica#grc#port_20#########'),
(0,13,'sea#portofseattle#seattle#washington#usa#port_11#########'),
(0,13,'sha#portofsouthampton#southhampton#hampshire#gbr#port_8#########'),
(0,13,'sjn#portofsanjuan#sanjuan#puertorico#usa#port_12#########'),
(0,13,'stm#portofstockholm#stockholm#stockholmcounty#swe#port_22#########'),
(0,13,'sts#portofst.thomas#charlotteamalie#st.thomas#usv#port_21#########'),
(0,13,'syd#portofsydney#sydney#newsouthwales#aus#port_9#########'),
(0,13,'tmp#portoftampabay#tampabay#florida#usa#port_15#########'),
(0,13,'van#portofvancouver#vancouver#britishcolumbia#can#port_16#########'),
(0,13,'ven#portofvenice#venice#veneto#ita#port_14#########'),
(0,14,'p0#martin#vanbasten############'),
(0,14,'p1#jeanne#nelson############'),
(0,14,'p10#lawrence#morgan############'),
(0,14,'p11#sandra#cruz############'),
(0,14,'p12#dan#ball############'),
(0,14,'p13#bryant#figueroa############'),
(0,14,'p14#dana#perry############'),
(0,14,'p15#matt#hunt############'),
(0,14,'p16#edna#brown############'),
(0,14,'p17#ruby#burgess############'),
(0,14,'p18#esther#pittman############'),
(0,14,'p19#doug#fowler############'),
(0,14,'p2#roxanne#byrd############'),
(0,14,'p20#thomas#olson############'),
(0,14,'p21#mona#harrison############'),
(0,14,'p22#arlene#massey############'),
(0,14,'p23#judith#patrick############'),
(0,14,'p24#reginald#rhodes############'),
(0,14,'p25#vincent#garcia############'),
(0,14,'p26#cheryl#moore############'),
(0,14,'p27#michael#rivera############'),
(0,14,'p28#luther#matthews############'),
(0,14,'p29#moses#parks############'),
(0,14,'p3#tanya#nguyen############'),
(0,14,'p30#ora#steele############'),
(0,14,'p31#antonio#flores############'),
(0,14,'p32#glenn#ross############'),
(0,14,'p33#irma#thomas############'),
(0,14,'p34#ann#maldonado############'),
(0,14,'p35#jeffrey#cruz############'),
(0,14,'p36#sonya#price############'),
(0,14,'p37#tracy#hale############'),
(0,14,'p38#albert#simmons############'),
(0,14,'p39#karen#terry############'),
(0,14,'p4#kendra#jacobs############'),
(0,14,'p40#glen#kelley############'),
(0,14,'p41#brooke#little############'),
(0,14,'p42#daryl#nguyen############'),
(0,14,'p43#judy#willis############'),
(0,14,'p44#marco#klein############'),
(0,14,'p45#angelica#hampton############'),
(0,14,'p46#peppermint#patty############'),
(0,14,'p47#charlie#brown############'),
(0,14,'p48#lucy#vanpelt############'),
(0,14,'p49#linus#vanpelt############'),
(0,14,'p5#jeff#burton############'),
(0,14,'p6#randal#parks############'),
(0,14,'p7#sonya#owens############'),
(0,14,'p8#bennie#palmer############'),
(0,14,'p9#marlene#warner############'),
(0,15,'p21#771#700############'),
(0,15,'p22#374#200############'),
(0,15,'p23#414#400############'),
(0,15,'p24#292#500############'),
(0,15,'p25#390#300############'),
(0,15,'p26#302#600############'),
(0,15,'p27#470#400############'),
(0,15,'p28#208#400############'),
(0,15,'p29#292#700############'),
(0,15,'p30#686#500############'),
(0,15,'p31#547#400############'),
(0,15,'p32#257#500############'),
(0,15,'p33#564#600############'),
(0,15,'p34#211#200############'),
(0,15,'p35#233#500############'),
(0,15,'p36#293#400############'),
(0,15,'p37#552#700############'),
(0,15,'p38#812#700############'),
(0,15,'p39#541#400############'),
(0,15,'p40#441#700############'),
(0,15,'p41#875#300############'),
(0,15,'p42#691#500############'),
(0,15,'p43#572#300############'),
(0,15,'p44#572#500############'),
(0,15,'p45#663#500############'),
(0,15,'p46#1002#300############'),
(0,15,'p47#4000#800############'),
(0,15,'p48#244#650############'),
(0,16,'p0#port_1#############'),
(0,16,'p29#port_1#############'),
(0,16,'p30#port_1#############'),
(0,16,'p31#port_1#############'),
(0,16,'p32#port_1#############'),
(0,16,'p5#port_1#############'),
(0,16,'p6#port_1#############'),
(0,16,'p16#port_14#############'),
(0,16,'p17#port_14#############'),
(0,16,'p18#port_14#############'),
(0,16,'p41#port_14#############'),
(0,16,'p42#port_14#############'),
(0,16,'p43#port_14#############'),
(0,16,'p44#port_14#############'),
(0,16,'p19#port_7#############'),
(0,16,'p20#port_7#############'),
(0,16,'p45#port_7#############'),
(0,16,'p46#port_7#############'),
(0,16,'p47#port_7#############'),
(0,16,'p48#port_7#############'),
(0,16,'p8#port_7#############'),
(0,16,'p1#ship_1#############'),
(0,16,'p12#ship_1#############'),
(0,16,'p2#ship_1#############'),
(0,16,'p21#ship_1#############'),
(0,16,'p22#ship_1#############'),
(0,16,'p23#ship_1#############'),
(0,16,'p24#ship_1#############'),
(0,16,'p19#ship_21#############'),
(0,16,'p20#ship_21#############'),
(0,16,'p8#ship_21#############'),
(0,16,'p25#ship_23#############'),
(0,16,'p26#ship_23#############'),
(0,16,'p27#ship_23#############'),
(0,16,'p28#ship_23#############'),
(0,16,'p3#ship_23#############'),
(0,16,'p4#ship_23#############'),
(0,16,'p10#ship_24#############'),
(0,16,'p15#ship_24#############'),
(0,16,'p33#ship_24#############'),
(0,16,'p34#ship_24#############'),
(0,16,'p35#ship_24#############'),
(0,16,'p36#ship_24#############'),
(0,16,'p7#ship_24#############'),
(0,16,'p9#ship_24#############'),
(0,16,'p16#ship_25#############'),
(0,16,'p17#ship_25#############'),
(0,16,'p18#ship_25#############'),
(0,16,'p41#ship_25#############'),
(0,16,'p42#ship_25#############'),
(0,16,'p43#ship_25#############'),
(0,16,'p44#ship_25#############'),
(0,16,'p11#ship_26#############'),
(0,16,'p13#ship_26#############'),
(0,16,'p14#ship_26#############'),
(0,16,'p37#ship_26#############'),
(0,16,'p38#ship_26#############'),
(0,16,'p39#ship_26#############'),
(0,16,'p40#ship_26#############'),
(0,16,'p29#ship_7#############'),
(0,16,'p6#ship_7#############'),
(0,17,'leg_1#792#nsu#sjn###########'),
(0,17,'leg_14#126#sea#van###########'),
(0,17,'leg_15#312#mar#cva###########'),
(0,17,'leg_2#190#mia#nsu###########'),
(0,17,'leg_27#941#cva#ven###########'),
(0,17,'leg_31#1139#las#sea###########'),
(0,17,'leg_33#855#ven#pir###########'),
(0,17,'leg_4#29#mia#egs###########'),
(0,17,'leg_47#185#bca#mar###########'),
(0,17,'leg_64#427#stm#cop###########'),
(0,17,'leg_78#803#cop#sha###########'),
(0,18,'americas_one##############'),
(0,18,'americas_three##############'),
(0,18,'americas_two##############'),
(0,18,'big_mediterranean_loop##############'),
(0,18,'euro_north##############'),
(0,18,'euro_south##############'),
(0,19,'americas_one#leg_1#2############'),
(0,19,'americas_three#leg_14#2############'),
(0,19,'big_mediterranean_loop#leg_15#2############'),
(0,19,'euro_south#leg_15#2############'),
(0,19,'americas_one#leg_2#1############'),
(0,19,'big_mediterranean_loop#leg_27#3############'),
(0,19,'americas_three#leg_31#1############'),
(0,19,'big_mediterranean_loop#leg_33#4############'),
(0,19,'americas_two#leg_4#1############'),
(0,19,'big_mediterranean_loop#leg_47#1############'),
(0,19,'euro_south#leg_47#1############'),
(0,19,'euro_north#leg_64#1############'),
(0,19,'euro_north#leg_78#2############'),
(0,20,'cn_38#americas_three#carnival#carnivalvista#2#sailing#14:30:00#200#######'),
(0,20,'dy_61#americas_two#disney#disneydream#0#docked#09:30:00#200#######'),
(0,20,'hg_99#euro_south#hurtigruten#msroaldamundsen#2#docked#12:30:00#150#######'),
(0,20,'mc_47#euro_south#cunard#queenmary2#2#docked#14:30:00#150#######'),
(0,20,'nw_20#euro_north#norwegian#norwegianbliss#2#sailing#11:00:00#300#######'),
(0,20,'pn_16#euro_south#ponant#lelyrial#1#sailing#14:00:00#400#######'),
(0,20,'rc_10#americas_one#royalcaribbean#symphonyoftheseas#1#sailing#08:00:00#200#######'),
(0,20,'rc_51#big_mediterranean_loop#royalcaribbean#oasisoftheseas#3#docked#11:30:00#100#######'),
(0,21,'p25#cn_38#############'),
(0,21,'p26#cn_38#############'),
(0,21,'p27#cn_38#############'),
(0,21,'p28#cn_38#############'),
(0,21,'p29#dy_61#############'),
(0,21,'p30#dy_61#############'),
(0,21,'p31#dy_61#############'),
(0,21,'p32#dy_61#############'),
(0,21,'p45#hg_99#############'),
(0,21,'p46#hg_99#############'),
(0,21,'p47#hg_99#############'),
(0,21,'p48#hg_99#############'),
(0,21,'p33#nw_20#############'),
(0,21,'p34#nw_20#############'),
(0,21,'p35#nw_20#############'),
(0,21,'p36#nw_20#############'),
(0,21,'p37#pn_16#############'),
(0,21,'p38#pn_16#############'),
(0,21,'p39#pn_16#############'),
(0,21,'p40#pn_16#############'),
(0,21,'p21#rc_10#############'),
(0,21,'p22#rc_10#############'),
(0,21,'p23#rc_10#############'),
(0,21,'p24#rc_10#############'),
(0,21,'p41#rc_51#############'),
(0,21,'p42#rc_51#############'),
(0,21,'p43#rc_51#############'),
(0,21,'p44#rc_51#############'),
(0,22,'p0#560-14-7807#20############'),
(0,22,'p1#330-12-6907#31#rc_10###########'),
(0,22,'p10#769-60-1266#15#nw_20###########'),
(0,22,'p11#369-22-9505#22#pn_16###########'),
(0,22,'p12#680-92-5329#24#rc_10###########'),
(0,22,'p13#513-40-4168#24#pn_16###########'),
(0,22,'p14#454-71-7847#13#pn_16###########'),
(0,22,'p15#153-47-8101#30#nw_20###########'),
(0,22,'p16#598-47-5172#28#rc_51###########'),
(0,22,'p17#865-71-6800#36#rc_51###########'),
(0,22,'p18#250-86-2784#23#rc_51###########'),
(0,22,'p19#386-39-7881#2#hg_99###########'),
(0,22,'p2#842-88-1257#9#rc_10###########'),
(0,22,'p20#522-44-3098#28#hg_99###########'),
(0,22,'p3#750-24-7616#11#cn_38###########'),
(0,22,'p4#776-21-8098#24#cn_38###########'),
(0,22,'p5#933-93-2165#27#dy_61###########'),
(0,22,'p6#707-84-4555#38#dy_61###########'),
(0,22,'p7#450-25-5617#13#nw_20###########'),
(0,22,'p8#701-38-2179#12#hg_99###########'),
(0,22,'p9#936-44-6941#13#nw_20###########'),
(0,23,'p0#ocean_liner#############'),
(0,23,'p1#ocean_liner#############'),
(0,23,'p10#ocean_liner#############'),
(0,23,'p11#ocean_liner#############'),
(0,23,'p11#river#############'),
(0,23,'p12#river#############'),
(0,23,'p13#river#############'),
(0,23,'p14#ocean_liner#############'),
(0,23,'p14#river#############'),
(0,23,'p15#ocean_liner#############'),
(0,23,'p15#river#############'),
(0,23,'p16#ocean_liner#############'),
(0,23,'p17#ocean_liner#############'),
(0,23,'p17#river#############'),
(0,23,'p18#ocean_liner#############'),
(0,23,'p19#ocean_liner#############'),
(0,23,'p2#ocean_liner#############'),
(0,23,'p2#river#############'),
(0,23,'p20#ocean_liner#############'),
(0,23,'p3#ocean_liner#############'),
(0,23,'p4#ocean_liner#############'),
(0,23,'p4#river#############'),
(0,23,'p5#ocean_liner#############'),
(0,23,'p6#ocean_liner#############'),
(0,23,'p6#river#############'),
(0,23,'p7#ocean_liner#############'),
(0,23,'p8#ocean_liner#############'),
(20,12,'aida#aidanova#6600#21.5#ship_4#ocean_liner##35#######'),
(20,12,'azamara#azamaraquest#686#18.5#ship_18#river#1########'),
(20,12,'carnival#carnivalvista#3934#23#ship_23#ocean_liner##2#######'),
(20,12,'carnival#firenze#4126#18#ship_41#ocean_liner##20#######'),
(20,12,'celebrity#celebrityedge#2908#22#ship_6#ocean_liner##20#######'),
(20,12,'celestyalcruises#celestyalcrystal#1200#18.5#ship_16#river#0########'),
(20,12,'costa#costasmeralda#6554#23#ship_2##########'),
(20,12,'cunard#queenmary2#2691#30#ship_14#ocean_liner##40#######'),
(20,12,'disney#disneydream#4000#23.5#ship_7#ocean_liner##20#######'),
(20,12,'hollandamerica#msnieuwstatendam#2666#23#ship_8#ocean_liner##30#######'),
(20,12,'hurtigruten#msroaldamundsen#530#15.5#ship_21#ocean_liner##10#######'),
(20,12,'marellacruises#marellaexplorer#1924#21.5#ship_27#ocean_liner##2#######'),
(20,12,'msc#meraviglia#4488#22.700000762939453#ship_22#ocean_liner##20#######'),
(20,12,'norwegian#norwegianbliss#4004#22.5#ship_24#ocean_liner##15#######'),
(20,12,'oceania#marina#1250#20#ship_11#ocean_liner##25#######'),
(20,12,'p&ocruises#iona#5200#22.600000381469727#ship_3#ocean_liner##20#######'),
(20,12,'paulgauguincruises#paulgauguin#332#18#ship_15##########'),
(20,12,'ponant#lelyrial#264#16#ship_26#river#1########'),
(20,12,'princess#crownprincess#3080#23#ship_5#ocean_liner##20#######'),
(20,12,'regent#sevenseasexplorer#750#19.5#ship_10#ocean_liner##20#######'),
(20,12,'royalcaribbean#oasisoftheseas#1325#18#ship_25#ocean_liner##30#######'),
(20,12,'royalcaribbean#symphonyoftheseas#6680#22#ship_1#ocean_liner##20#######'),
(20,12,'sagacruises#spiritofdiscovery#999#21#ship_17#ocean_liner##2#######'),
(20,12,'seabourn#seabournovation#604#19#ship_12#ocean_liner##20#######'),
(20,12,'silversea#silvermuse#596#19.799999237060547#ship_13#ocean_liner##30#######'),
(20,12,'starclippers#royalclipper#227#17#ship_19#river#1########'),
(20,12,'vikingocean#vikingorion#930#20#ship_9#ocean_liner##20#######'),
(20,12,'windstar#windsurf#342#15#ship_20#river#0########'),
(40,13,'bca#portofbarcelona#barcelona#catalonia#esp#port_6#########'),
(40,13,'bri#portofbridgetown#bridgetown#saintmichael#brb#port_19#########'),
(40,13,'cnl#portcanaveral#capecanaveral#florida#usa#port_4#########'),
(40,13,'cop#portofcopenhagen#copenhagen#hovedstaden#den#port_18#########'),
(40,13,'cva#portofcivitavecchia#civitavecchia#lazio#ita#port_7#########'),
(40,13,'czl#portofcozumel#cozumel#quintanaroo#mex#port_3#########'),
(40,13,'egs#porteverglades#fortlauderdale#florida#usa#port_2#########'),
(40,13,'gvn#portofgalveston#galveston#texas#usa#port_10#########'),
(40,13,'las#portoflosangeles#losangeles#california#usa#port_23#########'),
(40,13,'mar#portofmarseille#marseille#provence-alpes-côted\'azur#fra#port_17#########'),
(40,13,'mia#portofmiami#miami#florida#usa#port_1#########'),
(40,13,'nos#portofneworleans#neworleans#louisiana#usa#port_13#########'),
(40,13,'nsu#portofnassau#nassau#newprovidence#bhs#port_5#########'),
(40,13,'pdm#portofthebalearicislands#palma#majorca#esp#port_33#########'),
(40,13,'pir#portofpiraeus#piraeus#attica#grc#port_20#########'),
(40,13,'sea#portofseattle#seattle#washington#usa#port_11#########'),
(40,13,'sha#portofsouthampton#southhampton#hampshire#gbr#port_8#########'),
(40,13,'sjn#portofsanjuan#sanjuan#puertorico#usa#port_12#########'),
(40,13,'stm#portofstockholm#stockholm#stockholmcounty#swe#port_22#########'),
(40,13,'sts#portofst.thomas#charlotteamalie#st.thomas#usv#port_21#########'),
(40,13,'syd#portofsydney#sydney#newsouthwales#aus#port_9#########'),
(40,13,'tmp#portoftampabay#tampabay#florida#usa#port_15#########'),
(40,13,'van#portofvancouver#vancouver#britishcolumbia#can#port_16#########'),
(40,13,'ven#portofvenice#venice#veneto#ita#port_14#########'),
(60,14,'p0#martin#vanbasten############'),
(60,14,'p1#jeanne#nelson############'),
(60,14,'p10#lawrence#morgan############'),
(60,14,'p11#sandra#cruz############'),
(60,14,'p12#dan#ball############'),
(60,14,'p13#bryant#figueroa############'),
(60,14,'p14#dana#perry############'),
(60,14,'p15#matt#hunt############'),
(60,14,'p16#edna#brown############'),
(60,14,'p17#ruby#burgess############'),
(60,14,'p18#esther#pittman############'),
(60,14,'p19#doug#fowler############'),
(60,14,'p2#roxanne#byrd############'),
(60,14,'p20#thomas#olson############'),
(60,14,'p21#mona#harrison############'),
(60,14,'p22#arlene#massey############'),
(60,14,'p23#judith#patrick############'),
(60,14,'p24#reginald#rhodes############'),
(60,14,'p25#vincent#garcia############'),
(60,14,'p26#cheryl#moore############'),
(60,14,'p27#michael#rivera############'),
(60,14,'p28#luther#matthews############'),
(60,14,'p29#moses#parks############'),
(60,14,'p3#tanya#nguyen############'),
(60,14,'p30#ora#steele############'),
(60,14,'p31#antonio#flores############'),
(60,14,'p32#glenn#ross############'),
(60,14,'p33#irma#thomas############'),
(60,14,'p34#ann#maldonado############'),
(60,14,'p35#jeffrey#cruz############'),
(60,14,'p36#sonya#price############'),
(60,14,'p37#tracy#hale############'),
(60,14,'p38#albert#simmons############'),
(60,14,'p39#karen#terry############'),
(60,14,'p4#kendra#jacobs############'),
(60,14,'p40#glen#kelley############'),
(60,14,'p41#brooke#little############'),
(60,14,'p42#daryl#nguyen############'),
(60,14,'p43#judy#willis############'),
(60,14,'p44#marco#klein############'),
(60,14,'p45#angelica#hampton############'),
(60,14,'p46#peppermint#patty############'),
(60,14,'p47#charlie#brown############'),
(60,14,'p48#lucy#vanpelt############'),
(60,14,'p49#linus#vanpelt############'),
(60,14,'p5#jeff#burton############'),
(60,14,'p6#randal#parks############'),
(60,14,'p61#sabrina#duncan############'),
(60,14,'p7#sonya#owens############'),
(60,14,'p8#bennie#palmer############'),
(60,14,'p9#marlene#warner############'),
(60,16,'p0#port_1#############'),
(60,16,'p29#port_1#############'),
(60,16,'p30#port_1#############'),
(60,16,'p31#port_1#############'),
(60,16,'p32#port_1#############'),
(60,16,'p5#port_1#############'),
(60,16,'p6#port_1#############'),
(60,16,'p61#port_1#############'),
(60,16,'p16#port_14#############'),
(60,16,'p17#port_14#############'),
(60,16,'p18#port_14#############'),
(60,16,'p41#port_14#############'),
(60,16,'p42#port_14#############'),
(60,16,'p43#port_14#############'),
(60,16,'p44#port_14#############'),
(60,16,'p19#port_7#############'),
(60,16,'p20#port_7#############'),
(60,16,'p45#port_7#############'),
(60,16,'p46#port_7#############'),
(60,16,'p47#port_7#############'),
(60,16,'p48#port_7#############'),
(60,16,'p8#port_7#############'),
(60,16,'p1#ship_1#############'),
(60,16,'p12#ship_1#############'),
(60,16,'p2#ship_1#############'),
(60,16,'p21#ship_1#############'),
(60,16,'p22#ship_1#############'),
(60,16,'p23#ship_1#############'),
(60,16,'p24#ship_1#############'),
(60,16,'p19#ship_21#############'),
(60,16,'p20#ship_21#############'),
(60,16,'p8#ship_21#############'),
(60,16,'p25#ship_23#############'),
(60,16,'p26#ship_23#############'),
(60,16,'p27#ship_23#############'),
(60,16,'p28#ship_23#############'),
(60,16,'p3#ship_23#############'),
(60,16,'p4#ship_23#############'),
(60,16,'p10#ship_24#############'),
(60,16,'p15#ship_24#############'),
(60,16,'p33#ship_24#############'),
(60,16,'p34#ship_24#############'),
(60,16,'p35#ship_24#############'),
(60,16,'p36#ship_24#############'),
(60,16,'p7#ship_24#############'),
(60,16,'p9#ship_24#############'),
(60,16,'p16#ship_25#############'),
(60,16,'p17#ship_25#############'),
(60,16,'p18#ship_25#############'),
(60,16,'p41#ship_25#############'),
(60,16,'p42#ship_25#############'),
(60,16,'p43#ship_25#############'),
(60,16,'p44#ship_25#############'),
(60,16,'p11#ship_26#############'),
(60,16,'p13#ship_26#############'),
(60,16,'p14#ship_26#############'),
(60,16,'p37#ship_26#############'),
(60,16,'p38#ship_26#############'),
(60,16,'p39#ship_26#############'),
(60,16,'p40#ship_26#############'),
(60,16,'p29#ship_7#############'),
(60,16,'p6#ship_7#############'),
(60,22,'p0#560-14-7807#20############'),
(60,22,'p1#330-12-6907#31#rc_10###########'),
(60,22,'p10#769-60-1266#15#nw_20###########'),
(60,22,'p11#369-22-9505#22#pn_16###########'),
(60,22,'p12#680-92-5329#24#rc_10###########'),
(60,22,'p13#513-40-4168#24#pn_16###########'),
(60,22,'p14#454-71-7847#13#pn_16###########'),
(60,22,'p15#153-47-8101#30#nw_20###########'),
(60,22,'p16#598-47-5172#28#rc_51###########'),
(60,22,'p17#865-71-6800#36#rc_51###########'),
(60,22,'p18#250-86-2784#23#rc_51###########'),
(60,22,'p19#386-39-7881#2#hg_99###########'),
(60,22,'p2#842-88-1257#9#rc_10###########'),
(60,22,'p20#522-44-3098#28#hg_99###########'),
(60,22,'p3#750-24-7616#11#cn_38###########'),
(60,22,'p4#776-21-8098#24#cn_38###########'),
(60,22,'p5#933-93-2165#27#dy_61###########'),
(60,22,'p6#707-84-4555#38#dy_61###########'),
(60,22,'p61#366-50-3732#27############'),
(60,22,'p7#450-25-5617#13#nw_20###########'),
(60,22,'p8#701-38-2179#12#hg_99###########'),
(60,22,'p9#936-44-6941#13#nw_20###########'),
(60,15,'p21#771#700############'),
(60,15,'p22#374#200############'),
(60,15,'p23#414#400############'),
(60,15,'p24#292#500############'),
(60,15,'p25#390#300############'),
(60,15,'p26#302#600############'),
(60,15,'p27#470#400############'),
(60,15,'p28#208#400############'),
(60,15,'p29#292#700############'),
(60,15,'p30#686#500############'),
(60,15,'p31#547#400############'),
(60,15,'p32#257#500############'),
(60,15,'p33#564#600############'),
(60,15,'p34#211#200############'),
(60,15,'p35#233#500############'),
(60,15,'p36#293#400############'),
(60,15,'p37#552#700############'),
(60,15,'p38#812#700############'),
(60,15,'p39#541#400############'),
(60,15,'p40#441#700############'),
(60,15,'p41#875#300############'),
(60,15,'p42#691#500############'),
(60,15,'p43#572#300############'),
(60,15,'p44#572#500############'),
(60,15,'p45#663#500############'),
(60,15,'p46#1002#300############'),
(60,15,'p47#4000#800############'),
(60,15,'p48#244#650############'),
(80,23,'p0#ocean_liner#############'),
(80,23,'p1#ocean_liner#############'),
(80,23,'p1#river#############'),
(80,23,'p10#ocean_liner#############'),
(80,23,'p11#ocean_liner#############'),
(80,23,'p11#river#############'),
(80,23,'p12#river#############'),
(80,23,'p13#river#############'),
(80,23,'p14#ocean_liner#############'),
(80,23,'p14#river#############'),
(80,23,'p15#ocean_liner#############'),
(80,23,'p15#river#############'),
(80,23,'p16#ocean_liner#############'),
(80,23,'p17#ocean_liner#############'),
(80,23,'p17#river#############'),
(80,23,'p18#ocean_liner#############'),
(80,23,'p19#ocean_liner#############'),
(80,23,'p2#ocean_liner#############'),
(80,23,'p2#river#############'),
(80,23,'p20#ocean_liner#############'),
(80,23,'p3#ocean_liner#############'),
(80,23,'p4#ocean_liner#############'),
(80,23,'p4#river#############'),
(80,23,'p5#ocean_liner#############'),
(80,23,'p6#ocean_liner#############'),
(80,23,'p6#river#############'),
(80,23,'p7#ocean_liner#############'),
(80,23,'p8#ocean_liner#############'),
(100,20,'ca_41#americas_three#costa#costasmeralda#0#docked#11:30:00#400#######'),
(100,20,'cn_38#americas_three#carnival#carnivalvista#2#sailing#14:30:00#200#######'),
(100,20,'dy_61#americas_two#disney#disneydream#0#docked#09:30:00#200#######'),
(100,20,'hg_99#euro_south#hurtigruten#msroaldamundsen#2#docked#12:30:00#150#######'),
(100,20,'mc_47#euro_south#cunard#queenmary2#2#docked#14:30:00#150#######'),
(100,20,'nw_20#euro_north#norwegian#norwegianbliss#2#sailing#11:00:00#300#######'),
(100,20,'pn_16#euro_south#ponant#lelyrial#1#sailing#14:00:00#400#######'),
(100,20,'rc_10#americas_one#royalcaribbean#symphonyoftheseas#1#sailing#08:00:00#200#######'),
(100,20,'rc_51#big_mediterranean_loop#royalcaribbean#oasisoftheseas#3#docked#11:30:00#100#######'),
(120,22,'p0#560-14-7807#20############'),
(120,22,'p1#330-12-6907#31#rc_10###########'),
(120,22,'p10#769-60-1266#15#nw_20###########'),
(120,22,'p11#369-22-9505#22#pn_16###########'),
(120,22,'p12#680-92-5329#24#rc_10###########'),
(120,22,'p13#513-40-4168#24#pn_16###########'),
(120,22,'p14#454-71-7847#13#pn_16###########'),
(120,22,'p15#153-47-8101#30#nw_20###########'),
(120,22,'p16#598-47-5172#28#rc_51###########'),
(120,22,'p17#865-71-6800#36#rc_51###########'),
(120,22,'p18#250-86-2784#23#rc_51###########'),
(120,22,'p19#386-39-7881#2#hg_99###########'),
(120,22,'p2#842-88-1257#9#rc_10###########'),
(120,22,'p20#522-44-3098#28#hg_99###########'),
(120,22,'p3#750-24-7616#12#cn_38###########'),
(120,22,'p4#776-21-8098#25#cn_38###########'),
(120,22,'p5#933-93-2165#27#dy_61###########'),
(120,22,'p6#707-84-4555#38#dy_61###########'),
(120,22,'p7#450-25-5617#13#nw_20###########'),
(120,22,'p8#701-38-2179#12#hg_99###########'),
(120,22,'p9#936-44-6941#13#nw_20###########'),
(120,15,'p21#771#700############'),
(120,15,'p22#374#200############'),
(120,15,'p23#414#400############'),
(120,15,'p24#292#500############'),
(120,15,'p25#516#300############'),
(120,15,'p26#428#600############'),
(120,15,'p27#596#400############'),
(120,15,'p28#334#400############'),
(120,15,'p29#292#700############'),
(120,15,'p30#686#500############'),
(120,15,'p31#547#400############'),
(120,15,'p32#257#500############'),
(120,15,'p33#564#600############'),
(120,15,'p34#211#200############'),
(120,15,'p35#233#500############'),
(120,15,'p36#293#400############'),
(120,15,'p37#552#700############'),
(120,15,'p38#812#700############'),
(120,15,'p39#541#400############'),
(120,15,'p40#441#700############'),
(120,15,'p41#875#300############'),
(120,15,'p42#691#500############'),
(120,15,'p43#572#300############'),
(120,15,'p44#572#500############'),
(120,15,'p45#663#500############'),
(120,15,'p46#1002#300############'),
(120,15,'p47#4000#800############'),
(120,15,'p48#244#650############'),
(120,20,'cn_38#americas_three#carnival#carnivalvista#2#docked#22:30:00#200#######'),
(120,20,'dy_61#americas_two#disney#disneydream#0#docked#09:30:00#200#######'),
(120,20,'hg_99#euro_south#hurtigruten#msroaldamundsen#2#docked#12:30:00#150#######'),
(120,20,'mc_47#euro_south#cunard#queenmary2#2#docked#14:30:00#150#######'),
(120,20,'nw_20#euro_north#norwegian#norwegianbliss#2#sailing#11:00:00#300#######'),
(120,20,'pn_16#euro_south#ponant#lelyrial#1#sailing#14:00:00#400#######'),
(120,20,'rc_10#americas_one#royalcaribbean#symphonyoftheseas#1#sailing#08:00:00#200#######'),
(120,20,'rc_51#big_mediterranean_loop#royalcaribbean#oasisoftheseas#3#docked#11:30:00#100#######'),
(120,16,'p0#port_1#############'),
(120,16,'p29#port_1#############'),
(120,16,'p30#port_1#############'),
(120,16,'p31#port_1#############'),
(120,16,'p32#port_1#############'),
(120,16,'p5#port_1#############'),
(120,16,'p6#port_1#############'),
(120,16,'p16#port_14#############'),
(120,16,'p17#port_14#############'),
(120,16,'p18#port_14#############'),
(120,16,'p41#port_14#############'),
(120,16,'p42#port_14#############'),
(120,16,'p43#port_14#############'),
(120,16,'p44#port_14#############'),
(120,16,'p25#port_16#############'),
(120,16,'p26#port_16#############'),
(120,16,'p27#port_16#############'),
(120,16,'p28#port_16#############'),
(120,16,'p3#port_16#############'),
(120,16,'p4#port_16#############'),
(120,16,'p19#port_7#############'),
(120,16,'p20#port_7#############'),
(120,16,'p45#port_7#############'),
(120,16,'p46#port_7#############'),
(120,16,'p47#port_7#############'),
(120,16,'p48#port_7#############'),
(120,16,'p8#port_7#############'),
(120,16,'p1#ship_1#############'),
(120,16,'p12#ship_1#############'),
(120,16,'p2#ship_1#############'),
(120,16,'p21#ship_1#############'),
(120,16,'p22#ship_1#############'),
(120,16,'p23#ship_1#############'),
(120,16,'p24#ship_1#############'),
(120,16,'p19#ship_21#############'),
(120,16,'p20#ship_21#############'),
(120,16,'p8#ship_21#############'),
(120,16,'p25#ship_23#############'),
(120,16,'p26#ship_23#############'),
(120,16,'p27#ship_23#############'),
(120,16,'p28#ship_23#############'),
(120,16,'p3#ship_23#############'),
(120,16,'p4#ship_23#############'),
(120,16,'p10#ship_24#############'),
(120,16,'p15#ship_24#############'),
(120,16,'p33#ship_24#############'),
(120,16,'p34#ship_24#############'),
(120,16,'p35#ship_24#############'),
(120,16,'p36#ship_24#############'),
(120,16,'p7#ship_24#############'),
(120,16,'p9#ship_24#############'),
(120,16,'p16#ship_25#############'),
(120,16,'p17#ship_25#############'),
(120,16,'p18#ship_25#############'),
(120,16,'p41#ship_25#############'),
(120,16,'p42#ship_25#############'),
(120,16,'p43#ship_25#############'),
(120,16,'p44#ship_25#############'),
(120,16,'p11#ship_26#############'),
(120,16,'p13#ship_26#############'),
(120,16,'p14#ship_26#############'),
(120,16,'p37#ship_26#############'),
(120,16,'p38#ship_26#############'),
(120,16,'p39#ship_26#############'),
(120,16,'p40#ship_26#############'),
(120,16,'p29#ship_7#############'),
(120,16,'p6#ship_7#############'),
(140,20,'cn_38#americas_three#carnival#carnivalvista#2#sailing#14:30:00#200#######'),
(140,20,'dy_61#americas_two#disney#disneydream#0#docked#10:00:00#200#######'),
(140,20,'hg_99#euro_south#hurtigruten#msroaldamundsen#2#docked#12:30:00#150#######'),
(140,20,'mc_47#euro_south#cunard#queenmary2#2#docked#14:30:00#150#######'),
(140,20,'nw_20#euro_north#norwegian#norwegianbliss#2#sailing#11:00:00#300#######'),
(140,20,'pn_16#euro_south#ponant#lelyrial#1#sailing#14:00:00#400#######'),
(140,20,'rc_10#americas_one#royalcaribbean#symphonyoftheseas#1#sailing#08:00:00#200#######'),
(140,20,'rc_51#big_mediterranean_loop#royalcaribbean#oasisoftheseas#3#docked#11:30:00#100#######'),
(140,16,'p0#port_1#############'),
(140,16,'p29#port_1#############'),
(140,16,'p30#port_1#############'),
(140,16,'p31#port_1#############'),
(140,16,'p32#port_1#############'),
(140,16,'p5#port_1#############'),
(140,16,'p6#port_1#############'),
(140,16,'p16#port_14#############'),
(140,16,'p17#port_14#############'),
(140,16,'p18#port_14#############'),
(140,16,'p41#port_14#############'),
(140,16,'p42#port_14#############'),
(140,16,'p43#port_14#############'),
(140,16,'p44#port_14#############'),
(140,16,'p19#port_7#############'),
(140,16,'p20#port_7#############'),
(140,16,'p45#port_7#############'),
(140,16,'p46#port_7#############'),
(140,16,'p47#port_7#############'),
(140,16,'p48#port_7#############'),
(140,16,'p8#port_7#############'),
(140,16,'p1#ship_1#############'),
(140,16,'p12#ship_1#############'),
(140,16,'p2#ship_1#############'),
(140,16,'p21#ship_1#############'),
(140,16,'p22#ship_1#############'),
(140,16,'p23#ship_1#############'),
(140,16,'p24#ship_1#############'),
(140,16,'p19#ship_21#############'),
(140,16,'p20#ship_21#############'),
(140,16,'p8#ship_21#############'),
(140,16,'p25#ship_23#############'),
(140,16,'p26#ship_23#############'),
(140,16,'p27#ship_23#############'),
(140,16,'p28#ship_23#############'),
(140,16,'p3#ship_23#############'),
(140,16,'p4#ship_23#############'),
(140,16,'p10#ship_24#############'),
(140,16,'p15#ship_24#############'),
(140,16,'p33#ship_24#############'),
(140,16,'p34#ship_24#############'),
(140,16,'p35#ship_24#############'),
(140,16,'p36#ship_24#############'),
(140,16,'p7#ship_24#############'),
(140,16,'p9#ship_24#############'),
(140,16,'p16#ship_25#############'),
(140,16,'p17#ship_25#############'),
(140,16,'p18#ship_25#############'),
(140,16,'p41#ship_25#############'),
(140,16,'p42#ship_25#############'),
(140,16,'p43#ship_25#############'),
(140,16,'p44#ship_25#############'),
(140,16,'p11#ship_26#############'),
(140,16,'p13#ship_26#############'),
(140,16,'p14#ship_26#############'),
(140,16,'p37#ship_26#############'),
(140,16,'p38#ship_26#############'),
(140,16,'p39#ship_26#############'),
(140,16,'p40#ship_26#############'),
(140,16,'p29#ship_7#############'),
(140,16,'p6#ship_7#############'),
(160,16,'p0#port_1#############'),
(160,16,'p29#port_1#############'),
(160,16,'p30#port_1#############'),
(160,16,'p31#port_1#############'),
(160,16,'p32#port_1#############'),
(160,16,'p5#port_1#############'),
(160,16,'p6#port_1#############'),
(160,16,'p16#port_14#############'),
(160,16,'p17#port_14#############'),
(160,16,'p18#port_14#############'),
(160,16,'p41#port_14#############'),
(160,16,'p42#port_14#############'),
(160,16,'p43#port_14#############'),
(160,16,'p44#port_14#############'),
(160,16,'p19#port_7#############'),
(160,16,'p20#port_7#############'),
(160,16,'p45#port_7#############'),
(160,16,'p46#port_7#############'),
(160,16,'p47#port_7#############'),
(160,16,'p48#port_7#############'),
(160,16,'p8#port_7#############'),
(160,16,'p1#ship_1#############'),
(160,16,'p12#ship_1#############'),
(160,16,'p2#ship_1#############'),
(160,16,'p21#ship_1#############'),
(160,16,'p22#ship_1#############'),
(160,16,'p23#ship_1#############'),
(160,16,'p24#ship_1#############'),
(160,16,'p19#ship_21#############'),
(160,16,'p20#ship_21#############'),
(160,16,'p8#ship_21#############'),
(160,16,'p25#ship_23#############'),
(160,16,'p26#ship_23#############'),
(160,16,'p27#ship_23#############'),
(160,16,'p28#ship_23#############'),
(160,16,'p3#ship_23#############'),
(160,16,'p4#ship_23#############'),
(160,16,'p10#ship_24#############'),
(160,16,'p15#ship_24#############'),
(160,16,'p33#ship_24#############'),
(160,16,'p34#ship_24#############'),
(160,16,'p35#ship_24#############'),
(160,16,'p36#ship_24#############'),
(160,16,'p7#ship_24#############'),
(160,16,'p9#ship_24#############'),
(160,16,'p16#ship_25#############'),
(160,16,'p17#ship_25#############'),
(160,16,'p18#ship_25#############'),
(160,16,'p41#ship_25#############'),
(160,16,'p42#ship_25#############'),
(160,16,'p43#ship_25#############'),
(160,16,'p44#ship_25#############'),
(160,16,'p11#ship_26#############'),
(160,16,'p13#ship_26#############'),
(160,16,'p14#ship_26#############'),
(160,16,'p37#ship_26#############'),
(160,16,'p38#ship_26#############'),
(160,16,'p39#ship_26#############'),
(160,16,'p40#ship_26#############'),
(160,16,'p29#ship_7#############'),
(160,16,'p5#ship_7#############'),
(160,16,'p6#ship_7#############'),
(180,16,'p0#port_1#############'),
(180,16,'p29#port_1#############'),
(180,16,'p30#port_1#############'),
(180,16,'p31#port_1#############'),
(180,16,'p32#port_1#############'),
(180,16,'p5#port_1#############'),
(180,16,'p6#port_1#############'),
(180,16,'p16#port_14#############'),
(180,16,'p17#port_14#############'),
(180,16,'p18#port_14#############'),
(180,16,'p41#port_14#############'),
(180,16,'p42#port_14#############'),
(180,16,'p43#port_14#############'),
(180,16,'p44#port_14#############'),
(180,16,'p19#port_7#############'),
(180,16,'p20#port_7#############'),
(180,16,'p45#port_7#############'),
(180,16,'p46#port_7#############'),
(180,16,'p47#port_7#############'),
(180,16,'p48#port_7#############'),
(180,16,'p8#port_7#############'),
(180,16,'p1#ship_1#############'),
(180,16,'p12#ship_1#############'),
(180,16,'p2#ship_1#############'),
(180,16,'p21#ship_1#############'),
(180,16,'p22#ship_1#############'),
(180,16,'p23#ship_1#############'),
(180,16,'p24#ship_1#############'),
(180,16,'p19#ship_21#############'),
(180,16,'p20#ship_21#############'),
(180,16,'p8#ship_21#############'),
(180,16,'p25#ship_23#############'),
(180,16,'p26#ship_23#############'),
(180,16,'p27#ship_23#############'),
(180,16,'p28#ship_23#############'),
(180,16,'p3#ship_23#############'),
(180,16,'p4#ship_23#############'),
(180,16,'p10#ship_24#############'),
(180,16,'p15#ship_24#############'),
(180,16,'p33#ship_24#############'),
(180,16,'p34#ship_24#############'),
(180,16,'p35#ship_24#############'),
(180,16,'p36#ship_24#############'),
(180,16,'p7#ship_24#############'),
(180,16,'p9#ship_24#############'),
(180,16,'p16#ship_25#############'),
(180,16,'p17#ship_25#############'),
(180,16,'p18#ship_25#############'),
(180,16,'p42#ship_25#############'),
(180,16,'p43#ship_25#############'),
(180,16,'p44#ship_25#############'),
(180,16,'p11#ship_26#############'),
(180,16,'p13#ship_26#############'),
(180,16,'p14#ship_26#############'),
(180,16,'p37#ship_26#############'),
(180,16,'p38#ship_26#############'),
(180,16,'p39#ship_26#############'),
(180,16,'p40#ship_26#############'),
(180,16,'p29#ship_7#############'),
(180,16,'p6#ship_7#############'),
(200,14,'p0#martin#vanbasten############'),
(200,14,'p1#jeanne#nelson############'),
(200,14,'p10#lawrence#morgan############'),
(200,14,'p11#sandra#cruz############'),
(200,14,'p12#dan#ball############'),
(200,14,'p13#bryant#figueroa############'),
(200,14,'p14#dana#perry############'),
(200,14,'p15#matt#hunt############'),
(200,14,'p16#edna#brown############'),
(200,14,'p17#ruby#burgess############'),
(200,14,'p18#esther#pittman############'),
(200,14,'p19#doug#fowler############'),
(200,14,'p2#roxanne#byrd############'),
(200,14,'p20#thomas#olson############'),
(200,14,'p21#mona#harrison############'),
(200,14,'p22#arlene#massey############'),
(200,14,'p23#judith#patrick############'),
(200,14,'p24#reginald#rhodes############'),
(200,14,'p25#vincent#garcia############'),
(200,14,'p26#cheryl#moore############'),
(200,14,'p27#michael#rivera############'),
(200,14,'p28#luther#matthews############'),
(200,14,'p29#moses#parks############'),
(200,14,'p3#tanya#nguyen############'),
(200,14,'p30#ora#steele############'),
(200,14,'p31#antonio#flores############'),
(200,14,'p32#glenn#ross############'),
(200,14,'p33#irma#thomas############'),
(200,14,'p34#ann#maldonado############'),
(200,14,'p35#jeffrey#cruz############'),
(200,14,'p36#sonya#price############'),
(200,14,'p37#tracy#hale############'),
(200,14,'p38#albert#simmons############'),
(200,14,'p39#karen#terry############'),
(200,14,'p4#kendra#jacobs############'),
(200,14,'p40#glen#kelley############'),
(200,14,'p41#brooke#little############'),
(200,14,'p42#daryl#nguyen############'),
(200,14,'p43#judy#willis############'),
(200,14,'p44#marco#klein############'),
(200,14,'p45#angelica#hampton############'),
(200,14,'p46#peppermint#patty############'),
(200,14,'p47#charlie#brown############'),
(200,14,'p48#lucy#vanpelt############'),
(200,14,'p49#linus#vanpelt############'),
(200,14,'p5#jeff#burton############'),
(200,14,'p6#randal#parks############'),
(200,14,'p7#sonya#owens############'),
(200,14,'p8#bennie#palmer############'),
(200,14,'p9#marlene#warner############'),
(200,22,'p0#560-14-7807#20#dy_61###########'),
(200,22,'p1#330-12-6907#31#rc_10###########'),
(200,22,'p10#769-60-1266#15#nw_20###########'),
(200,22,'p11#369-22-9505#22#pn_16###########'),
(200,22,'p12#680-92-5329#24#rc_10###########'),
(200,22,'p13#513-40-4168#24#pn_16###########'),
(200,22,'p14#454-71-7847#13#pn_16###########'),
(200,22,'p15#153-47-8101#30#nw_20###########'),
(200,22,'p16#598-47-5172#28#rc_51###########'),
(200,22,'p17#865-71-6800#36#rc_51###########'),
(200,22,'p18#250-86-2784#23#rc_51###########'),
(200,22,'p19#386-39-7881#2#hg_99###########'),
(200,22,'p2#842-88-1257#9#rc_10###########'),
(200,22,'p20#522-44-3098#28#hg_99###########'),
(200,22,'p3#750-24-7616#11#cn_38###########'),
(200,22,'p4#776-21-8098#24#cn_38###########'),
(200,22,'p5#933-93-2165#27#dy_61###########'),
(200,22,'p6#707-84-4555#38#dy_61###########'),
(200,22,'p7#450-25-5617#13#nw_20###########'),
(200,22,'p8#701-38-2179#12#hg_99###########'),
(200,22,'p9#936-44-6941#13#nw_20###########'),
(220,14,'p0#martin#vanbasten############'),
(220,14,'p1#jeanne#nelson############'),
(220,14,'p10#lawrence#morgan############'),
(220,14,'p11#sandra#cruz############'),
(220,14,'p12#dan#ball############'),
(220,14,'p13#bryant#figueroa############'),
(220,14,'p14#dana#perry############'),
(220,14,'p15#matt#hunt############'),
(220,14,'p16#edna#brown############'),
(220,14,'p17#ruby#burgess############'),
(220,14,'p18#esther#pittman############'),
(220,14,'p19#doug#fowler############'),
(220,14,'p2#roxanne#byrd############'),
(220,14,'p20#thomas#olson############'),
(220,14,'p21#mona#harrison############'),
(220,14,'p22#arlene#massey############'),
(220,14,'p23#judith#patrick############'),
(220,14,'p24#reginald#rhodes############'),
(220,14,'p25#vincent#garcia############'),
(220,14,'p26#cheryl#moore############'),
(220,14,'p27#michael#rivera############'),
(220,14,'p28#luther#matthews############'),
(220,14,'p29#moses#parks############'),
(220,14,'p3#tanya#nguyen############'),
(220,14,'p30#ora#steele############'),
(220,14,'p31#antonio#flores############'),
(220,14,'p32#glenn#ross############'),
(220,14,'p33#irma#thomas############'),
(220,14,'p34#ann#maldonado############'),
(220,14,'p35#jeffrey#cruz############'),
(220,14,'p36#sonya#price############'),
(220,14,'p37#tracy#hale############'),
(220,14,'p38#albert#simmons############'),
(220,14,'p39#karen#terry############'),
(220,14,'p4#kendra#jacobs############'),
(220,14,'p40#glen#kelley############'),
(220,14,'p41#brooke#little############'),
(220,14,'p42#daryl#nguyen############'),
(220,14,'p43#judy#willis############'),
(220,14,'p44#marco#klein############'),
(220,14,'p45#angelica#hampton############'),
(220,14,'p46#peppermint#patty############'),
(220,14,'p47#charlie#brown############'),
(220,14,'p48#lucy#vanpelt############'),
(220,14,'p49#linus#vanpelt############'),
(220,14,'p5#jeff#burton############'),
(220,14,'p6#randal#parks############'),
(220,14,'p7#sonya#owens############'),
(220,14,'p8#bennie#palmer############'),
(220,14,'p9#marlene#warner############'),
(220,22,'p0#560-14-7807#20############'),
(220,22,'p1#330-12-6907#31#rc_10###########'),
(220,22,'p10#769-60-1266#15#nw_20###########'),
(220,22,'p11#369-22-9505#22#pn_16###########'),
(220,22,'p12#680-92-5329#24#rc_10###########'),
(220,22,'p13#513-40-4168#24#pn_16###########'),
(220,22,'p14#454-71-7847#13#pn_16###########'),
(220,22,'p15#153-47-8101#30#nw_20###########'),
(220,22,'p16#598-47-5172#28#rc_51###########'),
(220,22,'p17#865-71-6800#36#rc_51###########'),
(220,22,'p18#250-86-2784#23#rc_51###########'),
(220,22,'p19#386-39-7881#2############'),
(220,22,'p2#842-88-1257#9#rc_10###########'),
(220,22,'p20#522-44-3098#28############'),
(220,22,'p3#750-24-7616#11#cn_38###########'),
(220,22,'p4#776-21-8098#24#cn_38###########'),
(220,22,'p5#933-93-2165#27#dy_61###########'),
(220,22,'p6#707-84-4555#38#dy_61###########'),
(220,22,'p7#450-25-5617#13#nw_20###########'),
(220,22,'p8#701-38-2179#12############'),
(220,22,'p9#936-44-6941#13#nw_20###########'),
(240,20,'cn_38#americas_three#carnival#carnivalvista#2#sailing#14:30:00#200#######'),
(240,20,'dy_61#americas_two#disney#disneydream#0#docked#09:30:00#200#######'),
(240,20,'hg_99#euro_south#hurtigruten#msroaldamundsen#2#docked#12:30:00#150#######'),
(240,20,'nw_20#euro_north#norwegian#norwegianbliss#2#sailing#11:00:00#300#######'),
(240,20,'pn_16#euro_south#ponant#lelyrial#1#sailing#14:00:00#400#######'),
(240,20,'rc_10#americas_one#royalcaribbean#symphonyoftheseas#1#sailing#08:00:00#200#######'),
(240,20,'rc_51#big_mediterranean_loop#royalcaribbean#oasisoftheseas#3#docked#11:30:00#100#######'),
(280,30,'bca#mar#1#pn_16#14:00:00#14:00:00#ship_26########'),
(280,30,'cop#sha#1#nw_20#11:00:00#11:00:00#ship_24########'),
(280,30,'mia#nsu#1#rc_10#08:00:00#08:00:00#ship_1########'),
(280,30,'sea#van#1#cn_38#14:30:00#14:30:00#ship_23########'),
(300,31,'mia#1#dy_61#09:30:00#09:30:00#ship_7#########'),
(300,31,'ven#1#rc_51#11:30:00#11:30:00#ship_25#########'),
(320,32,'bca#mar#1#ship_26#pn_16#14:00:00#14:00:00#3#4#7#p11,p13,p14,p37,p38,p39,p40####'),
(320,32,'cop#sha#1#ship_24#nw_20#11:00:00#11:00:00#4#4#8#p7,p9,p10,p15,p33,p34,p35,p36####'),
(320,32,'mia#nsu#1#ship_1#rc_10#08:00:00#08:00:00#3#4#7#p1,p2,p12,p21,p22,p23,p24####'),
(320,32,'sea#van#1#ship_23#cn_38#14:30:00#14:30:00#2#4#6#p3,p4,p25,p26,p27,p28####'),
(340,33,'mia#port_1#portofmiami#miami#florida#usa#2#4#6#p5,p6,p29,p30,p31,p32#####'),
(340,33,'ven#port_14#portofvenice#venice#veneto#ita#3#4#7#p16,p17,p18,p41,p42,p43,p44#####'),
(360,34,'americas_one#2#leg_2,leg_1#982#1#rc_10#mia->nsu,nsu->sjn########'),
(360,34,'americas_three#2#leg_31,leg_14#1265#1#cn_38#las->sea,sea->van########'),
(360,34,'americas_two#1#leg_4#29#1#dy_61#mia->egs########'),
(360,34,'big_mediterranean_loop#4#leg_47,leg_15,leg_27,leg_33#2293#1#rc_51#bca->mar,mar->cva,cva->ven,ven->pir########'),
(360,34,'euro_north#2#leg_64,leg_78#1230#1#nw_20#stm->cop,cop->sha########'),
(360,34,'euro_south#2#leg_47,leg_15#497#3#hg_99,mc_47,pn_16#bca->mar,mar->cva########'),
(380,35,'aus#1#syd#portofsydney###########'),
(380,35,'bhs#1#nsu#portofnassau###########'),
(380,35,'brb#1#bri#portofbridgetown###########'),
(380,35,'can#1#van#portofvancouver###########'),
(380,35,'den#1#cop#portofcopenhagen###########'),
(380,35,'esp#1#bca#portofbarcelona###########'),
(380,35,'fra#1#mar#portofmarseille###########'),
(380,35,'gbr#1#sha#portofsouthampton###########'),
(380,35,'grc#1#pir#portofpiraeus###########'),
(380,35,'ita#2#cva,ven#portofcivitavecchia,portofvenice###########'),
(380,35,'mex#1#czl#portofcozumel###########'),
(380,35,'swe#1#stm#portofstockholm###########'),
(380,35,'usa#9#cnl,egs,gvn,las,mia,nos,sea,sjn,tmp#portcanaveral,porteverglades,portofgalveston,portoflosangeles,portofmiami,portofneworleans,portofseattle,portofsanjuan,portoftampabay###########'),
(380,35,'usv#1#sts#portofst.thomas###########');

create or replace view magic44_test_case_frequencies as
select test_case_category, count(distinct step_id) as num_test_cases
from (select step_id, query_id, row_hash, 20 * truncate(step_id / 20, 0) as test_case_category
from magic44_expected_results where step_id < 600) as combine_tests
group by test_case_category
union
select test_case_category, count(distinct step_id) as num_test_cases
from (select step_id, query_id, row_hash, 50 * truncate(step_id / 50, 0) as test_case_category
from magic44_expected_results where step_id >= 600) as combine_tests
group by test_case_category;

-- ----------------------------------------------------------------------------------
-- [7] Compare & evaluate the testing results
-- ----------------------------------------------------------------------------------

-- Delete the unneeded rows from the answers table to simplify later analysis
-- delete from magic44_expected_results where not magic44_query_exists(query_id);

-- Modify the row hash results for the results table to eliminate spaces and convert all characters to lowercase
update magic44_test_results set row_hash = lower(replace(row_hash, ' ', ''));

-- The magic44_count_differences view displays the differences between the number of rows contained in the answers
-- and the test results.  The value null in the answer_total and result_total columns represents zero (0) rows for
-- that query result.

drop view if exists magic44_count_answers;
create view magic44_count_answers as
select step_id, query_id, count(*) as answer_total
from magic44_expected_results group by step_id, query_id;

drop view if exists magic44_count_test_results;
create view magic44_count_test_results as
select step_id, query_id, count(*) as result_total
from magic44_test_results group by step_id, query_id;

drop view if exists magic44_count_differences;
create view magic44_count_differences as
select magic44_count_answers.query_id, magic44_count_answers.step_id, answer_total, result_total
from magic44_count_answers left outer join magic44_count_test_results
	on magic44_count_answers.step_id = magic44_count_test_results.step_id
	and magic44_count_answers.query_id = magic44_count_test_results.query_id
where answer_total <> result_total or result_total is null
union
select magic44_count_test_results.query_id, magic44_count_test_results.step_id, answer_total, result_total
from magic44_count_test_results left outer join magic44_count_answers
	on magic44_count_test_results.step_id = magic44_count_answers.step_id
	and magic44_count_test_results.query_id = magic44_count_answers.query_id
where result_total <> answer_total or answer_total is null
order by query_id, step_id;

-- The magic44_content_differences view displays the differences between the answers and test results
-- in terms of the row attributes and values.  the error_category column contains missing for rows that
-- are not included in the test results but should be, while extra represents the rows that should not
-- be included in the test results.  the row_hash column contains the values of the row in a single
-- string with the attribute values separated by a selected delimiter (i.e., the pound sign/#).

drop view if exists magic44_content_differences;
create view magic44_content_differences as
select query_id, step_id, 'missing' as category, row_hash
from magic44_expected_results where row(step_id, query_id, row_hash) not in
	(select step_id, query_id, row_hash from magic44_test_results)
union
select query_id, step_id, 'extra' as category, row_hash
from magic44_test_results where row(step_id, query_id, row_hash) not in
	(select step_id, query_id, row_hash from magic44_expected_results)
order by query_id, step_id, row_hash;

drop view if exists magic44_result_set_size_errors;
create view magic44_result_set_size_errors as
select step_id, query_id, 'result_set_size' as err_category from magic44_count_differences
group by step_id, query_id;

drop view if exists magic44_attribute_value_errors;
create view magic44_attribute_value_errors as
select step_id, query_id, 'attribute_values' as err_category from magic44_content_differences
where row(step_id, query_id) not in (select step_id, query_id from magic44_count_differences)
group by step_id, query_id;

drop view if exists magic44_errors_assembled;
create view magic44_errors_assembled as
select * from magic44_result_set_size_errors
union
select * from magic44_attribute_value_errors;

drop table if exists magic44_row_count_errors;
create table magic44_row_count_errors
select * from magic44_count_differences
order by query_id, step_id;

drop table if exists magic44_column_errors;
create table magic44_column_errors
select * from magic44_content_differences
order by query_id, step_id, row_hash;

drop view if exists magic44_fast_expected_results;
create view magic44_fast_expected_results as
select step_id, query_id, query_label, query_name
from magic44_expected_results, magic44_test_case_directory
where base_step_id <= step_id and step_id <= (base_step_id + number_of_steps - 1)
group by step_id, query_id, query_label, query_name;

drop view if exists magic44_fast_row_based_errors;
create view magic44_fast_row_based_errors as
select step_id, query_id, query_label, query_name
from magic44_row_count_errors, magic44_test_case_directory
where base_step_id <= step_id and step_id <= (base_step_id + number_of_steps - 1)
group by step_id, query_id, query_label, query_name;

drop view if exists magic44_fast_column_based_errors;
create view magic44_fast_column_based_errors as
select step_id, query_id, query_label, query_name
from magic44_column_errors, magic44_test_case_directory
where base_step_id <= step_id and step_id <= (base_step_id + number_of_steps - 1)
group by step_id, query_id, query_label, query_name;

drop view if exists magic44_fast_total_test_cases;
create view magic44_fast_total_test_cases as
select query_label, query_name, count(*) as total_cases
from magic44_fast_expected_results group by query_label, query_name;

drop view if exists magic44_fast_correct_test_cases;
create view magic44_fast_correct_test_cases as
select query_label, query_name, count(*) as correct_cases
from magic44_fast_expected_results where row(step_id, query_id) not in
(select step_id, query_id from magic44_fast_row_based_errors
union select step_id, query_id from magic44_fast_column_based_errors)
group by query_label, query_name;

drop table if exists magic44_autograding_low_level;
create table magic44_autograding_low_level
select magic44_fast_total_test_cases.*, ifnull(correct_cases, 0) as passed_cases
from magic44_fast_total_test_cases left outer join magic44_fast_correct_test_cases
on magic44_fast_total_test_cases.query_label = magic44_fast_correct_test_cases.query_label
and magic44_fast_total_test_cases.query_name = magic44_fast_correct_test_cases.query_name;

drop table if exists magic44_autograding_score_summary;
create table magic44_autograding_score_summary
select query_label, query_name,
	round(scoring_weight * passed_cases / total_cases, 2) as final_score, scoring_weight
from magic44_autograding_low_level natural join magic44_test_case_directory
where passed_cases < total_cases
union
select null, 'REMAINING CORRECT CASES', sum(round(scoring_weight * passed_cases / total_cases, 2)), null
from magic44_autograding_low_level natural join magic44_test_case_directory
where passed_cases = total_cases
union
select null, 'TOTAL SCORE', sum(round(scoring_weight * passed_cases / total_cases, 2)), null
from magic44_autograding_low_level natural join magic44_test_case_directory;

drop table if exists magic44_autograding_high_level;
create table magic44_autograding_high_level
select score_tag, score_category, sum(total_cases) as total_possible,
	sum(passed_cases) as total_passed
from magic44_scores_guide natural join
(select *, mid(query_label, 2, 1) as score_tag from magic44_autograding_low_level) as temp
group by score_tag, score_category; -- order by display_order;

-- Evaluate potential query errors against the original state and the modified state
drop view if exists magic44_result_errs_original;
create view magic44_result_errs_original as
select distinct 'row_count_errors_initial_state' as title, query_id
from magic44_row_count_errors where step_id = 0;

drop view if exists magic44_result_errs_modified;
create view magic44_result_errs_modified as
select distinct 'row_count_errors_test_cases' as title, query_id
from magic44_row_count_errors
where query_id not in (select query_id from magic44_result_errs_original)
union
select * from magic44_result_errs_original;

drop view if exists magic44_attribute_errs_original;
create view magic44_attribute_errs_original as
select distinct 'column_errors_initial_state' as title, query_id
from magic44_column_errors where step_id = 0
and query_id not in (select query_id from magic44_result_errs_modified)
union
select * from magic44_result_errs_modified;

drop view if exists magic44_attribute_errs_modified;
create view magic44_attribute_errs_modified as
select distinct 'column_errors_test_cases' as title, query_id
from magic44_column_errors
where query_id not in (select query_id from magic44_attribute_errs_original)
union
select * from magic44_attribute_errs_original;

drop view if exists magic44_correct_remainders;
create view magic44_correct_remainders as
select distinct 'fully_correct' as title, query_id
from magic44_test_results
where query_id not in (select query_id from magic44_attribute_errs_modified)
union
select * from magic44_attribute_errs_modified;

drop view if exists magic44_grading_rollups;
create view magic44_grading_rollups as
select title, count(*) as number_affected, group_concat(query_id order by query_id asc) as queries_affected
from magic44_correct_remainders
group by title;

drop table if exists magic44_autograding_directory;
create table magic44_autograding_directory (query_status_category varchar(1000));
insert into magic44_autograding_directory values ('fully_correct'),
('column_errors_initial_state'), ('row_count_errors_initial_state'),
('column_errors_test_cases'), ('row_count_errors_test_cases');

drop table if exists magic44_autograding_query_level;
create table magic44_autograding_query_level
select query_status_category, number_affected, queries_affected
from magic44_autograding_directory left outer join magic44_grading_rollups
on query_status_category = title;

-- ----------------------------------------------------------------------------------
-- Validate/verify that the test case results are correct
-- The test case results are compared to the initial database state contents
-- ----------------------------------------------------------------------------------

drop procedure if exists magic44_check_test_case;
delimiter //
create procedure magic44_check_test_case(in ip_test_case_number integer)
begin
	select * from (select query_id, 'added' as category, row_hash
	from magic44_test_results where step_id = ip_test_case_number and row(query_id, row_hash) not in
		(select query_id, row_hash from magic44_expected_results where step_id = 0)
	union
	select temp.query_id, 'removed' as category, temp.row_hash
	from (select query_id, row_hash from magic44_expected_results where step_id = 0) as temp
	where row(temp.query_id, temp.row_hash) not in
		(select query_id, row_hash from magic44_test_results where step_id = ip_test_case_number)
	and temp.query_id in
		(select query_id from magic44_test_results where step_id = ip_test_case_number)) as unified
	order by query_id, row_hash;
end //
delimiter ;

-- ----------------------------------------------------------------------------------
-- [8] Generate views to help interpret the test results more easily
-- ----------------------------------------------------------------------------------
drop table if exists magic44_table_name_lookup;
create table magic44_table_name_lookup (
	query_id integer,
	table_or_view_name varchar(2000),
    primary key (query_id)
);

insert into magic44_table_name_lookup values
(10, 'cruiseline'), (11, 'location'), (12, 'ship'), (13, 'ship_port'), (14, 'person'),
(15, 'passenger'), (16, 'person_occupies'), (17, 'leg'), (18, 'route'), (19, 'route_path'),
(20, 'cruise'), (21, 'passenger_books'), (22, 'crew'), (23, 'licenses'), (30, 'cruises_at_sea'),
(31, 'cruises_docked'), (32, 'people_at_sea'), (33, 'people_docked'),
(34, 'route_summary'), (35, 'alternative_ports');

create or replace view magic44_column_errors_traceable as
select query_label as test_category, query_name as test_name, step_id as test_step_counter,
	table_or_view_name, category as error_category, row_hash
from (magic44_column_errors join magic44_test_case_directory
on (step_id between base_step_id and base_step_id + number_of_steps - 1))
natural join magic44_table_name_lookup
order by test_category, test_step_counter, row_hash;

-- ----------------------------------------------------------------------------------
-- [9] Remove unneeded tables, views, stored procedures and functions
-- ----------------------------------------------------------------------------------
-- Keep only those structures needed to provide student feedback
drop table if exists magic44_autograding_directory;

drop view if exists magic44_grading_rollups;
drop view if exists magic44_correct_remainders;
drop view if exists magic44_attribute_errs_modified;
drop view if exists magic44_attribute_errs_original;
drop view if exists magic44_result_errs_modified;
drop view if exists magic44_result_errs_original;
drop view if exists magic44_errors_assembled;
drop view if exists magic44_attribute_value_errors;
drop view if exists magic44_result_set_size_errors;
drop view if exists magic44_content_differences;
drop view if exists magic44_count_differences;
drop view if exists magic44_count_test_results;
drop view if exists magic44_count_answers;

drop procedure if exists magic44_query_check_and_run;

drop function if exists magic44_query_exists;
drop function if exists magic44_query_capture;
drop function if exists magic44_gen_simple_template;

drop table if exists magic44_column_listing;

-- The magic44_reset_database_state() and magic44_check_test_case procedures can be
-- dropped if desired, but they might be helpful for troubleshooting
-- drop procedure if exists magic44_reset_database_state;
-- drop procedure if exists magic44_check_test_case;

drop view if exists practiceQuery10;
drop view if exists practiceQuery11;
drop view if exists practiceQuery12;
drop view if exists practiceQuery13;
drop view if exists practiceQuery14;
drop view if exists practiceQuery15;
drop view if exists practiceQuery16;
drop view if exists practiceQuery17;
drop view if exists practiceQuery18;
drop view if exists practiceQuery19;
drop view if exists practiceQuery20;
drop view if exists practiceQuery21;
drop view if exists practiceQuery22;

drop view if exists practiceQuery30;
drop view if exists practiceQuery31;
drop view if exists practiceQuery32;
drop view if exists practiceQuery33;
drop view if exists practiceQuery34;
drop view if exists practiceQuery35;

drop view if exists magic44_fast_correct_test_cases;
drop view if exists magic44_fast_total_test_cases;
drop view if exists magic44_fast_column_based_errors;
drop view if exists magic44_fast_row_based_errors;
drop view if exists magic44_fast_expected_results;

drop table if exists magic44_scores_guide;
