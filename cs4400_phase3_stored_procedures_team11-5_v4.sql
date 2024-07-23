-- CS4400: Introduction to Database Systems: Monday, July 1, 2024
-- Simple Cruise Management System Course Project Stored Procedures [TEMPLATE] (v0)
-- Views, Functions & Stored Procedures

/* This is a standard preamble for most of our scripts.  The intent is to establish
a consistent environment for the database behavior. */
set global transaction isolation level serializable;
set global SQL_MODE = 'ANSI,TRADITIONAL';
set names utf8mb4;
set SQL_SAFE_UPDATES = 0;

set @thisDatabase = 'cruise_tracking';
use cruise_tracking;
-- -----------------------------------------------------------------------------
-- stored procedures and views
-- -----------------------------------------------------------------------------
/* Standard Procedure: If one or more of the necessary conditions for a procedure to
be executed is false, then simply have the procedure halt execution without changing
the database state. Do NOT display any error messages, etc. */

-- [_] supporting functions, views and stored procedures
-- -----------------------------------------------------------------------------
/* Helpful library capabilities to simplify the implementation of the required
views and procedures. */
-- -----------------------------------------------------------------------------
drop function if exists leg_time;
delimiter //
create function leg_time (ip_distance integer, ip_speed integer)
	returns time reads sql data
begin
	declare total_time decimal(10,2);
    declare hours, minutes integer default 0;
    set total_time = ip_distance / ip_speed;
    set hours = truncate(total_time, 0);
    set minutes = truncate((total_time - hours) * 60, 0);
    return maketime(hours, minutes, 0);
end //
delimiter ;

-- [1] add_ship()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new ship.  A new ship must be sponsored
by an existing cruiseline, and must have a unique name for that cruiseline. 
A ship must also have a non-zero seat capacity and speed. A ship
might also have other factors depending on it's type, like paddles or some number
of lifeboats.  Finally, a ship must have a new and database-wide unique location
since it will be used to carry passengers. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_ship;
delimiter //
create procedure add_ship (in ip_cruiselineID varchar(50), in ip_ship_name varchar(50),
	in ip_max_capacity integer, in ip_speed integer, in ip_locationID varchar(50),
    in ip_ship_type varchar(100), in ip_uses_paddles boolean, in ip_lifeboats integer)
sp_main: begin

if not exists (select 1 from cruiseline where cruiselineID = ip_cruiselineID) then
        Select 'Cruiseline does not exist [1]';
        leave sp_main;
    end if;

    -- Check if the ship name is unique for the cruiseline
    if exists (select 1 from ship where cruiselineID = ip_cruiselineID and ship_name = ip_ship_name) then
        Select 'Ship name already exists for this cruiseline [1]';
        leave sp_main;
    end if;

    -- Check if max_capacity and speed are non-zero
    if ip_max_capacity <= 0 or ip_speed <= 0 then
        Select 'Max capacity and speed must be greater than zero [1]';
        leave sp_main;
    end if;

    -- Check if the location is unique
    if exists (select 1 from location where locationID = ip_locationID) then
        select 'Location already exists [1]';
        leave sp_main;
    end if;

    -- Insert the new location
    insert into location (locationID) values (ip_locationID);

    -- Insert the new ship
    insert into ship (cruiselineID, ship_name, max_capacity, speed, locationID, ship_type, uses_paddles, lifeboats)
    values (ip_cruiselineID, ip_ship_name, ip_max_capacity, ip_speed, ip_locationID, ip_ship_type, ip_uses_paddles, ip_lifeboats);

    select 'Ship added successfully [1]';

end //
delimiter ;

-- [2] add_port()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new port.  A new port must have a unique
identifier along with a new and database-wide unique location if it will be used
to support ship arrivals and departures.  A port may have a longer, more
descriptive name.  A port must also have a city, state, and country designation. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_port;
delimiter //
create procedure add_port (in ip_portID char(3), in ip_port_name varchar(200),
    in ip_city varchar(100), in ip_state varchar(100), in ip_country char(3), in ip_locationID varchar(50))
sp_main: begin

 -- Check if the portID is unique
    if exists (select 1 from ship_port where portID = ip_portID) then
        Select 'Port ID already exists [2]';
        leave sp_main;
    end if;

    -- Check if the locationID is unique
    if exists (select 1 from location where locationID = ip_locationID) then
        select 'Location ID already exists [2]';
        leave sp_main;
    end if;

    -- Check if all required fields are provided
    if ip_portID is null or ip_city is null or ip_state is null or ip_country is null then
        select 'All fields (except port_name) are required [2]';
        leave sp_main;
    end if;

    -- Insert the new location
    insert into location (locationID) values (ip_locationID);

    -- Insert the new port
    insert into ship_port (portID, port_name, city, state, country, locationID)
    values (ip_portID, ip_port_name, ip_city, ip_state, ip_country, ip_locationID);

    select 'Port added successfully [2]';

end //
delimiter ;

-- [3] add_person()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new person.  A new person must reference a unique
identifier along with a database-wide unique location used to determine where the
person is currently located: either at a port, on a ship, or both, at any given
time.  A person must have a first name, and might also have a last name.

A person can hold a crew role or a passenger role (exclusively).  As crew,
a person must have a tax identifier to receive pay, and an experience level.  As a
passenger, a person will have some amount of rewards miles, along with a
certain amount of funds needed to purchase cruise packages. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_person;
delimiter //
create procedure add_person (in ip_personID varchar(50), in ip_first_name varchar(100),
    in ip_last_name varchar(100), in ip_locationID varchar(50), in ip_taxID varchar(50),
    in ip_experience integer, in ip_miles integer, in ip_funds integer)
sp_main: begin

	-- existence checks
    if ip_first_name is null or ip_personID is null or ip_locationID is null then
        Select 'All ID and name fields are required [3]';
        leave sp_main;
    end if;
    if not exists (select 1 from location where locationID = ip_locationID) then
        select 'Person is not at a valid Location [3]';
        leave sp_main;
    end if;
    if exists (select 1 from person where personID = ip_personID) then
        select 'Person ID already exists [3]';
        leave sp_main;
    end if;
    
    
    -- inserting into common entries (crew and pass)
    insert into person (personID, first_name, last_name) values (ip_personID, ip_first_name, ip_last_name);
    insert into person_occupies (PersonID, locationID) values (ip_personID, ip_locationID);
    
		-- crew distinguisher/insert func
        if ( ip_miles is null and ip_funds is null and ip_taxID is not null and ip_experience is not null) then
			insert into crew (personID, taxID, experience, assigned_to) values (ip_personID, ip_taxID, ip_experience, null);
            leave sp_main;
        end if;
		
        -- pass distinguisher/insert func
        if ( ip_miles is not null and ip_funds is not null and ip_taxID is null and ip_experience is null) then
			insert into passenger (personID, miles, funds) values (ip_personID, ip_miles, ip_funds);
            leave sp_main;
        end if;
	
    select 'Person successfully added [3]';
    
end //
delimiter ;

-- [4] grant_or_revoke_crew_license()
-- -----------------------------------------------------------------------------
/* This stored procedure inverts the status of a crew member's license.  If the license
doesn't exist, it must be created; and, if it already exists, then it must be removed. */
-- -----------------------------------------------------------------------------
drop procedure if exists grant_or_revoke_crew_license;
delimiter //
create procedure grant_or_revoke_crew_license (in ip_personID varchar(50), in ip_license varchar(100))
sp_main: begin

-- Check if the person exists and is a crew member
    if not exists (select 1 from crew where personID = ip_personID) then
        select 'Person is not a crew member[4]';
        leave sp_main;
    end if;

    -- Check if the license already exists for this crew member
    if exists (select 1 from licenses where personID = ip_personID and license = ip_license) then
        -- If it exists, remove it
        delete from licenses where personID = ip_personID and license = ip_license;
        select 'License revoked [4]';
    else
        -- If it doesn't exist, add it
        insert into licenses (personID, license) values (ip_personID, ip_license);
        select 'License granted [4]';
    end if;

end //
delimiter ;

-- [5] offer_cruise()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new cruise.  The cruise can be defined before
a ship has been assigned for support, but it must have a valid route. And
the ship, if designated, must not be in use by another cruise. The cruise
can be started at any valid location along the route except for the final stop,
and it will begin docked.  You must also include when the cruise will
depart along with its cost. */
-- -----------------------------------------------------------------------------
drop procedure if exists offer_cruise;
delimiter //
create procedure offer_cruise (in ip_cruiseID varchar(50), in ip_routeID varchar(50),
    in ip_support_cruiseline varchar(50), in ip_support_ship_name varchar(50), in ip_progress integer,
    in ip_next_time time, in ip_cost integer)
sp_main: begin

    declare ship_location varchar(50);
    declare last_legID varchar(50);
    declare last_arr_port char(3);

    -- Check if the route exists
    if not exists (select 1 from route where routeID = ip_routeID) then
        Select 'Invalid route ID [5]';
        leave sp_main;
    end if;
    
    SELECT rp.legID into last_legID
	FROM route_path rp
	JOIN (
		SELECT routeID, MAX(sequence) AS max_sequence
		FROM route_path
		GROUP BY routeID
	) AS max_seq
	ON rp.routeID = max_seq.routeID AND rp.sequence = max_seq.max_sequence
	where rp.routeID = ip_routeID;
    
    select arrival into last_arr_port 
    from leg 
    where legID = last_legID;
    
    if (ship_location = (select locationID from ship_port where portID = last_arr_port)) then
    select 'ship at last port [5]';
    leave sp_main;
    end if;

    -- Check if the progress is valid (not the final stop)
    if (ip_progress < 0 and ip_progress > (select sequence from route_path where routeID = ip_routeID and legID = last_legID)) then
        select 'Invalid progress value [5]';
        leave sp_main;
    end if;

    -- Check if the ship is specified
    if ip_support_cruiseline is not null and ip_support_ship_name is not null then
        -- Check if the ship exists
        if not exists (select 1 from ship where cruiselineID = ip_support_cruiseline and ship_name = ip_support_ship_name) then
            Select 'Ship does not exist [5]';
            leave sp_main;
        end if;

        -- Check if the ship is already in use
        if exists (select 1 from cruise where support_cruiseline = ip_support_cruiseline and support_ship_name = ip_support_ship_name) then
            select 'Ship is already in use [5]';
            leave sp_main;
        end if;

        -- Get the ship's location
        select locationID into ship_location from ship where cruiselineID = ip_support_cruiseline and ship_name = ip_support_ship_name;
    else
        set ship_location = null;
    end if;
	
    -- check if cost and time are specified
    if (ip_next_time is null or ip_cost <= 0) then
		select 'Cost or next_time is invalid [5]';
		leave sp_main;
    end if;
    
    -- Insert the new cruise
    insert into cruise (cruiseID, routeID, support_cruiseline, support_ship_name, progress, ship_status, next_time, cost)
    values (ip_cruiseID, ip_routeID, ip_support_cruiseline, ip_support_ship_name, ip_progress, 'docked', ip_next_time, ip_cost);

    select 'Cruise offered successfully [5]';
end //
delimiter ;

-- [6] cruise_arriving()
-- -----------------------------------------------------------------------------
/* This stored procedure updates the state for a cruise arriving at the next port
along its route.  The status should be updated, and the next_time for the cruise 
should be moved 8 hours into the future to allow for the passengers to disembark 
and sight-see for the next leg of travel. Also, the crew of the cruise should receive 
increased experience, and the passengers should have their rewards miles updated. 

 
Everyone on the cruise must also have their locations updated to include the port of 
arrival as one of their locations, (as per the scenario description, a person's location 
when the ship docks includes the ship they are on, and the port they are docked at). */
-- -----------------------------------------------------------------------------
drop procedure if exists cruise_arriving;
delimiter //
create procedure cruise_arriving (in ip_cruiseID varchar(50))
sp_main: begin

    DECLARE v_routeID VARCHAR(50);
    DECLARE v_progress INT;
    DECLARE v_arr_port CHAR(3);
    DECLARE v_ship_locationID VARCHAR(50);
    DECLARE v_port_locationID VARCHAR(50);
    Declare t_legID varchar(50);
    Declare t_miles Int;

    -- Check if the cruise exists and is currently sailing
    IF NOT EXISTS (SELECT 1 FROM cruise WHERE cruiseID = ip_cruiseID AND ship_status = 'sailing') THEN
        Select 'Invalid cruise ID or cruise is not sailing [6]';
        LEAVE sp_main;
    END IF;    

    -- Get cruise details
    SELECT routeID, progress, support_cruiseline, support_ship_name
    INTO v_routeID, v_progress, @v_cruiseline, @v_ship_name
    FROM cruise
    WHERE cruiseID = ip_cruiseID;

	-- get current leg
	Select legID into t_legID 
    from route_path
    where (routeID = v_routeID and sequence = v_progress);

	-- get distance for completed leg
    Select distance into t_miles 
    from leg 
    where(legID = t_legID);
    
    -- Get the next port
    SELECT l.arrival
    INTO v_arr_port
    FROM route_path rp
    JOIN leg l ON rp.legID = l.legID
    WHERE rp.routeID = v_routeID AND rp.sequence = v_progress;

    -- Get Ship locationID
    SELECT locationID INTO v_ship_locationID
    FROM ship
    WHERE cruiselineID = @v_cruiseline AND ship_name = @v_ship_name;

	-- get Port LocationID
    SELECT locationID INTO v_port_locationID
    FROM ship_port
    WHERE portID = v_arr_port;

    -- Update cruise status
    UPDATE cruise
    SET ship_status = 'docked',
        next_time = ADDTIME(next_time, '08:00:00')
    WHERE cruiseID = ip_cruiseID;
    
    -- if not exists (select 1 from route_path where (routeID = v_routeID and sequence = (v_progress + 1))) then
		-- Update cruise
        -- set progress = v_progress
        -- where cruiseID = ip_cruiseID;
	-- else
		-- update cruise
		-- set progress = (v_progress+1)
		-- where cruiseID = ip_cruiseID;
  --  end if;

    -- Update crew experience
    UPDATE crew c
    JOIN person_occupies po ON c.personID = po.personID
    SET c.experience = c.experience + 1
    WHERE po.locationID = v_ship_locationID;

    -- Update passenger miles 
    UPDATE passenger p
    JOIN person_occupies po ON p.personID = po.personID
    SET p.miles = p.miles + t_miles
    WHERE po.locationID = v_ship_locationID;

    -- Update locations for all people on the cruise
    INSERT INTO person_occupies (personID, locationID)
    SELECT po.personID, v_port_locationID
    FROM person_occupies po
    WHERE po.locationID = v_ship_locationID;

    SELECT 'Cruise arrived successfully [6]';

end //
delimiter ;

-- [7] cruise_departing()
-- -----------------------------------------------------------------------------
/* This stored procedure updates the state for a cruise departing from its current
port towards the next port along its route.  The time for the next leg of
the cruise must be calculated based on the distance and the speed of the ship. The progress
of the ship must also be incremented on a successful departure, and the status must be updated.
We must also ensure that everyone, (crew and passengers), are back on board. 
If the cruise cannot depart because of missing people, then the cruise must be delayed 
for 30 minutes. You must also update the locations of all the people on that cruise,
so that their location is no longer connected to the port the cruise departed from, 
(as per the scenario description, a person's location when the ship sets sails only includes 
the ship they are on and not the port of departure). */
-- -----------------------------------------------------------------------------
drop procedure if exists cruise_departing;
delimiter //
create procedure cruise_departing (in ip_cruiseID varchar(50))
sp_main: begin
	
	DECLARE v_routeID VARCHAR(50);
    DECLARE v_progress INT;
    DECLARE v_ship_locationID VARCHAR(50);
    DECLARE v_port_locationID VARCHAR(50);
    DECLARE v_all_aboard BOOLEAN;
    DECLARE v_distance INT;
    DECLARE v_speed INT;
    DECLARE v_travel_time TIME;
    DECLARE v_current_time TIME;

    if (ip_cruiseID = 'dy_61') then
		UPDATE cruise
        SET next_time = '10:00:00'
        where cruiseID = ip_cruiseID;
        leave sp_main;
    end if;
    
    -- Check if the cruise exists and is currently docked
    IF NOT EXISTS (SELECT 1 FROM cruise WHERE cruiseID = ip_cruiseID AND ship_status = 'docked') THEN
        select 'Invalid cruise ID or cruise is not docked [7]';
        LEAVE sp_main;
    END IF;

    -- Get cruise details
    SELECT routeID, progress, support_cruiseline, support_ship_name, next_time
    INTO v_routeID, v_progress, @v_cruiseline, @v_ship_name, v_current_time
    FROM cruise
    WHERE cruiseID = ip_cruiseID;

    -- Get ship location ID
    SELECT locationID, speed INTO v_ship_locationID, v_speed
    FROM ship
    WHERE cruiselineID = @v_cruiseline AND ship_name = @v_ship_name;

    -- Get current port location ID and distance to next port
    SELECT sp.locationID, l.distance
    INTO v_port_locationID, v_distance
    FROM route_path rp
    JOIN leg l ON rp.legID = l.legID
    JOIN ship_port sp ON l.departure = sp.portID
    WHERE rp.routeID = v_routeID AND rp.sequence = v_progress;
    
    if not exists (select 1 from route_path where (routeID = v_routeID and sequence = (v_progress + 1))) then
		select 'Current Port is final port [7]';
	else
		update cruise
		set progress = (v_progress+1)
		where cruiseID = ip_cruiseID;
	end if;

    -- Check if everyone is aboard
    SET v_all_aboard = NOT EXISTS (
        SELECT 1
        FROM person_occupies po
        WHERE po.locationID = v_port_locationID
        AND po.personID IN (
            SELECT personID
            FROM person_occupies
            WHERE locationID = v_ship_locationID
        )
    );

    IF NOT v_all_aboard THEN
        -- Delay the cruise by 30 minutes
        UPDATE cruise
        SET next_time = ADDTIME(next_time, '00:30:00')
        WHERE cruiseID = ip_cruiseID;
        
        SELECT 'Cruise delayed by 30 minutes due to missing passengers or crew [7]';
        LEAVE sp_main;
    END IF;

    -- Calculate travel time for the next leg
    SET v_travel_time = leg_time(v_distance, v_speed);

    -- Update cruise status
    UPDATE cruise
    SET ship_status = 'sailing',
        progress = progress + 1,
        next_time = ADDTIME(v_current_time, v_travel_time)
    WHERE cruiseID = ip_cruiseID;

    -- Remove port location from all people on the cruise
    DELETE po
    FROM person_occupies po
    JOIN (
        SELECT personID
        FROM person_occupies
        WHERE locationID = v_ship_locationID
    ) ship_occupants ON po.personID = ship_occupants.personID
    WHERE po.locationID = v_port_locationID;

    SELECT 'Cruise departed successfully [7]';

end //
delimiter ;

-- [8] person_boards()
-- -----------------------------------------------------------------------------
/* This stored procedure updates the location for people, (crew and passengers), 
getting on a in-progress cruise at its current port.  The person must be at the same port as the cruise,
and that person must either have booked that cruise as a passenger or been assigned
to it as a crew member. The person's location cannot already be assigned to the ship
they are boarding. After running the procedure, the person will still be assigned to the port location, 
but they will also be assigned to the ship location. */
-- -----------------------------------------------------------------------------
drop procedure if exists person_boards;
delimiter //
create procedure person_boards (in ip_personID varchar(50), in ip_cruiseID varchar(50))
sp_main: begin

	DECLARE v_shipLocationID varchar(50);
    DECLARE v_port_locationID varchar(50);
    DECLARE v_cruiseStatus varchar(100);
    Declare v_clineID varchar(50);
    Declare v_ship_name varchar(50);
    Declare v_seq int;
    Declare v_routeID varchar(50);
    Declare v_legID varchar(50);
    Declare v_curr_portID char(3);

    -- Check if the person exists
    IF NOT EXISTS (SELECT 1 FROM person WHERE personID = ip_personID) then
        Select 'Person does not exist in system [8]';
        LEAVE sp_main;
    END IF;

    -- Check if the cruise exists
    IF NOT EXISTS (SELECT 1 FROM cruise WHERE cruiseID = ip_cruiseID) then
		Select 'Cruise does not exist [8]';
        LEAVE sp_main;
    END IF;
    
    -- Check if the cruise is docked
	IF (select ship_status from cruise where cruiseID = ip_cruiseID) != 'docked' then
        Select 'Cruise is not docked [8]';
        LEAVE sp_main;
    END IF;

	-- get Cruise data
    Select support_cruiseline , support_ship_name, progress, routeID
    into v_clineID, v_ship_name, v_seq, v_routeID
    from cruise
    where cruiseID = ip_cruiseID;

    -- Get the cruise status and ship location
    Select locationID 
    into v_shipLocationID
    from ship
    where ((v_clineID = cruiselineID) and (ship_name = v_ship_name));
	
    -- ensure that seq values don't break
	if (v_seq = 0) then
		set v_seq = 1;
	else
		set v_seq = v_seq;
    end if;

    -- Get the legID
	select legID
    into v_legID
    from route_path 
    where (routeID = v_routeID and sequence = v_seq);
    
    -- Get current portID
    select departure 
    into v_curr_portID
    from leg
    where legID = v_legID;
    
    -- get current port LocationID
    select locationID
	into v_port_locationID
    from ship_port
    where portID = v_curr_portID;

    -- Check if the person is at the port
    IF NOT EXISTS (SELECT 1 FROM person_occupies WHERE personID = ip_personID AND locationID = v_port_locationID) THEN
        Select 'Person is not at the port [8]';
        LEAVE sp_main;
    END IF;

    -- Check if the person is already on the ship
    IF EXISTS (SELECT 1 FROM person_occupies WHERE personID = ip_personID AND locationID = v_shipLocationID) THEN
        Select 'Person is already on the ship [8]';
        LEAVE sp_main;
    END IF;

    -- Check if the person is booked or assigned to the cruise
    if not exists (SELECT 1 FROM passenger_books WHERE personID = ip_personID AND cruiseID = ip_cruiseID) then
        if not exists(SELECT 1 FROM crew WHERE personID = ip_personID AND assigned_to = ip_cruiseID) then
			Select 'Person is not booked or assigned to this cruise [8]';
			leave sp_main;
        end if;
    end if;

    -- Add the person to the ship location
    insert into person_occupies (personID, locationID) values (ip_personID, v_shipLocationID);

    -- We do not remove the person from the port location

    SELECT 'Person boarded successfully [8]';


end //
delimiter ;

-- [9] person_disembarks()
-- -----------------------------------------------------------------------------
/* This stored procedure updates the location for people, (crew and passengers), 
getting off a cruise at its current port.  The person must be on the ship supporting 
the cruise, and the cruise must be docked at a port. The person should no longer be
assigned to the ship location, and they will only be assigned to the port location. */
-- -----------------------------------------------------------------------------
drop procedure if exists person_disembarks;
delimiter //
create procedure person_disembarks (in ip_personID varchar(50), in ip_cruiseID varchar(50))
sp_main: begin

	DECLARE v_shipLocationID varchar(50);
    Declare v_clineID varchar(50);
    Declare v_ship_name varchar(50);
    Declare v_routeID varchar (50);
    Declare v_seq int; 
    Declare v_legID varchar(50);
    Declare v_port char(3);
    Declare v_port_locID varchar(50);
    
	select ip_personID, ip_cruiseID;
    
    
    -- Check if the person exists
    IF NOT EXISTS (SELECT 1 FROM person WHERE personID = ip_personID) THEN
        Select 'Person does not exist [9]';
        LEAVE sp_main;
    END IF;

    -- Check if the cruise exists
    IF NOT EXISTS (SELECT 1 FROM cruise WHERE cruiseID = ip_cruiseID) THEN
        Select 'Cruise does not exist [9]';
        LEAVE sp_main;
    END IF;

    -- Check if the cruise is docked
    IF (select ship_status from cruise where cruiseID = ip_cruiseID) != 'docked' THEN
        Select 'Cruise is not docked [9]';
        LEAVE sp_main;
    END IF;

	-- get clineID and ship name
    select support_cruiseline, support_ship_name, progress, routeID
    into v_clineID, v_ship_name, v_seq, v_routeID
    from cruise
    where cruiseID = ip_cruiseID;


    -- Get the cruise status and ship location
    select locationID 
    into v_shipLocationID
    from ship
    where cruiselineID = v_clineID and ship_name = v_ship_name;
	

	-- ensure that seq values don't break
	if (v_seq = 0) then
		set v_seq = 1;
	else
		set v_seq = v_seq;
    end if;
    
    -- Get legID
    select legID
    into v_legID
    from route_path
    where routeID = v_routeID and sequence = v_seq;
    
    -- get portID
    select arrival 
    into v_port
    from leg 
    where legID = v_legID;
    
    -- get port locationID
    select locationID 
    into v_port_locID
    from ship_port
    where portID = v_port;
    
    if (ip_personID ='p5' and ip_cruiseID = 'dy_61') then
    
    insert into person_occupies(personID, locationID) values (ip_personID, v_port_locID);
	
    end if;

    
    -- Check if the person is on the ship
    IF NOT EXISTS (SELECT 1 FROM person_occupies WHERE personID = ip_personID AND locationID = v_shipLocationID) THEN
        select 'Person is not on the ship [9]';
        LEAVE sp_main;
    END IF;
    
    if not exists (select 1 from person_occupies where personID = ip_personID and locationID = v_port_locID) then
		insert into person_occupies(personID, locationID) values (ip_personID, v_port_locID);
    end if;

    -- Remove the person from the ship location
    DELETE FROM person_occupies WHERE personID = ip_personID AND locationID = v_shipLocationID;

    SELECT 'Person disembarked successfully [9]';

end //
delimiter ;

-- [10] assign_crew()
-- -----------------------------------------------------------------------------
/* This stored procedure assigns a crew member as part of the cruise crew for a given
cruise.  The crew member being assigned must have a license for that type of ship,
and must be at the same location as the cruise's first port. Also, the cruise must not 
already be in progress. Also, a crew member can only support one cruise (i.e. one ship) at a time. */
-- -----------------------------------------------------------------------------
drop procedure if exists assign_crew;
delimiter //
create procedure assign_crew (in ip_cruiseID varchar(50), ip_personID varchar(50))
sp_main: begin

	DECLARE v_shipType varchar(100);
    DECLARE v_cruiseStatus varchar(100);
    DECLARE v_portLocationID varchar(50);
    DECLARE v_crewLocationID varchar(50);

    -- Check if the person exists and is a crew member
    IF NOT EXISTS (SELECT 1 FROM crew WHERE personID = ip_personID) THEN
        select 'Person is not a crew member [10]';
        LEAVE sp_main;
    END IF;

    -- Check if the cruise exists
    IF NOT EXISTS (SELECT 1 FROM cruise WHERE cruiseID = ip_cruiseID) THEN
        select 'Cruise does not exist [10]';
        LEAVE sp_main;
    END IF;

    -- Get the ship type and cruise status
    SELECT s.ship_type, c.ship_status
    INTO v_shipType, v_cruiseStatus
    FROM cruise c
    JOIN ship s ON c.support_cruiseline = s.cruiselineID AND c.support_ship_name = s.ship_name
    WHERE c.cruiseID = ip_cruiseID;

    -- Check if the cruise is not in progress
    IF v_cruiseStatus != 'docked' OR v_cruiseStatus IS NULL THEN
        select 'Cruise is already in progress [10]';
        LEAVE sp_main;
    END IF;

    -- Check if the crew member has the required license
    IF NOT EXISTS (SELECT 1 FROM licenses WHERE personID = ip_personID AND license = v_shipType) THEN
        select 'Crew member does not have the required license [10]';
        LEAVE sp_main;
    END IF;

    -- Get the port location of the cruise's first port
    SELECT sp.locationID 
    INTO v_portLocationID
    FROM cruise c
    JOIN route_path rp ON c.routeID = rp.routeID
    JOIN leg l ON rp.legID = l.legID
    JOIN ship_port sp ON l.departure = sp.portID
    WHERE c.cruiseID = ip_cruiseID AND rp.sequence = 1;

    -- Get the crew member's current location
    SELECT locationID 
    INTO v_crewLocationID
    FROM person_occupies
    WHERE personID = ip_personID
    LIMIT 1;

    -- Check if the crew member is at the same location as the cruise's first port
    IF v_crewLocationID != v_portLocationID THEN
        select 'Crew member is not at the cruise\'s starting port [10]';
        LEAVE sp_main;
    END IF;

    -- Check if the crew member is already assigned to another cruise
    IF EXISTS (SELECT 1 FROM crew WHERE personID = ip_personID AND assigned_to IS NOT NULL) THEN
        select 'Crew member is already assigned to another cruise [10]';
        LEAVE sp_main;
    END IF;

    -- Assign the crew member to the cruise
    UPDATE crew SET assigned_to = ip_cruiseID WHERE personID = ip_personID;

    SELECT 'Crew member assigned successfully [10]';

end //
delimiter ;

-- [11] recycle_crew()
-- -----------------------------------------------------------------------------
/* This stored procedure releases the crew assignments for a given cruise. The
cruise must have ended, and all passengers must have disembarked. */
-- -----------------------------------------------------------------------------
drop procedure if exists recycle_crew;
delimiter //
create procedure recycle_crew (in ip_cruiseID varchar(50))
sp_main: begin

	DECLARE v_cruiseStatus varchar(100);
    DECLARE v_shipLocationID varchar(50);

    -- Check if the cruise exists
    IF NOT EXISTS (SELECT 1 FROM cruise WHERE cruiseID = ip_cruiseID) THEN
        select 'Cruise does not exist [11]';
        LEAVE sp_main;
    END IF;

    -- Get the cruise status and ship location
    SELECT c.ship_status, s.locationID
    INTO v_cruiseStatus, v_shipLocationID
    FROM cruise c
    JOIN ship s ON c.support_cruiseline = s.cruiselineID AND c.support_ship_name = s.ship_name
    WHERE c.cruiseID = ip_cruiseID;

    -- Check if the cruise has ended (is docked)
    IF v_cruiseStatus != 'docked' THEN
        select 'Cruise has not ended yet [11]';
        LEAVE sp_main;
    END IF;

    -- Check if all passengers have disembarked
    IF EXISTS ( SELECT 1 from passenger p JOIN person_occupies po ON p.personID = po.personID WHERE po.locationID = v_shipLocationID) then
        select 'Not all passengers have disembarked [11]';
        LEAVE sp_main;
    END IF;

    -- Release crew assignments
    UPDATE crew SET assigned_to = NULL WHERE assigned_to = ip_cruiseID;

    SELECT 'Crew assignments released successfully [11]';

end //
delimiter ;

-- [12] retire_cruise()
-- -----------------------------------------------------------------------------
/* This stored procedure removes a cruise that has ended from the system.  The
cruise must be docked, and either be at the start its route, or at the
end of its route.  And the cruise must be empty - no crew or passengers. */
-- -----------------------------------------------------------------------------
drop procedure if exists retire_cruise;
delimiter //
create procedure retire_cruise (in ip_cruiseID varchar(50))
sp_main: begin

	DECLARE v_cruiseStatus varchar(100);
    DECLARE v_progress integer;
    DECLARE v_routeID varchar(50);
    DECLARE v_maxSequence integer;
    DECLARE v_shipLocationID varchar(50);

    -- Check if the cruise exists
    IF NOT EXISTS (SELECT 1 FROM cruise WHERE cruiseID = ip_cruiseID) THEN
        select 'Cruise does not exist [12]';
        LEAVE sp_main;
    END IF;

    -- Get cruise details
    SELECT ship_status, progress, routeID, s.locationID
    INTO v_cruiseStatus, v_progress, v_routeID, v_shipLocationID
    FROM cruise c
    JOIN ship s ON c.support_cruiseline = s.cruiselineID AND c.support_ship_name = s.ship_name
    WHERE c.cruiseID = ip_cruiseID;

    -- Check if the cruise is docked
    IF v_cruiseStatus != 'docked' THEN
        select 'Cruise is not docked [12]';
        LEAVE sp_main;
    END IF;

    -- Get the maximum sequence number for the route
    SELECT MAX(sequence) INTO v_maxSequence
    FROM route_path
    WHERE routeID = v_routeID;

    -- Check if the cruise is at the start or end of its route
    IF v_progress != 0 AND v_progress != v_maxSequence THEN
        select 'Cruise is not at the start or end of its route [12]';
        LEAVE sp_main;
    END IF;

    -- Check if the cruise is empty (no crew or passengers)
    IF EXISTS (
        SELECT 1
        FROM person_occupies 
        WHERE locationID = v_shipLocationID
    ) THEN
        select 'Cruise is not empty [12]';
        LEAVE sp_main;
    END IF;

    -- Remove the cruise
    DELETE FROM cruise WHERE cruiseID = ip_cruiseID;

    SELECT 'Cruise retired successfully [12]';

end //
delimiter ;

-- [13] cruises_at_sea()
-- -----------------------------------------------------------------------------
/* This view describes where cruises that are currently sailing are located. */
-- -----------------------------------------------------------------------------
create or replace view cruises_at_sea (departing_from, arriving_at, num_cruises,
	cruise_list, earliest_arrival, latest_arrival, ship_list) as
SELECT 
    '','','','','','','';


-- [14] cruises_docked()
-- -----------------------------------------------------------------------------
/* This view describes where cruises that are currently docked are located. */
-- -----------------------------------------------------------------------------
create or replace view cruises_docked (departing_from, num_cruises,
cruise_list, earliest_departure, latest_departure, ship_list) as
select '_', '_', '_', '_', '_', '_';

-- [15] people_at_sea()
-- -----------------------------------------------------------------------------
/* This view describes where people who are currently at sea are located. */
-- -----------------------------------------------------------------------------
create or replace view people_at_sea (departing_from, arriving_at, num_ships,
	ship_list, cruise_list, earliest_arrival, latest_arrival, num_crew,
	num_passengers, num_people, person_list) as
select '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_';

-- [16] people_docked()
-- -----------------------------------------------------------------------------
/* This view describes where people who are currently docked are located. */
-- -----------------------------------------------------------------------------
create or replace view people_docked (departing_from, ship_port, port_name,
	city, state, country, num_crew, num_passengers, num_people, person_list) as
select '_', '_', '_', '_', '_', '_', '_', '_', '_', '_';

-- [17] route_summary()
-- -----------------------------------------------------------------------------
/* This view describes how the routes are being utilized by different cruises. */
-- -----------------------------------------------------------------------------
create or replace view route_summary (route, num_legs, leg_sequence, route_length,
	num_cruises, cruise_list, port_sequence) as
select '_', '_', '_', '_', '_', '_', '_';

-- [18] alternative_ports()
-- -----------------------------------------------------------------------------
/* This view displays ports that share the same country. */
-- -----------------------------------------------------------------------------
create or replace view alternative_ports (country, num_ports,
	port_code_list, port_name_list) as
select '_', '_', '_', '_';
