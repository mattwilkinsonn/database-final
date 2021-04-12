CREATE TABLE vip(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    points INT NOT NULL
);
CREATE TABLE city(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT NOT NULL,
    population INT NOT NULL
);
CREATE TABLE train(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT NOT NULL,
    model TEXT NOT NULL,
    cars INT NOT NULL
);
CREATE TABLE station(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT NOT NULL,
    city_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city (id)
);
CREATE TABLE track(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    outgoing_station INT UNSIGNED NOT NULL,
    incoming_station INT UNSIGNED NOT NULL,
    length INT NOT NULL,
    FOREIGN KEY(outgoing_station) REFERENCES station(id),
    FOREIGN KEY(incoming_station) REFERENCES station(id)
);
CREATE TABLE train_stop(
    station_id INT UNSIGNED NOT NULL,
    train_id INT UNSIGNED NOT NULL,
    time_in TIMESTAMP NOT NULL,
    time_out TIMESTAMP NOT NULL,
    stop INT NOT NULL,
    FOREIGN KEY (station_id) REFERENCES station(id),
    FOREIGN KEY (train_id) REFERENCES train(id),
    PRIMARY KEY (station_id, train_id)
);
CREATE TABLE passenger(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT NOT NULL,
    age INT NOT NULL,
    vip_id INT UNSIGNED NULL,
    FOREIGN KEY (vip_id) REFERENCES vip(id)
);
CREATE TABLE booking(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    train_id INT UNSIGNED NOT NULL,
    passenger_id INT UNSIGNED NOT NULL,
    station_in INT UNSIGNED NOT NULL,
    station_out INT UNSIGNED NOT NULL,
    FOREIGN KEY (train_id) REFERENCES train(id),
    FOREIGN KEY (passenger_id) REFERENCES passenger(id),
    FOREIGN KEY (station_in) REFERENCES station(id),
    FOREIGN KEY (station_out) REFERENCES station(id)
);
CREATE TABLE accident(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    train_id INT UNSIGNED NOT NULL,
    track_id INT UNSIGNED NOT NULL,
    time TIMESTAMP NOT NULL,
    cause TEXT NOT NULL,
    FOREIGN KEY (train_id) REFERENCES train(id),
    FOREIGN KEY (track_id) REFERENCES track(id)
);
CREATE TABLE employee(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT NOT NULL,
    role TEXT NOT NULL,
    station_id INT UNSIGNED NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (station_id) REFERENCES station(id)
);
INSERT INTO city
values(1, 'New York City', '8000000');
INSERT INTO city
values(2, 'Washington DC', '1000000');
INSERT INTO city
VALUES(3, 'Boston', '600000');
INSERT INTO city
values(4, 'Philadelphia', '1500000');
INSERT INTO city
values(5, 'Richmond', '200000');
INSERT INTO station
VALUES(1, 'Penn Station', 1);
INSERT INTO station
VALUES(2, 'Union Station', 2);
INSERT INTO station
VALUES(3, 'South Station', 3);
INSERT INTO station
VALUES(4, '30th Street Station', 4);
INSERT INTO station
VALUES(5, 'Main Street Station', 5);
INSERT INTO train (name, model, cars)
VALUES('Acela', 'Express', 20);
INSERT INTO train (name, model, cars)
VALUES('Northeast', 'Regional', 33);
INSERT INTO train (name, model, cars)
VALUES('Zephyr', 'Regional', 12);
INSERT INTO train (name, model, cars)
VALUES('Crescent', 'Regional', 24);
INSERT INTO track (outgoing_station, incoming_station, length)
VALUES(1, 2, 500);
INSERT INTO track (outgoing_station, incoming_station, length)
VALUES(2, 1, 500);
INSERT INTO track (outgoing_station, incoming_station, length)
VALUES(2, 3, 1000);
INSERT INTO track (outgoing_station, incoming_station, length)
VALUES(3, 2, 1000);
INSERT INTO track (outgoing_station, incoming_station, length)
VALUES(4, 3, 1500);
INSERT INTO track (outgoing_station, incoming_station, length)
VALUES(4, 5, 5500);
INSERT INTO track (outgoing_station, incoming_station, length)
VALUES(5, 4, 5500);
INSERT INTO train_stop
VALUES (
        1,
        1,
        '2008-01-01 05:00:00',
        '2008-01-01 01:00:00',
        1
    );
INSERT INTO train_stop
VALUES (
        2,
        1,
        '2008-01-01 00:05:03',
        '2008-01-01 06:02:00',
        2
    );
INSERT INTO train_stop
VALUES (
        2,
        2,
        '2008-01-01 03:00:00',
        '2008-01-01 07:30:00',
        1
    );
INSERT INTO train_stop
VALUES (
        3,
        2,
        '2008-01-01 09:20:20',
        '2008-01-01 10:30:01',
        2
    );
INSERT INTO train_stop
VALUES (
        3,
        3,
        '2008-01-01 10:45:13',
        '2008-01-01 11:30:21',
        1
    );
INSERT INTO train_stop
VALUES (
        4,
        3,
        '2008-01-01 12:45:11',
        '2008-01-01 11:30:18',
        2
    );
INSERT INTO train_stop
VALUES (
        5,
        3,
        '2008-01-01 14:12:11',
        '2008-01-01 15:30:00',
        3
    );
INSERT INTO train_stop
VALUES (
        5,
        4,
        '2008-01-01 12:43:00',
        '2008-01-01 17:00:20',
        1
    );
INSERT INTO vip (id, points)
VALUES (1, 20000);
INSERT INTO vip (id, points)
VALUES (2, 80000);
INSERT INTO vip (id, points)
VALUES (3, 150000);
INSERT INTO vip (id, points)
VALUES (4, 150);
INSERT INTO passenger (name, age, vip_id)
VALUES ('Matt', 21, NULL);
INSERT INTO passenger (name, age, vip_id)
VALUES ('Jessica', 36, 1);
INSERT INTO passenger (name, age, vip_id)
VALUES ('John', 19, NULL);
INSERT INTO passenger (name, age, vip_id)
VALUES ('Andrew', 50, 2);
INSERT INTO passenger (name, age, vip_id)
VALUES ('Emily', 28, 3);
INSERT INTO passenger (name, age, vip_id)
VALUES ('Hannah', 25, 4);
INSERT INTO booking (train_id, passenger_id, station_in, station_out)
VALUES (1, 1, 1, 2);
INSERT INTO booking (train_id, passenger_id, station_in, station_out)
VALUES (3, 2, 2, 3);
INSERT INTO booking (train_id, passenger_id, station_in, station_out)
VALUES (4, 3, 4, 5);
INSERT INTO booking (train_id, passenger_id, station_in, station_out)
VALUES (2, 5, 2, 3);
INSERT INTO accident (train_id, track_id, time, cause)
VALUES (1, 2, '2008-01-01 21:38:20', 'Power failure');
INSERT INTO employee (name, role, station_id, salary)
VALUES ('Dua', 'Manager', 1, 150000);
INSERT INTO employee (name, role, station_id, salary)
VALUES ('Ed', 'Train Conductor', 2, 70000);
INSERT INTO employee (name, role, station_id, salary)
VALUES ('Abel', 'Janitor', 1, 45000);
INSERT INTO employee (name, role, station_id, salary)
VALUES ('Phillip', 'Manager', 2, 200000);
INSERT INTO employee (name, role, station_id, salary)
VALUES ('Sarah', 'General Manager', 3, 250000);
INSERT INTO employee (name, role, station_id, salary)
VALUES ('John', 'Mechanic', 4, 70000);
INSERT INTO employee (name, role, station_id, salary)
VALUES ('Tommy', 'Mechanic', 5, 90000);