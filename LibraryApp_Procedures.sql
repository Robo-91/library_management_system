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
create procedure proc_Checkout
(
	@IsbnNumber varchar(20),
	@Member_id int
)
as
begin
	begin try
		declare @BookId int = (select id from tbl_Books
		where isbn = @IsbnNumber)
		if @BookId is null
			begin
				print 'Book with specified isbn not found'
			end
		else
			begin
				insert into tbl_BooksIssued(book_id,member_id,date_issued,date_returned)
				values(@BookId,@Member_id,getdate(),null)
			end
	end try
	begin catch
		print 'Unable to Checkout book'
	end catch
end
go

-- Procedure for returning a book
create procedure proc_ReturnBook
(
	@BookId int,
	@MemberId int
)
as
begin
	begin try
		if @BookId is null OR @MemberId is null
			begin
				print 'Please insert both the Book and Member Ids'
			end
		else
			begin
				update tbl_BooksIssued set date_returned = getdate()
				where id = (select id from tbl_BooksIssued where book_id = @BookId and member_id = @MemberId and date_returned is null)
			end
	end try
	begin catch
		Print 'Unable to return book'
	end catch
end
go

-- Procedure to create new Book
create procedure proc_Book
(
	@BookTitle varchar(50),
	@AuthorID int,
	@AvgRating decimal(4,2),
	@isbn varchar(20),
	@isbn13 varchar(20),
	@Pages int,
	@RtgCount int,
	@txtRvwCount int,
	@PubDate date,
	@Publisher varchar(255)
)
as
begin
	declare @NewBookId int = (select top 1 id from tbl_Books
		order by id desc) + 1
	declare @BookExists int =
		(select count(*) from tbl_Books
		where title like '%' + @BookTitle + '%')
	if @BookExists <> 0
		begin
			Print 'A record already exists that contains specified title'
		end
	else
		begin
			insert into tbl_Books(id,title,author_id,average_rating,isbn,isbn13,num_pages,
			ratings_count,text_reviews_count,publication_date,publisher)
			values
			(@NewBookId,@BookTitle,@AuthorID,@AvgRating,@isbn,@isbn13,@Pages,@RtgCount,@txtRvwCount,
			@PubDate,@Publisher)
		end
end
go

-- Procedure to create new Author
create procedure proc_Author
(
	@AuthorName varchar(50)
)
as
begin
	declare @Results int = 
		(select count(*) from tbl_Authors 
		 where author_name like '%' + @AuthorName + '%')

	if @Results <> 0
		begin
			Print 'A record that contains that name already exists'
		end
	else
		begin
			insert into tbl_Authors(author_name)
			values(@AuthorName)
		end
end
go