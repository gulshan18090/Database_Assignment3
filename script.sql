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




