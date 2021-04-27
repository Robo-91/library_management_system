-- Trigger that inserts into BookLog book checked out
create trigger tr_Checkout
on tbl_BooksIssued
for insert
as
begin
	declare @MemberName varchar(30)

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