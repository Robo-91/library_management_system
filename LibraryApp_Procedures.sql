-- Procedure to search books by title
create procedure proc_SearchBook
(
	@title varchar(30)
)
as
begin
	select	title as [Book Title],
			author_name as [Author],
			num_pages as [Pages],
			isbn as [ISBN],
			average_rating as [Rating]
			from tbl_Books
				join tbl_Authors
				on tbl_Books.author_id = tbl_Authors.id 
			where title like '%' + @title + '%';
end
go

-- Procedure to search Authors
create procedure proc_SearchAuthor
(
	@AuthorName varchar(30)
)
as
begin
	select	author_name as [Author Name],
			title as [Book Title],
			isbn as [ISBN]
			from tbl_Authors
				join tbl_Books on 
				tbl_Authors.id = tbl_Books.author_id
			where author_name like '%' + @AuthorName + '%'
end
go

-- Procedure for CRUD operations - Members
create procedure proc_Member
(
	@Action varchar(10),
	@FirstName varchar(20),
	@Lastname varchar(20),
	@Membership int
)
as
begin
	if @Action = 'new'
		begin
			insert into tbl_Members(first_name,last_name,membership_id)
			values(@FirstName,@Lastname,@Membership)
		end
	else if @Action = 'delete'
		begin
			delete from tbl_Members where first_name = @FirstName
				 and last_name = @Lastname
				 and membership_id = @Membership
		end
	else
		begin
			print 'Cannot perform specified operation'
		end
end
go

-- Procedure for checking out a book

-- Procedure for returning a book

-- Procedure for Accumulating a fine

-- Procedure for CRUD operations - Book

-- Procedure for CRUD operations - Author
