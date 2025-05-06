-- 🎭 Theatres
INSERT INTO Theatre (Company_Name, Location, Open_Showtime, Close_Showtime) VALUES
('CineWorld', 'New York, NY', '10:00', '23:00'),
('Star Cinema', 'Los Angeles, CA', '11:00', '22:00');

-- 🧩 Screen Specialties
INSERT INTO Screen_Specialty (Screen_Type) VALUES
('IMAX'), ('Standard');

-- 🖥️ Screens (2 per theatre)
INSERT INTO Screens (Theatre_ID, Specialty_ID, Reclining_Seats) VALUES
(1, 1, TRUE),  -- CineWorld IMAX
(1, 2, FALSE), -- CineWorld Standard
(2, 1, TRUE),  -- Star Cinema IMAX
(2, 2, TRUE);  -- Star Cinema Standard

-- 🎬 Movies
INSERT INTO Movie (Title, Runtime) VALUES
('Inception', 148),
('Avengers: Endgame', 181);

-- 🎫 Ticket Types
INSERT INTO Ticket_Type (Type_Name) VALUES
('Adult'), ('Child'), ('Senior');

-- 🕰️ Showings (2 movies × 2 theatres × 2 days × 1 screen = 8 showings)
-- Screens 1 and 3 are IMAX screens in CineWorld and Star Cinema respectively
-- Inception → Screen 1, Avengers → Screen 3
INSERT INTO Showing (Screen_ID, Movie_ID, Date, Start_Time) VALUES
-- May 10
(1, 1, '2025-05-10 14:00'),
(1, 1, '2025-05-10 18:00'),
(3, 2, '2025-05-10 15:00'),
(3, 2, '2025-05-10 19:00'),
-- May 11
(1, 1, '2025-05-11 14:00'),
(1, 1, '2025-05-11 18:00'),
(3, 2, '2025-05-11 15:00'),
(3, 2, '2025-05-11 19:00');

-- 🎟️ Tickets (3 per showing)
-- 8 showings × 3 tickets = 24 rows
INSERT INTO Ticket (Showing_ID, Type_ID, Price) VALUES
-- Showing 1
(1, 1, 14.99), (1, 2, 9.99), (1, 3, 12.99),
-- Showing 2
(2, 1, 14.99), (2, 2, 9.99), (2, 3, 12.99),
-- Showing 3
(3, 1, 15.99), (3, 2, 10.99), (3, 3, 12.99),
-- Showing 4
(4, 1, 15.99), (4, 2, 10.99), (4, 3, 12.99),
-- Showing 5
(5, 1, 14.99), (5, 2, 9.99), (5, 3, 12.99),
-- Showing 6
(6, 1, 14.99), (6, 2, 9.99), (6, 3, 12.99),
-- Showing 7
(7, 1, 15.99), (7, 2, 10.99), (7, 3, 12.99),
-- Showing 8
(8, 1, 15.99), (8, 2, 10.99), (8, 3, 12.99);

