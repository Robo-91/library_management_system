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

-- Use records from cte to insert into overdue table
insert into tbl_Overdue(member_id,days_overdue)
select cte_MemberId, 
	cte_DaysIssued - cte_Membershiplength as [Days Overdue]
	from cte_DaysIssued;

	select * from tbl_Overdue