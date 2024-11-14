CREATE TABLE unnormalized_data (
    CRN INT,
    ISBN VARCHAR(13),
    Title VARCHAR(255),
    Authors VARCHAR(255),
    Edition VARCHAR(50),
    Publisher VARCHAR(255),
    Publisher_Address VARCHAR(255),
    Pages INT,
    Year INT,
    Course_Name VARCHAR(255)
);

-- To load from a CSV file (make sure the file is accessible to PostgreSQL)
COPY unnormalized_data FROM 'C:\Users\Gulsh\Unnormalized_data.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE FirstNF (
    CRN INT,
    ISBN VARCHAR(13),
    Title VARCHAR(255),
    Author VARCHAR(255),
    Edition VARCHAR(50),
    Publisher VARCHAR(255),
    Publisher_address text,
    Pages INT,
    Year INT,
    Course_Name VARCHAR(255)
);


INSERT INTO FirstNF (CRN, ISBN, Title, Author, Edition, Publisher,Publisher_address, Pages, Year, Course_Name)
SELECT CRN, ISBN, Title, unnest(string_to_array(Authors, ',')), Edition, Publisher,Publisher_address, Pages, Year, Course_Name
FROM unnormalized_data;

--2NF
-- BOOKS, COURSES, AUTHORS, BOOK_AUTHORS, CORUSE_BOOKS

create table courses_nf2(
	CRN INT primary key,
	course_name varchar(255)
)

insert into courses_nf2(CRN, course_name)
select distinct CRN, course_name from unnormalized_data


create table books_nf2(
	ISBN VARCHAR(13) primary key,
    Title VARCHAR(255),
    Edition VARCHAR(50),
    Publisher VARCHAR(255),
    Publisher_address text,
    Pages INT,
    Year INT
)


INSERT INTO books_nf2 (ISBN, Title, Edition, Publisher, Publisher_address, Pages, Year)
SELECT DISTINCT ISBN, Title, Edition, Publisher, Publisher_address, Pages, Year FROM FirstNF;



CREATE TABLE authors_nf2 AS
SELECT DISTINCT
    Author as Author_Name
FROM FirstNF;
ALTER TABLE authors_nf2
ADD AuthorID SERIAL PRIMARY KEY;


create table book_authors_nf2 as
select book.ISBN, author.AuthorID from books_nf2 as book
join authors_nf2 as author on 



CREATE TABLE book_authors_nf2 AS
SELECT DISTINCT
    cb.ISBN,
	a.AuthorID
FROM FirstNF as cb
JOIN Authors_NF2 as a on cb.author = a.author_name;

create table course_books_nf2 as
select distinct
    cb.ISBN,
	a.CRN
FROM FirstNF as cb
JOIN courses_nf2 as a on cb.course_name = a.course_name;


--3NF
--PUBLISHER BOOK_PUBLISHER

create table publisher_nf3 as
select distinct
	publisher as publisher_name,
	publisher_address
from books_nf2
ALTER TABLE publisher_nf3
ADD publisher_id SERIAL PRIMARY KEY;


create table books_nf3 as
select ISBN, title, edition, pages, year from books_nf2

create table book_publisher_nf3 as
select distinct
  b.ISBN,
  p.publisher_id
from books_nf2 as b
join publisher_nf3 as p on b.publisher=p.publisher_name
--final tables 
--BOOKS_NF3 PUBLISHER_NF3 AUTHORS_NF2 COURSES_NF2 BOOK_AUTHORS_NF2 BOOK_PUBLISHER_NF3 COURSE_BOOKS_NF2