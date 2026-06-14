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
