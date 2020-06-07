CREATE TABLE hs1_teacher
(
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(20) NOT NULL,
    surname VARCHAR(20) NOT NULL
);


CREATE TABLE hs1_app_suite
(
    id        SERIAL PRIMARY KEY,
    name      VARCHAR(20) NOT NULL,
    teacherID INT REFERENCES hs1_teacher (id)
);

CREATE TABLE hs1_student
(
    id        SERIAL PRIMARY KEY,
    name      VARCHAR(20) NOT NULL,
    surname   VARCHAR(20) NOT NULL,
    app_suiteId INT REFERENCES hs1_app_suite (id)
);


CREATE TABLE hs1_schedule
(
    id        SERIAL PRIMARY KEY,
    app_suiteID INT REFERENCES hs1_app_suite (id) NOT NULL,
    startDay  VARCHAR(3)                       NOT NULL,
    startTime TIME                             NOT NULL,
    endTime   TIME                             NOT NULL
);

CREATE TABLE hs1_events
(
    id        SERIAL PRIMARY KEY,
    app_suiteID SERIAL REFERENCES hs1_app_suite (id) NOT NULL,
    start_    TIMESTAMP                           NOT NULL,
    end_      TIMESTAMP                           NOT NULL,
	is_test    BOOLEAN							  NOT NULL
);

INSERT INTO hs1_teacher
        (name, surname)
VALUES  ('Mathilda', 'Stewart'),
        ('Freddie', 'Farmer'),
		('Mary', 'Singh'),
		('Norman', 'Simmons'),
		('Carlene', 'Owen'),
        ('Simone', 'Li');

INSERT INTO hs1_app_suite
        (name, teacherID)
VALUES  ('OPENCE', 1),
        ('JSHARE', 2),
		('gigaos', 3),
        ('maemod', 4);

INSERT INTO hs1_student
        (name, surname, app_suiteId)
VALUES  ('Hartmut', 'Polley', 1),
        ('Gilead', 'Rutten', 1),
        ('Jaleh', 'Guttuso', 2),
        ('Gorgi', 'Vacca', 2),
        ('Marko', 'Ó Seachnasaigh', 3),
        ('Sollemnia', 'Abiodun', 3),
        ('Shanta', 'Rosenberg', 1),
        ('Jagdish', 'Gass', 2),
		('Karan', 'Longo', 4),
		('Ventseslav', 'Hyland', 4),
		('Karan', 'F', 4);

INSERT INTO hs1_schedule
        (app_suiteID, startDay, startTime, endTime)
VALUES  (1, 'Mon', '8:00', '9:00'),
        (1, 'Trd', '8:00', '9:00'),
        (2, 'Wed', '10:00', '11:00'),
        (2, 'Frd', '12:00', '13:00'),
        (3, 'Tue', '13:00', '14:00'),
        (3, 'Sun', '15:00', '16:00'),
		(4, 'Mon', '16:00', '17:00'),
		(4, 'Wed', '12:00', '13:00');
INSERT INTO hs1_events
        (app_suiteID, start_, end_, is_test)
VALUES  (1, '2017-09-01 10:00:00', '2017-09-01 15:00:00', TRUE),
        (2, '2018-10-02 14:00:00', '2018-10-02 19:00:00', FALSE),
        (3, '2019-11-03 13:00:00', '2019-11-03 18:00:00', TRUE),
		(4, '2020-12-04 12:00:00', '2020-12-04 17:00:00', FALSE);