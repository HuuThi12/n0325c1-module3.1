create database quanlydoibong;
use quanlydoibong;

create table doi(
	id_doi int auto_increment primary key,
    ten_doi varchar(50) not null,
    hlv_id int not null,
    foreign key (hlv_id) references huanluyenvien(id_hlv)
);

create table cauthu(
	id_cau_thu int auto_increment primary key,
    ten_cau_thu varchar(50) not null,
    ngay_sinh date not null,
    dia_chi varchar(50),
    doi_id int not null,
    tran_dau_id int not null,
    foreign key (doi_id) references doi(id_doi),
    foreign key (tran_dau_id) references trandau(id_tran_dau)
);

create table cauthu_vitri(
	id_vi_tri int auto_increment primary key,
    ten_vi_tri varchar(50) not null,
    cau_thu_id int not null,
    foreign key (cau_thu_id) references cauthu(id_cau_thu)
);

create table trandau(
	id_tran_dau int auto_increment primary key,
    ngay_gio_dau timestamp -- '2025-01-01 00:00:01'
);

create table huanluyenvien(
	id_hlv int auto_increment primary key,
    ten_hlv varchar(50) not null,
    ngay_sinh date not null,
    dia_chi varchar(50)
);






