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
