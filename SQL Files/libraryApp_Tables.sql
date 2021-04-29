use Library_App_DB;

create table tbl_Authors
(
	id int identity primary key,
	author_name varchar(255)
);

create table tbl_MembershipType
(
	id int identity primary key,
	member_type varchar(50),
	day_length int
);

create table tbl_BookLog
(
	id int identity primary key,
	message varchar(255)
);

create table tbl_Members
(
	id int identity primary key,
	first_name varchar(50),
	last_name varchar(50),
	membership_id int foreign key references tbl_MembershipType(id)
);

create table tbl_Books
(
	id int primary key,
	title varchar(255),
	author_id int foreign key references tbl_authors(id),
	average_rating decimal(3,2),
	isbn int,
	isbn13 int,
	num_pages int,
	ratings_count int,
	text_reviews_count int,
	publication_date datetime,
	publisher varchar(255)
);

create table tbl_BooksIssued
(
	id int identity primary key,
	book_id int foreign key references tbl_Books(id),
	member_id int foreign key references tbl_Members(id),
	date_issued datetime default getdate()
);

create table tbl_Overdue
(
	id int identity primary key,
	member_id int foreign key references tbl_Members(id),
	days_overdue int
);