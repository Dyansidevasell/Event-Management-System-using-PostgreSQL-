/* 1. Database Creation 
Create a database named "EventsManagement." Create tables for Events, Attendees, and Registrations. 
Events- Event_Id, Event_Name, Event_Date, Event_Location, Event_Description 
Attendees- Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City 
Registrations-Registration_id, Event_Id, Attendee_Id,Registration_Date,Registration_Amount. 
The FOREIGN KEY constraint in the Registrations table references the Event_Id column in the Events table and the Attendee_Id column in the Attendees table.  */

CREATE DATABASE EventsManagement;

/* Create the Events table */

CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,
    Event_Name VARCHAR(255) NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Location VARCHAR(255) NOT NULL,
    Event_Description TEXT
);

Select * From Events;

/* Create the Attendees table */

CREATE TABLE Attendees (
    Attendee_Id SERIAL PRIMARY KEY,
    Attendee_Name VARCHAR(255) NOT NULL,
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(255) UNIQUE,
    Attendee_City VARCHAR(255)
);

Select * From Attendees;

/* Create the Registrations table */
CREATE TABLE Registrations (
    Registration_Id SERIAL PRIMARY KEY,
    Event_Id INT NOT NULL,
    Attendee_Id INT NOT NULL,
    Registration_Date DATE NOT NULL,
    Registration_Amount DECIMAL(10, 2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

Select * From Registrations;

/* 2. Data Creation 
Insert some sample data for Events, Attendees, and Registrations tables with respective fields. */

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
('Potery Fest', '2024-12-25', 'WTC, Porur', 'Potery class and display of potery arts.'),
('Vanakkam Chennai', '2024-12-24', 'ITC, Guindy', 'All time music and cultural fest in chennai.'),
('Food Fest', '2024-12-31', 'Island Ground, Chennai', 'Food eating challenge and food stalls.');

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
('Hanny', '4455667788', 'hanny@gmail.com', 'Ooty'),
('Joannah', '5566778899', 'joma@gmail.com', 'Kunoor'),
('Hannah', '2233445566', 'hannah@yahoo.com', 'Vagamon'),
('Janez', '8877665544', 'sathrak@gmail.com', 'Kulu');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
(3, 1, '2024-07-27', 5500.00),  -- Hanny registers for Food Fest
(1, 2, '2024-06-06', 1500.00),  -- Joannah registers for Potery Fest
(3, 3, '2024-06-12', 5500.00),   -- Hannah registers for Food Fest
(2, 4, '2024-07-20', 2000.00);   -- Janez registers for Vanakkam Chennai

select * from Events;

/* 3. Manage Event Details 
a) Inserting a new event. */

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
('Music Fest', '2024-12-13', 'Taj, Chennai', 'Music event including all types of music western and folk music. This includes dance competitions for interested');

select * from Events;

/* b) Updating an event's information. */

UPDATE Events
SET Event_Location = 'Holiday INN, SH',
    Event_Description = 'The Fest is based soley on Tamil music.'
WHERE Event_Id = 4;

SELECT * FROM EVENTS
WHERE EVENT_ID = 4;

/* c) Deleting an event. */

SELECT * FROM Registrations WHERE Event_Id = 2; -- Checking for registered attentees in event id 2 
DELETE FROM Registrations WHERE Event_Id = 2;  -- deleted entry value for registered attentees in event id 2
DELETE FROM Registrations WHERE Event_Id = 2; -- deleted event id 2

select * from registrations;

/* 4) Manage Track Attendees & Handle Events 
a) Inserting a new attendee. */

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('Oswald', '7898765423', 'Os@yahoo.com', 'Delhi');

select * from Attendees;

/* b) Registering an attendee for an event.  */

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (1, 5, '2024-10-20', 7500.00);

/*  show the added event */

SELECT
    a.Attendee_Name,
    e.Event_Id,
    e.Event_Name,
    e.Event_Date,
    a.Attendee_Id,
    r.Registration_Amount
FROM
    Registrations r
JOIN
    Events e ON r.Event_Id = e.Event_Id
JOIN
    Attendees a ON r.Attendee_Id = a.Attendee_Id
WHERE
    r.Event_Id = 1 AND r.Attendee_Id = 5;

/* 5.Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics. */

SELECT e.Event_Id, e.Event_Name, COUNT(r.Attendee_Id) AS Total_Attendees
FROM Events e
LEFT JOIN Registrations r ON e.Event_Id = r.Event_Id
GROUP BY e.Event_Id, e.Event_Name;