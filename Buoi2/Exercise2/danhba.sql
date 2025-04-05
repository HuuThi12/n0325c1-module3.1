create database danhba;
use danhba;
drop database danhba;

create table nguoi(
	id int auto_increment primary key,
    ten varchar(50) not null
);

create table so_dien_thoai(
	id_so_dien_thoai int auto_increment primary key,
	so_dien_thoai varchar(50) not null,
    id_nguoi int not null,
    foreign key (id_nguoi) references nguoi(id)
    
);

create table email(
	id_email int auto_increment primary key,
	dia_chi_email varchar(50) not null,
    id_nguoi int not null,
    foreign key (id_nguoi) references nguoi(id)
);