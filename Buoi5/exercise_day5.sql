use quan_ly_truong_tieu_hoc;

-- Bài tập ngày 4

-- Câu 1
-- a. Liệt kê những địa chỉ khác nhau trong bảng học_sinh (bằng 2 cách khác nhau)
select distinct dia_chi from hoc_sinh;
select dia_chi  from hoc_sinh group by dia_chi;

-- b. Liệt kê họ_ten_hs, giới_tính của các nhóm được phân nhóm theo họ_ten_hs và giới_tính trong bảng học_sinh.
select ho_ten_hs, gioi_tinh from hoc_sinh group by ho_ten_hs, gioi_tinh;

-- c. Liệt kê họ_ten_hs của các nhóm được phân nhóm theo họ_ten_hs và giới_tính trong bảng học_sinh. 
-- Chú ý thử giải thích vì sao không liệt kê giới_tính mà vẫn không bị lỗi.
select ho_ten_hs from hoc_sinh group by ho_ten_hs, gioi_tinh;

-- d. Liệt kê mã_mh, ten_mh, diem_thi_cuoi_ky của từng môn học chia theo từng mức điểm thi cuối kỳ. 
-- (Gợi ý: chỉ liệt kê những môn đã từng có học sinh thi cuối kỳ).
select mh.ma_mh, ten_mh, kq.diem_thi_cuoi_ky
from ket_qua_hoc_tap kq join mon_hoc mh on kq.ma_mh = mh.ma_mh
group by ma_mh, ten_mh, diem_thi_cuoi_ky
having kq.diem_thi_cuoi_ky is not null;

select kq.ma_mh, ten_mh, kq.diem_thi_cuoi_ky
from ket_qua_hoc_tap kq join mon_hoc mh on kq.ma_mh = mh.ma_mh
where diem_thi_cuoi_ky is not null
group by ma_mh, ten_mh, diem_thi_cuoi_ky;

-- e. Liệt kê mã_gv, ten_gv của những giáo viên đã từng được phân công phụ trách ít nhất 1 môn học. 
-- Nếu mã_gv, ten_gv trùng lặp nhiều lần thì chỉ hiển thị 1 lần trong kết quả trả về.
select distinct gv.ma_gv, gv.ho_ten_gv, pt.ma_gvpt
from giao_vien gv
join  phu_trach_bo_mon pt on gv.ma_gv = pt.ma_gvpt;

-- f. Liệt kê tháng và năm của những học sinh tham gia thi cuối kỳ (đã có điểm thi_cuoi_ky rồi).
select  kq.ma_hs, hs.ho_ten_hs, kq.diem_thi_cuoi_ky, kq.ngay_gio_thi_cuoi_ky
from ket_qua_hoc_tap kq
join hoc_sinh hs on hs.ma_hs = kq.ma_hs;


-- g. Liệt kê họ tên của những học sinh có địa chỉ ở Hải Châu và từng thi (giữa kỳ hoặc cuối kỳ) ít nhất 1 lần. 
-- Nếu họ tên trùng lặp thì chỉ hiển thị 1 lần trong kết quả trả về. Yêu cầu: Không dùng từ khóa DISTINCT.
select hs.ho_ten_hs
from hoc_sinh hs 
join ket_qua_hoc_tap kq on hs.ma_hs = kq.ma_hs
where hs.dia_chi like '%Hải Châu%' and kq.diem_thi_giua_ky is not null or kq.diem_thi_cuoi_ky is not null
group by hs.ho_ten_hs;

-- Câu 2: Luyện tập về Hàm gộp + GROUP BY nâng cao

-- Hãy liệt kê:
-- a. Liệt kê ho_ten_hs, gioi_tinh, dia_chi của các nhóm được phân nhóm theo ho_ten_hs và gioi_tinh trong bảng hoc_sinh. 
-- Thử suy nghĩ về nguyên nhân lỗi nếu có lỗi xảy ra (*)
select ho_ten_hs, gioi_tinh, MAX(dia_chi) AS dia_chi
from hoc_sinh
group by ho_ten_hs, gioi_tinh;

-- b. Đếm số lượng học sinh là nam.
select count(*) AS soLuongNam
from hoc_sinh
where gioi_tinh = 'Nam';

-- c. Đếm số lượng học sinh trong lớp có tên là Lớp 1A và lớp đó nằm trong năm học 2022–2023.
select hs.ho_ten_hs as ho_ten, count(l.ten_lop) AS soLuongHocSinh
from hoc_sinh hs
join lop l on l.ma_lop = hs.ma_lop
where ten_lop = 'Lớp 1A' and nam_hoc ='2022–2023'
group by ho_ten_hs;

-- d. Đếm số lớp đã phụ trách (có thể là 1 hoặc nhiều môn nào đó) của từng giáo viên.
-- e. Đếm những môn học đã từng có học sinh thi giữa kỳ được 9 điểm trở lên.
-- (*) Gợi ý: làm theo 2 cách, 1 là dùng WHERE, 2 là dùng HAVING.
-- f. Đếm xem tương ứng với mỗi địa chỉ (của học sinh), số lượng học sinh đang ở mỗi địa chỉ là bao nhiêu em.
-- g. Liệt kê điểm thi cao nhất của từng môn học (dựa vào điểm thi cuối kỳ mà các học sinh đã từng thi).
-- h. Liệt kê điểm thi trung bình của từng môn học (dựa vào điểm thi cuối kỳ mà các học sinh đã từng thi).
-- i. Liệt kê những môn học có điểm thi trung bình cao nhất (dựa vào điểm thi cuối kỳ mà các học sinh đã từng thi).
-- Gợi ý: có trường hợp nhiều hơn 1 môn học có điểm thi trung bình cao nhất. (**)


-- Câu 3: Luyện tập về subquery
-- a. Học sinh chưa từng thi môn nào
select ho_ten_hs
from hoc_sinh
where ma_hs not in ( select distinct ma_hs from ket_qua_hoc_tap);

-- b. Giáo viên chưa từng phụ trách môn nào
select ho_ten_gv
from giao_vien
where ma_gv not in ( select distinct ma_gvpt from phu_trach_bo_mon);

-- c. Giáo viên chưa từng chủ nhiệm môn nào
select ho_ten_gv
from giao_vien
where ma_gv not in ( select distinct ma_gvcn from lop);

-- d. Môn học chưa từng được tổ chức thi lần nào 
select ten_mh
from mon_hoc
where ma_mh not in ( select distinct ma_mh from ket_qua_hoc_tap);

select *
from ket_qua_hoc_tap kq
join mon_hoc mh on kq.ma_mh = mh.ma_mh;

-- Câu 4: Luyện tập về UNION
-- a. Học sinh nam ở Thanh Khê và học sinh nữ ở Hải Châu
select ho_ten_hs, gioi_tinh, dia_chi from hoc_sinh where gioi_tinh = 'Nam' and dia_chi like "%Thanh Khê%"
union 
select ho_ten_hs, gioi_tinh, dia_chi from hoc_sinh where gioi_tinh = "Nữ" and dia_chi like "%Hải Châu%";

-- b. Họ tên của học sinh và giáo viên trong toàn trường
select ho_ten_hs as ho_ten, null as ho_ten_gv from hoc_sinh
union
select null as ho_ten, ho_ten_gv from giao_vien;

-- c. Họ tên, nghề nghiệp của học sinh và giáo viên trong toàn trường. (Nghề nghiệp bao gồm: học sinh hoặc giáo viên)
select ho_ten_hs as ho_ten, 'Học sinh' as nghe_nghiep from hoc_sinh
union
select ho_ten_gv as ho_ten, 'Giáo viên' as nghe_nghiep from giao_vien;

-- d. Những học sinh đang học ở năm học 2019-2020 và những học sinh chưa từng thi môn Toán và môn Tiếng Việt
select distinct hs.ma_hs, hs.ho_ten_hs, hs.dia_chi
from hoc_sinh hs
join lop l on l.ma_lop = hs.ma_lop
left join ket_qua_hoc_tap kq on kq.ma_hs = hs.ma_hs
where l.nam_hoc = '2019-2020'
and (kq.ma_mh is null or (kq.ma_mh not in ('Toán', 'Tiếng Việt')));

-- Câu 5: Luyện tập về LEFT JOIN
-- a. ma_lop, ten_lop, ma_gvcn, ho_ten_gv (chủ nhiệm) của tất cả các lớp trong trường.
-- (Gợi ý: tất cả các lớp nghĩa là kể cả những lớp chưa được phân công GVCN).
select ma_lop, ten_lop, ma_gvcn, ho_ten_gv
from lop l
left join giao_vien gv on gv.ma_gv = l.ma_gvcn;

-- b. ma_hs, ho_ten_hs, hoc_ky, ma_mh, ten_mh, diem_thi_giua_ky, diem_thi_cuoi_ky của tất cả học sinh trong trường.
select hs.ma_hs, ho_ten_hs, hoc_ky, mh.ma_mh, ten_mh, diem_thi_giua_ky, diem_thi_cuoi_ky
from hoc_sinh hs
left join ket_qua_hoc_tap kq on hs.ma_hs = kq.ma_hs 
left join mon_hoc mh on mh.ma_mh = kq.ma_mh;

-- c. ma_hs, ho_ten_hs, ma_lop, ten_lop, ma_gvcn, ho_ten_gv (chủ nhiệm) của tất cả học sinh trong trường.
-- (Chú ý những trường hợp: học sinh chưa được phân lớp và lớp chưa được phân GVCN).
select ma_hs, ho_ten_hs, l.ma_lop, ten_lop, ma_gvcn, ho_ten_gv
from hoc_sinh hs
left join lop l on l.ma_lop = hs.ma_lop
left join giao_vien gv on gv.ma_gv = l.ma_gvcn;

-- d. ma_gv, ho_ten_gv, ma_lop, ten_lop, hoc_ky, ma_mh, ten_mh của tất cả giáo viên trong trường.
select ma_gv, ho_ten_gv, l.ma_lop, ten_lop, hoc_ky, pt.ma_mh, ten_mh
from giao_vien gv
left join lop l on gv.ma_gv = l.ma_gvcn
left join phu_trach_bo_mon pt on pt.ma_gvpt = gv.ma_gv
left join mon_hoc mh on mh.ma_mh = pt.ma_mh;


-- Câu 7: Luyện tập về FULL JOIN
-- a. ma_hs, ho_ten_hs, ma_lop, ten_lop của tất cả học sinh và tất cả các lớp trong trường. 
-- (Gợi ý: lớp chưa có học sinh và học sinh chưa được phân lớp đều phải được trả về kết quả).
select ma_hs, ho_ten_hs, l.ma_lop, ten_lop
from hoc_sinh hs
left join lop l on hs.ma_lop = l.ma_lop
union
select ma_hs, ho_ten_hs, l.ma_lop, ten_lop
from hoc_sinh hs
right join lop l on hs.ma_lop = l.ma_lop;

-- b. ma_mh, ten_mh, ma_gv (phụ trách), ho_ten_gv (phụ trách) của tất cả những môn học và tất cả giáo viên trong trường.
-- Kết quả trả về cần loại bỏ bớt những dòng trùng lặp (những dòng nào trùng nhau thì chỉ hiển thị kết quả 1 lần).
select mh.ma_mh, ten_mh, ma_gv, ho_ten_gv 
from mon_hoc mh
left join phu_trach_bo_mon pt on pt.ma_mh = mh.ma_mh
left join giao_vien gv on gv.ma_gv = pt.ma_gvpt
union
select mh.ma_mh, ten_mh, ma_gv, ho_ten_gv 
from mon_hoc mh
right join phu_trach_bo_mon pt on pt.ma_mh = mh.ma_mh
right join giao_vien gv on gv.ma_gv = pt.ma_gvpt;

-- Câu 8: Luyện tập về LIMIT
-- a. Lấy danh sách học sinh trong một lớp 1A, sắp xếp theo tên, bắt đầu từ kết quả thứ 11 và lấy 5 kết quả tiếp theo.
select ho_ten_hs
from hoc_sinh hs
where ma_lop = 'L0001'
order by ho_ten_hs
limit 5 offset 10; -- hoặc limit 10, 5

-- b. Lấy thông tin giáo viên phụ trách bộ môn trong Lớp 5A, sắp xếp theo tên môn học và lấy tối đa 5 kết quả, 
-- bắt đầu từ kết quả thứ 6.
select ho_ten_gv, mh.ten_mh
from phu_trach_bo_mon pt
join mon_hoc mh on mh.ma_mh = pt.ma_mh
join giao_vien gv on gv.ma_gv = pt.ma_gvpt
join lop l on l.ma_gvcn = gv.ma_gv
where ten_lop = 'Lớp 5A'
order by mh.ten_mh
limit 5 offset 5; 

-- Câu 9: Luyện tập về EXITS và IN
-- a. Lấy danh sách các học sinh có kết quả thi môn Toán học trong học kỳ 1.
-- cách 1
select ho_ten_hs
from hoc_sinh
where ma_hs in (
	select ma_hs
    from ket_qua_hoc_tap
    where hoc_ky = 'Học kỳ 1'
);

-- cách 2
SELECT ho_ten_hs
FROM hoc_sinh
WHERE EXISTS (
    SELECT 1
    FROM ket_qua_hoc_tap
    WHERE hoc_sinh.ma_hs = ket_qua_hoc_tap.ma_hs
    AND ket_qua_hoc_tap.ma_mh = 'MH001'
    AND ket_qua_hoc_tap.hoc_ky = 'Học kỳ 1'
);


-- b. Lấy danh sách các giáo viên chủ nhiệm có ít nhất một lớp học.
select ho_ten_gv
from giao_vien
where ma_gv in (
	select ma_gvcn
    from lop
    where ma_gvcn is not null
);

-- c. Lấy thông tin các học sinh thuộc lớp 1A hoặc lớp 1B.
select ho_ten_hs
from hoc_sinh
where ma_lop in (
	select ma_lop
    from lop
    where ten_lop = 'Lớp 1A' or ten_lop = 'Lớp 1B'
);

select ho_ten_hs
from hoc_sinh
where ma_lop in ('L0001','L0002');

-- d. Lấy thông tin các học sinh có điểm thi môn Toán học trong học kỳ 1 năm trong danh sách (8.0, 8.5, 9.0)
select ho_ten_hs
from hoc_sinh
where ma_hs in (
	select ma_hs
    from ket_qua_hoc_tap
    where hoc_ky = 'Học kỳ 1' and diem_thi_giua_ky in (8.0, 8.5, 9.0) and diem_thi_cuoi_ky in (8.0, 8.5, 9.0)
);