create database quanlydoibong;
use quanlydoibong;
drop database quanlydoibong;


-- 1
create table huanluyenvien(
	id_hlv int auto_increment primary key,
    ten_hlv varchar(50) not null,
    ngay_sinh date not null,
    dia_chi varchar(50)
);

-- 2
create table doi(
	id_doi int auto_increment primary key,
    ten_doi varchar(50) not null,
    hlv_id int not null,
    foreign key (hlv_id) references huanluyenvien(id_hlv)
);

-- 3
create table cauthu(
	id_cau_thu int auto_increment primary key,
    ten_cau_thu varchar(50) not null,
    ngay_sinh date not null,
    dia_chi varchar(50),
    doi_id int ,
    foreign key (doi_id) references doi(id_doi)
);

-- 4
create table vitri(
	id_vi_tri int auto_increment primary key,
    vi_tri varchar(255) not null
);

-- 5
create table trandau(
	id_tran_dau int auto_increment primary key,
    ngay_gio_dau timestamp, -- '2025-01-01 00:00:01'
    doi_a int,
    doi_b int,
    foreign key (doi_a) references doi(id_doi),
    foreign key (doi_b) references doi(id_doi),
    check (doi_a!= doi_b) -- đảm bảo 2 đội trong 1 trận không cùng nhau
);

-- 6
create table cauthu_vitri(
    vi_tri_id int ,
    cau_thu_id int,
    primary key (vi_tri_id,cau_thu_id),
    foreign key (cau_thu_id) references cauthu(id_cau_thu),
    foreign key (vi_tri_id) references vitri(id_vi_tri)
);

-- 7
create table trandau_cauthu(
	tran_dau_id int,
    cau_thu_id int,
    primary key (tran_dau_id,cau_thu_id),
    foreign key (tran_dau_id) references trandau(id_tran_dau),
    foreign key (cau_thu_id) references cauthu(id_cau_thu)
);






