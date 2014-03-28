

Insert into Person (PersonID,FirstName,SirName)
values (1, 'George','Gay')
Insert into Person (PersonID,FirstName,SirName)
values (0, 'George','Gay')
Insert into Person (PersonID,FirstName,SirName)
values (2, 'George','Gay')
Insert into Person (PersonID,FirstName,SirName)
values (3, 'George','Gay')

insert into Post (PostID,LoanDate,PaymentDate,PersonID,Amount)
values (0, '10-11-2013','11-11-2013',1,200)
insert into Post (PostID,LoanDate,PaymentDate,PersonID,Amount)
values (3, '11-11-2013','11-11-2013',1,300)
select * from PersonSb
select * from Post
select *from skylder
delete from Person
where PersonID=1
delete from Post
delete from Post
where PersonID = 1 and LoanDate='11-11-2013'

