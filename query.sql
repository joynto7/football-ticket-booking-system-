DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id      INT            NOT NULL,
    full_name    VARCHAR(100)   NOT NULL,
    email        VARCHAR(150)   NOT NULL,
    role         VARCHAR(50)    NOT NULL,
    phone_number VARCHAR(20),

    CONSTRAINT pk_users        PRIMARY KEY (user_id),
    CONSTRAINT uq_users_email  UNIQUE      (email),
    CONSTRAINT chk_users_role  CHECK       (role IN ('Ticket Manager', 'Football Fan'))
);


CREATE TABLE Matches (
    match_id             INT             NOT NULL,
    fixture              VARCHAR(200)    NOT NULL,
    tournament_category  VARCHAR(100)    NOT NULL,
    base_ticket_price    DECIMAL(10, 2)  NOT NULL,
    match_status         VARCHAR(20)     NOT NULL,

    CONSTRAINT pk_matches          PRIMARY KEY (match_id),
    CONSTRAINT chk_matches_price   CHECK       (base_ticket_price >= 0),
    CONSTRAINT chk_matches_status  CHECK       (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

CREATE TABLE Bookings (
    booking_id      INT             NOT NULL,
    user_id         INT             NOT NULL,
    match_id        INT             NOT NULL,
    seat_number     VARCHAR(10),
    payment_status  VARCHAR(20),
    total_cost      DECIMAL(10, 2)  NOT NULL,

    CONSTRAINT pk_bookings             PRIMARY KEY (booking_id),
    CONSTRAINT fk_bookings_user        FOREIGN KEY (user_id)  REFERENCES Users(user_id),
    CONSTRAINT fk_bookings_match       FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    CONSTRAINT chk_bookings_total_cost CHECK       (total_cost >= 0),
    CONSTRAINT chk_bookings_payment    CHECK       (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded'))
);

CREATE TABLE Bookings (
    booking_id      INT             NOT NULL,
    user_id         INT             NOT NULL,
    match_id        INT             NOT NULL,
    seat_number     VARCHAR(10),
    payment_status  VARCHAR(20),
    total_cost      DECIMAL(10, 2)  NOT NULL,

    CONSTRAINT pk_bookings             PRIMARY KEY (booking_id),
    CONSTRAINT fk_bookings_user        FOREIGN KEY (user_id)  REFERENCES Users(user_id),
    CONSTRAINT fk_bookings_match       FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    CONSTRAINT chk_bookings_total_cost CHECK       (total_cost >= 0),
    CONSTRAINT chk_bookings_payment    CHECK       (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded'))
);

INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan',   '+8801711111111'),
(2, 'Asif Haque',    'asif@mail.com',   'Football Fan',   '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara',    'jannat@mail.com', 'Football Fan',   NULL);


INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool',    'Premier League',   120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG',     'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan',  'Serie A',           90.00, 'Sold Out'),
(105, 'Juventus vs Roma',         'Serie A',           80.00, 'Available');


INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL,   NULL,        150.00),
(505, 3, 102, 'C-20', 'Pending',   120.00);

SELECT match_id, fixture, base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';


SELECT user_id, full_name, email
FROM Users
WHERE full_name ILIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';

   SELECT booking_id,
       user_id,
       match_id,
       COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;
