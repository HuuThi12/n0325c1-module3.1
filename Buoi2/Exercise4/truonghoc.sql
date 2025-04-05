create database truonghoc;
use truonghoc;

create table giaovien(
	id int auto_increment primary key,
    ten varchar(50) 
);

create table hocsinh(
	id int auto_increment primary key,
    ten varchar(50) not null,
    id_giao_vien int not null,
    foreign key (id_giao_vien) references giaovien(id)
);


