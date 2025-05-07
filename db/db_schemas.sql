-- Theatre (Top Level)
CREATE TABLE IF NOT EXISTS Theatre (
    Theatre_ID SERIAL PRIMARY KEY,
    Company_Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Open_Showtime TIME NOT NULL,
    Close_Showtime TIME NOT NULL
);

-- Screen Type Enum
CREATE TYPE screen_type_enum AS ENUM ('Standard', 'IMAX', 'Dolby');

-- Screens
CREATE TABLE IF NOT EXISTS Screens (
    Screen_ID SERIAL PRIMARY KEY,
    Theatre_ID INT NOT NULL REFERENCES Theatre(Theatre_ID) ON DELETE CASCADE,
    Screen_Type screen_type_enum NOT NULL,
    Reclining_Seats BOOLEAN DEFAULT FALSE
);

-- Movies
CREATE TABLE IF NOT EXISTS Movie (
    Movie_ID SERIAL PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    Runtime INT NOT NULL
);

-- Showing
CREATE TABLE IF NOT EXISTS Showing (
    Showing_ID SERIAL PRIMARY KEY,
    Screen_ID INT NOT NULL REFERENCES Screens(Screen_ID) ON DELETE CASCADE,
    Movie_ID INT NOT NULL REFERENCES Movie(Movie_ID) ON DELETE CASCADE,
    Show_Date DATE NOT NULL,
    Show_Time TIME NOT NULL
);

-- Ticket types
CREATE TYPE ticket_type_enum AS ENUM ('Adult', 'Child', 'Senior', 'Student');

-- Tickets
CREATE TABLE IF NOT EXISTS Ticket (
    Ticket_ID SERIAL PRIMARY KEY,
    Showing_ID INT NOT NULL REFERENCES Showing(Showing_ID) ON DELETE CASCADE,
    Type_Name ticket_type_enum NOT NULL,
    Price DECIMAL(6,2) NOT NULL
);

-- Actor
CREATE TABLE IF NOT EXISTS Actor (
    Actor_ID SERIAL PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL
);

-- Movie_Actor
CREATE TABLE IF NOT EXISTS Movie_Actor (
    Movie_ID INT NOT NULL REFERENCES Movie(Movie_ID) ON DELETE CASCADE,
    Actor_ID INT NOT NULL REFERENCES Actor(Actor_ID) ON DELETE CASCADE,
    PRIMARY KEY (Movie_ID, Actor_ID)
);
