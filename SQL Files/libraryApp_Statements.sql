-- Create CTE that returns members with overdue books issued
with cte_DaysIssued(cte_BooksIssuedId,cte_MemberId,cte_DaysIssued,cte_Membershiplength)
as
(
	select tbl_BooksIssued.id as [ID],
	tbl_BooksIssued.member_id as [Member ID],
	DATEDIFF(day,date_issued,date_returned) as [Days Issued],
	day_length as [Membership Length]
		from tbl_BooksIssued
		join tbl_Members on
		tbl_BooksIssued.member_id = tbl_Members.id
		join tbl_MembershipType on
		tbl_Members.membership_id = tbl_MembershipType.id
	where DATEDIFF(day,date_issued,date_returned) > day_length
)

-- Use records from CTE to insert into overdue table with a rate of .30/day
insert into tbl_Overdue(issued_id,member_id,days_overdue,total_charge)
select cte_BooksIssuedId,
	cte_MemberId, 
	cte_DaysIssued - cte_Membershiplength as [Days Overdue],
	(cte_DaysIssued - cte_Membershiplength) * .30
	from cte_DaysIssued;

-- Statement to use in SSIS
select	tbl_BooksIssued.id as [ID],
		book_id as [Book ID],
		tbl_BooksIssued.member_id as [Member ID],
		date_issued as [Date Issued],
		date_returned as [Date Returned],
		days_overdue as [Days Overdue],
		total_charge as [Total Charge]
	from tbl_BooksIssued
	left join tbl_Overdue on
	tbl_BooksIssued.id = tbl_Overdue.issued_id;
GO