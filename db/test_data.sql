-- Theatres
INSERT INTO Theatre (Company_Name, Location, Open_Showtime, Close_Showtime) VALUES
('Cinemark', 'Glendale, CA', '10:00', '23:00'),
('AMC', 'Los Angeles, CA', '11:00', '22:00');

-- Screens
INSERT INTO Screens (Theatre_ID, Screen_Type, Reclining_Seats) VALUES
(1, 'IMAX', TRUE),         -- Screen 1
(1, 'Standard', FALSE),    -- Screen 2
(2, 'Dolby', TRUE),        -- Screen 3
(2, 'Standard', TRUE);     -- Screen 4

-- Movies
INSERT INTO Movie (Title, Runtime) VALUES
('Interstellar', 169),     -- Movie 1
('Inception', 148);        -- Movie 2

-- Actors
INSERT INTO Actor (Full_Name) VALUES
('Matthew McConaughey'),  -- Actor 1
('Leonardo DiCaprio');    -- Actor 2

-- Movie_Actor
INSERT INTO Movie_Actor (Movie_ID, Actor_ID) VALUES
(1, 1),
(2, 2);

-- Showings (2 per screen, total 8)
INSERT INTO Showing (Screen_ID, Movie_ID, Show_Date, Show_Time) VALUES
(1, 1, '2025-05-07', '14:00'), -- Showing 1
(1, 2, '2025-05-07', '18:00'), -- Showing 2
(2, 2, '2025-05-08', '15:00'), -- Showing 3
(2, 1, '2025-05-08', '19:00'), -- Showing 4
(3, 1, '2025-05-07', '13:30'), -- Showing 5
(3, 2, '2025-05-07', '17:30'), -- Showing 6
(4, 2, '2025-05-08', '16:00'), -- Showing 7
(4, 1, '2025-05-08', '20:00'); -- Showing 8

-- Tickets
-- Showing 1 (1 ticket)
INSERT INTO Ticket (Showing_ID, Type_Name, Price) VALUES
(1, 'Adult', 15.00),
(1, 'Adult', 15.00),
(1, 'Adult', 15.00),
(1, 'Adult', 15.00),
(1, 'Adult', 15.00);

-- Showing 2 (2 tickets: Adult + Student)
INSERT INTO Ticket (Showing_ID, Type_Name, Price) VALUES
(2, 'Adult', 15.00),
(2, 'Student', 11.00),
(2, 'Adult', 15.00),
(2, 'Adult', 15.00);

-- Showing 3 (1 ticket)
INSERT INTO Ticket (Showing_ID, Type_Name, Price) VALUES
(3, 'Senior', 12.00),
(7, 'Adult', 15.00),
(8, 'Adult', 15.00),
(7, 'Adult', 15.00),
(8, 'Adult', 15.00);

-- Showing 4 (2 tickets: Senior + Child)
INSERT INTO Ticket (Showing_ID, Type_Name, Price) VALUES
(4, 'Senior', 12.00),
(4, 'Child', 10.00),
(4, 'Adult', 15.00),
(4, 'Adult', 15.00);

-- Showing 5 (1 ticket)
INSERT INTO Ticket (Showing_ID, Type_Name, Price) VALUES
(5, 'Child', 10.00),
(5, 'Adult', 15.00),
(5, 'Adult', 15.00);

-- Showing 6 (2 tickets: Child + Adult)
INSERT INTO Ticket (Showing_ID, Type_Name, Price) VALUES
(6, 'Child', 10.00),
(6, 'Adult', 15.00);

-- Showing 7 (1 ticket)
INSERT INTO Ticket (Showing_ID, Type_Name, Price) VALUES
(7, 'Adult', 15.00),
(7, 'Adult', 15.00),
(7, 'Senior', 12.00),
(7, 'Adult', 15.00),
(7, 'Senior', 12.00);

-- Showing 8 (2 tickets: Adult + Senior)
INSERT INTO Ticket (Showing_ID, Type_Name, Price) VALUES
(8, 'Adult', 15.00),
(8, 'Senior', 12.00);