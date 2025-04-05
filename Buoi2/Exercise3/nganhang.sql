create database nganhang;
use nganhang;

create table khachhang(
	id int auto_increment primary key,
    ten varchar(50) 
    
);

create table taikhoan(
	id int auto_increment primary key,
    so_du double not null,
    id_khach_hang int not null,
    foreign key (id_khach_hang) references khachhang(id)
);