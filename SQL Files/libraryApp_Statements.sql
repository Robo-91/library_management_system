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

-- Data Cleaning
-- Remove trailing , from publisher
select distinct right(publisher,1) from tbl_Books

update tbl_Books
set publisher = REPLACE(publisher,right(publisher,1),'') from tbl_Books
GO

-- Analytics
-- Conversion Rate of Members who returned books on time / Overdue
with cte_DaysIssued(cte_Id,cte_MemberId,cte_DaysIssued,cte_Membershiplength,cte_OverdueDays)
as
(
	select tbl_BooksIssued.id as [ID],
	tbl_BooksIssued.member_id as [Member ID],
	DATEDIFF(day,date_issued,date_returned) as [Days Issued],
	day_length as [Membership Length],
	case when DATEDIFF(day,date_issued,date_returned) - day_length < 0 then 0
		 else DATEDIFF(day,date_issued,date_returned) - day_length end as [Days Overdue]
		from tbl_BooksIssued
		join tbl_Members on
		tbl_BooksIssued.member_id = tbl_Members.id
		join tbl_MembershipType on
		tbl_Members.membership_id = tbl_MembershipType.id
)

select
		count(distinct case when cte_OverdueDays > 0 then cte_Id else NULL end) as [Books Returned On Time],
		count(distinct case when cte_OverdueDays = 0 then cte_Id else NULL end) as [Books Overdue],
		cast(count(distinct case when cte_OverdueDays = 0 then cte_Id else NULL end)
			/cast(count(distinct case when cte_OverdueDays > 0 then cte_Id else NULL end) as decimal(10,2)) as decimal(5,4)) as [Conversion Rate]
	from cte_DaysIssued
GO

-- Issues by month for the year 2019
select 
		DATENAME(MONTH,date_issued) as [Month],
		count(id) as [Total Issues]
	from tbl_BooksIssued
			where year(date_issued) = 2019
		group by DATENAME(month,date_issued),month(date_issued)
GO