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
COPY unnormalized_data FROM 'C:\\Users\\Gulsh\\OneDrive\\Masaüstü\\Unnormalized_data.csv' DELIMITER ',' CSV HEADER;

select * from public.unnormalized_data




--1NF
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

select * from FirstNF




