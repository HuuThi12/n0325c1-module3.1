create database book_store;
use book_store;
drop database book_store;

create table author(
	id int auto_increment primary key,
    name varchar(50) not null
);

create table book(
	id int auto_increment primary key,
    name varchar(50) not null,
    price double not null,
    id_author int not null,
    foreign key (id_author) references Author(id)
);

create table employee(
	id int auto_increment primary key,
    name varchar(50) not null,
    address text not null
);


create table employee_book(
	id_employee int ,
	id_book int ,
    primary key(id_employee, id_book),
    foreign key (id_employee) references employee(id),
    foreign key (id_book) references book(id)
);

drop table Employee;	
select * from Author,Book,Employee;

