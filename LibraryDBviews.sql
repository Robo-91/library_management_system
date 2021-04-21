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

-- View that shows total members with each membership type
create view v_Memberships
as
select member_type as [Membership Type], 
  count(*) as [Total Members] 
	from tbl_MembershipType
	join tbl_Members on tbl_MembershipType.id = tbl_Members.membership_id
	group by member_type
go
