# Library Management System

## Project Description

This project was implemented for learning purposes. I wanted to understand/implement different features offered by Sql Server, such as creating Stored Procedures, Views, and writing complex query statements used for data analysis. The data used for the application was taken from kaggle.com, as well as randomly generated data using Microsoft Excel. Integration services was used to load data from excel/flat files into a normalized database, and from the database into a data warehouse using a tabular model. Each table from the tabular model was then loaded into Power Bi for report building.

## Technologies Used

* SQL(T-SQL)
* Sql Server Management Studio - 2016
* Visual Studio W/SSDT - 2017
* Microsoft Excel
* MS Integration Services
* MS Analysis Services
* Power Bi

## Features

List of features ready and TODOs for future development
* Data visualization and interactive reports in Power Bi.
* Complex queries used to create views and data analysis, such as the conversion rate for overdue books.
* Implemented stored procedures and views using Sql Server.
* Integration Services that perform different techniques for incremental loading.
* Microsoft Excel used to generate random data.
* Wrote Dax Expressions to created calculated columns and measures.

To-do list:
* Learn and implement more queries that provide insight for data analysis.
* Perform further data cleaning.
* Implement the tuning advisor further.
* Possibly implement indexes.
* Omit the member id column from overdue table.

## Getting Started
   
* Ensure that you have the following services installed:
> Visual Studio w/SSDT 2017.
> At least one instance of Sql Server Management Studio 2016 w/ Integration Services and Analysis Services.
> Power BI Desktop

* Using the command prompt, navigate to the directory that you want to clone your repository in, and use the following command:

> git clone https://github.com/Robo-91/library_management_system.git

* Locate the Library_App_DB and Library_App_DW bak files (Data Files -> Database Backups) and restore:
https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/restore-a-database-backup-using-ssms?view=sql-server-ver15
>An example would be: C:\Program Files\Microsoft SQL Server\MSSQL13.servername\MSSQL\Backup

*From the same Database Backups folder, locate the LibraryDW_Tabular.abf file and restore using the following steps:
 https://docs.microsoft.com/en-us/analysis-services/multidimensional-models/backup-and-restore-of-analysis-services-databases?view=asallproducts-allversions
>An example would be:  C:\Program Files\Microsoft SQL Server\MSAS13.servername\OLAP\Backup

* Ensure that the .pbix file is connected to your analysis services.

## Usage

> Locate the reports (Library_Reports.pbix). You can interact with the visualizations by clicking on values. the visuals interact with other visuals on the page by filtering out values.

## License

This project uses the following license: [GNU](https://www.gnu.org/licenses/gpl-3.0.en.html).