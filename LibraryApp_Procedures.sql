-- Procedure to search books by title
alter procedure proc_SearchBook
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

exec proc_SearchBook 'Ubik';