# Database Normalization Assignment

This project demonstrates the normalization process of an unnormalized dataset through First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF) using SQL.

## Contents

1. **Unnormalized Data**  
   - The initial dataset is stored in the `unnormalized_data` table, which contains redundant and composite data that needs normalization.

2. **Normalization Steps**
   - **1NF:** Split multivalued attributes into atomic values.
   - **2NF:** Remove partial dependencies by creating separate tables for related entities.
   - **3NF:** Remove transitive dependencies by further decomposing tables.

3. **Final Tables**  
   After normalization, the final tables include:
   - `books_nf3`
   - `publisher_nf3`
   - `authors_nf2`
   - `courses_nf2`
   - `book_authors_nf2`
   - `course_books_nf2`
   - `book_publisher_nf3`

---

## Schema Description

### Unnormalized Data Table
- **Table Name:** `unnormalized_data`  
- **Columns:**  
  - `CRN`: Course Registration Number  
  - `ISBN`: Book ISBN  
  - `Title`: Book title  
  - `Authors`: Comma-separated list of authors  
  - `Edition`: Book edition  
  - `Publisher`: Publisher name  
  - `Publisher_Address`: Publisher address  
  - `Pages`: Number of pages in the book  
  - `Year`: Year of publication  
  - `Course_Name`: Name of the course  

### 1NF: `FirstNF` Table
- Eliminated multivalued attributes by creating atomic data entries for authors.  

### 2NF: Splitting into Entity Tables
1. **Courses Table (`courses_nf2`)**  
   - `CRN` (Primary Key)  
   - `Course_Name`
2. **Books Table (`books_nf2`)**  
   - `ISBN` (Primary Key)  
   - Other book details (Title, Edition, Publisher, etc.)
3. **Authors Table (`authors_nf2`)**  
   - `AuthorID` (Primary Key)  
   - `Author_Name`  
4. **Relationship Tables**  
   - `book_authors_nf2`: Mapping between books and authors.  
   - `course_books_nf2`: Mapping between courses and books.  

### 3NF: Removing Transitive Dependencies
1. **Publisher Table (`publisher_nf3`)**  
   - `Publisher_ID` (Primary Key)  
   - `Publisher_Name`  
   - `Publisher_Address`
2. **Book-Publisher Relationship (`book_publisher_nf3`)**  
   - Maps `ISBN` to `Publisher_ID`.

---


### Final Tables
- After completing all steps, the database contains fully normalized tables that minimize redundancy and improve query efficiency.
