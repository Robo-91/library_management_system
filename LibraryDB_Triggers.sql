-- Trigger that inserts into BookLog book checked out
create trigger tr_Checkout
on tbl_BooksIssued
for insert
as
begin
	declare @FirstName varchar(30) = (select first_name from tbl_Members
		join inserted on tbl_Members.id = inserted.member_id)
	declare @LastName varchar(30) = (select last_name from tbl_Members
		join inserted on tbl_Members.id = inserted.member_id)
	declare @BookTitle varchar(50) = (select title from tbl_Books
		join inserted on tbl_Books.id = inserted.book_id)
	declare @CheckoutDate date = (select date_issued from inserted)
	insert into tbl_BookLog(message)
	values(concat(@FirstName,' ',@LastName,' checked out ',@BookTitle,' on ',@CheckoutDate))
end
go

-- Trigger that inserts into BookLog book returned
create trigger tr_Return
on tbl_BooksIssued
for update
as
begin
end
go