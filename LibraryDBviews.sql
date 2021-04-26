-- View to display author name, number of books, average rating and total ratins
create view v_Author_Facts
as
select top 25 percent 
		author_name as [Author name],
		count(title) as [Number of Books],
		cast(avg(average_rating) as decimal(4,2)) as [Average Rating],
		sum(ratings_count) as [Total Ratings]
	from tbl_Authors
	join tbl_Books on tbl_Books.author_id = tbl_Authors.id
	group by author_name
	order by [Number of Books] desc,
	  [Average Rating] desc
go

-- View that Displays publishers and number of books
create view v_Publisher_Books
as
	select top 30 percent
			publisher as [Publisher],
			count(title) as [Number of Books]
				from tbl_Books
			group by publisher
			order by [Number of Books] desc
go

-- View that shows total members with each membership type
create view v_Memberships
as
select member_type as [Membership Type], 
  count(*) as [Total Members] 
	from tbl_MembershipType
	join tbl_Members on tbl_MembershipType.id = tbl_Members.membership_id
	group by member_type
go

-- View that shows each member with Overdue
create view v_Overdue
as
select	concat(first_name,' ',last_name) as [Full Name],
		days_overdue as [Days Overdue],
		total_charge as [Total Overdue Charge]
	from tbl_Members
	join tbl_Overdue on tbl_Members.id = tbl_Overdue.member_id
go

-- View that shows total charge overtime for each member
create view v_TotalCharge
as
select  concat(first_name,' ',last_name) as [Full Name],
		sum(total_charge) as [Total Charge]
	from tbl_Members
	join tbl_Overdue on tbl_Members.id = tbl_Overdue.member_id
	group by first_name,last_name
go

-- View that shows issued books w/rating
create view v_IssuedBooksRatings
as
select top 15 percent	
		title as [Book Title],
		average_rating as [Average Rating],
		count(*) as [Number of Issues]
	from tbl_Books
	join tbl_BooksIssued
	on tbl_Books.id = tbl_BooksIssued.book_id
	group by title,average_rating
	order by [Number of Issues] desc,
			 average_rating desc
go

-- View that returns books with aliases
create view v_BookInfo
as
	select top 100 percent
			title as [Book Title],
			author_name as [Author],
			num_pages as [Number of Pages],
			isbn as [ISBN],
			isbn13 as [ISBN-13],
			average_rating as [Rating],
			ratings_count as [Ratings Count],
			publisher as [Publisher]
				from tbl_Books
			join tbl_Authors on
			tbl_Books.author_id = tbl_Authors.id
			order by [Book Title],[Author],[Number of Pages],[Rating]
go