-- 1 
CREATE Table Books(
    book_id INT PRIMARY KEY,
    title VARCHAR(255)
);

CREATE TABLE Author (
    author_id INT PRIMARY KEY,
    author_name INT
);

CREATE TABLE Author_book(
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE Publisher (
    publisher_id INT,
    book_id INT,
    author_id INT,
    publisher_name VARCHAR(255),
    publisher_city VARCHAR(100),
    FOREIGN KEY (book_id, author_id) REFERENCES Author_book(book_id, author_id)
);

-- 2
CREATE TABLE Car(
    car_model VARCHAR(100) PRIMARY KEY,
    car_manufacture VARCHAR(100)
);

CREATE TABLE Race_results (
    race_id INT,
    driver_id INT,
    finish_time TIME,
    car_model VARCHAR(100),
    PRIMARY KEY (race_id, driver_id),
    FOREIGN KEY (car_model) REFERENCES car(car_model)
);

-- 3
CREATE TABLE Room(
    room_id INT PRIMARY KEY,
    room_name VARCHAR(100)   
);

CREATE TABLE Booking(
    booking_id INT PRIMARY KEY,
    room_id INT,
    booking_time DATE,
    event_name event_type,
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);
