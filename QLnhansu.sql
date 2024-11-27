create database QUANLYnhansu
use QUANLYnhansu

create table nhanvien
(honv nvarchar(10) ,
tenlot nvarchar(10) ,
tennv nvarchar(10) ,
phai bit ,
luong float ,
manv nvarchar(10) primary key references phancong(manv),
maNQL nvarchar(10),
ngaysinh date ,
diachi nvarchar(20) ,
PHG float )

create table dean 
(tenda nvarchar(20) primary key,
mada nvarchar(10) ,
diadiem_da nvarchar(20) ,
PHG float )

create table phongban 
(PHG float primary key ,
tenPHG nvarchar(20) )

create table phancong
(manv nvarchar(10) primary key ,
mada nvarchar(10) ,
sogio real )


--tao rang buoc 
alter table nhanvien
add constraint namnu default(N'nam')  for phai

alter table nhanvien
add constraint ng_sinh check ((CONVERT(INT,year(ngaysinh))+18)<=year(getdate()))

--Tạo 1 rule có tên là rule_luong cho phép chứa giá trị lớn hơn 0, rồi gắn nó vào cột Luong trong bảng Nhanvien.
create rule rule_luong as @value > 0
EXEC sp_bindrule 'rule_luong','nhanvien.luong'

alter table dean
add constraint dia_chi default N'(Tp.Hồ Chí Minh)' for diadiem_da

--rang buoc khoa ngoai
alter table nhanvien add CONSTRAINT fk01 FOREIGN KEY(phg) REFERENCES phongban(phg)
on delete cascade on update cascade

alter table dean add CONSTRAINT fk02 FOREIGN KEY(phg) REFERENCES phongban(phg)
on delete cascade on update cascade
--nhap du lieu vao cac bang

insert into nhanvien values(N'Lê',N'Công',N'Nhân',1,4500000,1,10,'1983/4/23',N'Gia Lai',1)
insert into nhanvien values(N'Trần',N'Công',N'Thức',1,7000000,2,10,'1980/8/17',N'Hòa Bình',2)
insert into nhanvien values(N'Minh',N'Văn',N'Uông',0,8500000,3,7,'2000/9/21',N'Cà Mau',3)
insert into nhanvien values(N'Ba',N'Nguyên',N'Văn',0,8500000,4,2,'1993/1/21',N'Hà Nội',4)
insert into nhanvien values(N'Đặng',N'An',N'Cầu',1,12000000,5,9,'1983/4/23',N'Đà Nẵng',5)
insert into nhanvien values(N'Lê',N'Minh',N'Tâm',1,1200000,6,9,'1991/6/13',N'Đà Nẵng',6)
insert into nhanvien(honv,tenlot,tennv,phai,luong,manv,maNQL,diachi,PHG)
values
(N'Nguyễn',N'Phan',N'Mẫn',1,90000000,7,2,N'Quảng Bình',7)
insert into nhanvien values(N'An',N'Văn',N'Thảo',0,1200000,8,9,'1998/6/21',N'Đà Nẵng',7,N'trưởng phòng',null,N'An')
insert into nhanvien values(N'Phan',N'Thị',N'Đào',0,87300,9,1,'1998/2/8',N'Vĩnh Long',7,N'nhân viên quèn',N'Trần Hòa',null)
insert into nhanvien values(N'Ân',N'Thiên',N'Xồi',0,60000,10,6,'2000/4/5',N'Bình Phước',7,N'trưởng phòng',null,null)

select *from nhanvien
delete from nhanvien

insert into dean values(N'Ăn uống',1,N'Quy Nhơn',1)
insert into dean values(N'Tự động hóa',2,N'Tp.Hồ Chí Minh',2)
insert into dean values(N'Nhà cao ốc',3,N'Bình thuận',3)
insert into dean values(N'Hồ bơi',4,N'Nha Trang',4)
insert into dean values(N'Nghỉ dưỡng',5,N'Hà Nội',5)

select *from dean
delete from dean

insert into phongban values(1,N'kế toán')
insert into phongban values(2,N'nghiên cứu')
insert into phongban values(3,N'kế toán')
insert into phongban values(4,N'kỹ thuật')
insert into phongban values(5,N'nhân sự')
insert into phongban values(6,N'kỹ thuật')
insert into phongban values(7,N'nghiên cứu')

select *from phongban
delete from phongban

insert into phancong values(1,1,20.0)
insert into phancong values(2,2,450.0)
insert into phancong values(3,3,11.0)
insert into phancong values(4,4,230.0)
insert into phancong values(5,5,50.32)
insert into phancong values(6,6,30.59)
insert into phancong values(7,2,80.9)
insert into phancong values(8,3,11.9)
insert into phancong values(9,4,87)
insert into phancong values(10,1,340.1)

select*from phancong

--TRUY VAN DU LIEU 
--1.	Cập nhật địa chỉ cho các nhân viên có địa chỉ =null là Tp.Hồ Chí Minh trong table Nhanvien
update nhanvien
set diachi=case when diachi is null then N'Tp.Hồ Chí Minh' end 

--2.	 Cập nhật PHG =2 cho những nhân viên có mã số từ 1 đến 10; 
--PHG=6 cho các nhân viên có mã số từ 11 đến 40, 
--PHG=7 cho các nhân viên có mã số từ 41 đến 80, PHG =5 cho các nhân viên có mã số từ 102 đến 200.
update dean 
set phg=case 
when 1<=mada and mada<=10  then 2 
when 11<=mada and mada<=40  then 6
when 41<=mada and mada<=80  then 7 
when 102<=mada and mada<=200  then 5 
end from dean
SELECT*FROM dean


--3.	 Cập nhật ngày sinh cho những nhân viên có ngày sinh = null (is null) 
--là ngày 01/01/1985 trong table Nhanvien.
UPDATE nhanvien 
SET ngaysinh = '1985/1/1'
where ngaysinh is null 

SELECT *FROM nhanvien

--4.Cập nhật LUONG =100000 cho các nhân viên ở phòng NghienCuu, 
--LUONG =65000 cho các nhân viên ở phòng Kế toán,
--LU0NG=85000 cho các nhân viên ở phòng Kỹ thuật, LUONG = 70000 cho các nhân viên ở phòng nhân sự.
update nhanvien 
set luong=case
when tenphg like N'%nghiên cứu%' then 100000
when tenphg like N'%kế toán%' then 65000
when tenphg like N'%kỹ thuật%' then 85000
else 70000
end 
from phongban
where nhanvien.PHG=phongban.PHG

SELECT *FROM nhanvien
SELECT *FROM phongban
--5.	 Cập nhật mã người quản lý (MA_NQL) trong bảng nhân viên tương ứng với phòng ban mà nhân viên đó thuộc về.
--VD: nhân viên có mã nv =8, thuộc phòng ban 2 thì mã người quản lý là 10.
update nhanvien
set maNQL = manv +PHG 

select *from nhanvien 

--7.Hiển thị thông tin của những nhân viên ở phòng số 5
select *from nhanvien
where phg=5

--8.	Hiển thị mã nhân viên, họ nhân viên, tên lót và tên nhân viên của những nhân viên 
--ở phòng số 5 và có lương >= 3000
select manv,honv,tenlot,tennv
from nhanvien
where phg=5
and luong>=3000
--9.	Hiển thị mã nhân viên, tên nhân viên của những nhân viên có lương từ 20000 đến 80000
select manv,honv,tenlot,tennv,CONCAT_WS(' ',honv,tenlot,tennv) as HOVATEN
from nhanvien
where luong between 20000 and 80000  

select *from nhanvien
--10.	Hiển thị thông tin của những nhân viên ở địa chỉ có tên đường là Nguyễn
select * from nhanvien where diachi like N'%Nguyễn'

--11.	Cho biết số lượng nhân viên
select count(manv) as N'tổng nhân viên'
from nhanvien

--12.	Cho biết số lượng nhân viên mỗi NQL đang quản 
select maNQL,count(manv) as soluong
from nhanvien
group by maNQL

--13.	 Hiển thị thông tin về mã nhân viên, tên nhân viên và tên phòng ban ở phòng kế toán
select manv,tennv,phongban.PHG
from nhanvien,phongban
where tenPHG like N'kế toán'
and nhanvien.PHG=phongban.PHG	
--14.	Cho biết danh sách các đề án (MADA) có: nhân công với họ (HONV) là 'Lê' 
--hoặc có người trưởng phòng chủ trì đề án với họ (HONV) là 'Lê'.
select mada
from nhanvien,phongban,dean
where nhanvien.phg=phongban.phg
and phongban.phg=dean.PHG
and honv like N'%Lê%'

--15.	 Danh sách những nhân viên (HONV, TENLOT, TENNV) có  >=2 nguoi quan ly .
--1 nguoi quan ly đi quanly 2 nguoi khac nhau -----
select honv,tenlot,tennv
from nhanvien
group by honv,tenlot,tennv
having count(distinct manql)>=2

--thêm cột TRUONGPHONG và THANNHAN vào bảng NHANVIEN 
alter table nhanvien
add chucvi nvarchar(20), tenTN_NV NVARCHAR(20) , tenTN_TP NVARCHAR(20)


--16.	 Danh sách những nhân viên (HONV, TENLOT, TENNV) không có thân nhân nào (dùng NOT IN, LEFT JOIN, NOT EXISTS)
SELECT HONV, TENLOT, TENNV
FROM NHANVIEN
WHERE tenTN_NV not IN (SELECT tentn_nv FROM nhanvien )

select *from nhanvien
--17.	 Danh sách những trưởng phòng (HONV, TENLOT, TENNV) có tối thiểu một thân nhân.
--nhan vien cos chuc TP va tentn_tp cos 2 nguoi (nhap du lieu)
select HONV, TENLOT, TENNV 
from nhanvien 
WHERE CHUCVI LIKE N'%trưởng phòng%'
group by HONV, TENLOT, TENNV 
having count(tentn_tp) = 1 
--INSERT INTO TenNguoi (Ten, Ho) VALUES ('Nguyễn', 'Văn'), ('A', 'Nguyễn');
--Lệnh này sẽ chèn tên “Nguyễn” vào cột Ten và họ “Văn” vào cột Ho của 
--hàng đầu tiên và tên “A” vào cột Ten
--và họ “Nguyễn” vào cột Ho của hàng thứ hai của bảng TenNguoi. Hy vọng giúp bạn! 😊

--18.	 Tìm họ (HONV) của những trưởng phòng chưa có gia đình.
SELECT N.HONV FROM NHANVIEN N WHERE N.tenTN_TP NOT IN
(SELECT N.tenTN_TP FROM NHANVIEN N WHERE CHUCVI LIKE N'%trưởng phòng%' GROUP BY N.tenTN_TP)
--19.	 Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng "Nhân sự"
SELECT top 1 NV.HONV, NV.TENLOT, NV.TENNV,CONVERT(INT,AVG(LUONG))
FROM NHANVIEN NV , PHONGBAN PB 
WHERE NV.PHG = PB.PHG
AND PB.tenPHG LIKE N'%nhân sự%'
order by CONVERT(INT,AVG(LUONG)) desc 

select *from phongban 
--tinh luong trung binh cua phong NHANSU
(SELECT CONVERT(INT,AVG(LUONG)) FROM NHANVIEN NV,phongban
PB WHERE NV.PHG = PB.PHG)

SELECT *FROM nhanvien
SELECT *FROM phongban

--20.	 Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất.
--manv -- phg -- chucvu -- count(manv)
--21.	 Cho biết danh sách các mã đề án mà nhân viên có mã là 60 chưa làm......
--22.	 Danh sách nhân viên gồm MaNv, HovaTen (được nối từ các cột HONV, TENLOT, TENNV) và địa chỉ (DCHI) của những nhân viên làm việc cho một đề án ở 'TP HCM' nhưng phòng ban mà họ trực thuộc lại không tọa lạc ở thành phố 'TP HCM'
--23.	Viết truy vấn liệt kê tên các nhân viên cùng với các dự án mà nhân viên đó tham gia. Run và kiểm tra kết quả.


--27.	 Viết truy vấn hiển thị HoTen của nhân viên, tên dự án nhân viên đó tham gia cùng
--với tổng tiền lương của nhân viên theo dự án (tiền lương = số giờ * LUONG).
--Sắp xếp tiền lương tăng dần. Sau đó, thực hiện các yêu cầu sau:
select concat_ws(' ',honv,tenlot,tennv) ,tenphg, sogio*luong as N'tiền lương' 
from nhanvien , phancong , phongban
where nhanvien.manv=phancong.manv
and phongban.phg=nhanvien.phg
order by sogio*luong asc
--a.	 Tạo một View5a dựa trên query này. Bạn sẽ gặp lỗi, tại sao?
create view view5a as
select concat_ws(' ',honv,tenlot,tennv) ,tenphg, sogio*luong as N'tiền lương' 
from nhanvien , phancong , phongban
where nhanvien.manv=phancong.manv
and phongban.phg=nhanvien.phg
order by sogio*luong asc  
-- gặp lỗi vì mệnh đề ORDER BY không được sử dụng để định nghĩa view 

--b.	 Hãy hiệu chỉnh để có thể tạo được View5b dựa trên query trên.
CREATE VIEW view5b (fullname,tenphg,salary) AS 
SELECT concat_ws(' ',honv,tenlot,tennv)AS fullame ,tenphg, sogio*luong AS salary
FROM nhanvien , phancong , phongban
WHERE nhanvien.manv=phancong.manv AND phongban.phg=nhanvien.phg 

select *from view5b
--28.	Tạo View6 gồm các thông tin của bảng DEAN nhưng chỉ lấy các dự án có địa điểm ở Tp.HCM.
create view view6 (mada,tenda,diadiem_da,phg) as
select mada,tenda,diadiem_da,phg
from dean 
where diadiem_da like N'%Hồ Chí Minh'
--a.Sửa câu View6 thành View6a có thêm tùy chọn WITH ENCRYPTION. Sử dụng sp_helptext để xem lại mã lệnh.
--Có xem được không?
create view view6a (mada,tenda,diadiem_da,phg) as
select mada,tenda,diadiem_da,phg
from dean 

ALTER VIEW view6a WITH ENCRYPTION as
select mada,tenda,diadiem_da,phg FROM view6

EXEC sp_helptext view6a
-- không xem được mã lệnh của view khi sử dụng sp_helptext vì đã thiết lập WITH ENCRYPTION. 

--b. Sửa câu View6 thành View6b có thêm tùy chọn WITH SCHEMABINDING.
create view view6b (mada,tenda,diadiem_da) as
select mada,tenda,diadiem_da
from dean 

ALTER VIEW view6b  WITH SCHEMABINDING as
select  mada,tenda,diadiem_da,phg FROM view6 

--Bạn cần hiệu chỉnh điều gì để có thể thực thi được view.
--c.Sửa câu View6 thành View6c có thêm tùy chọn WITH CHECK OPTION.
create view view6c (mada,tenda,diadiem_da,phg) as
select mada,tenda,diadiem_da,phg
from dean 

ALTER VIEW view6c as
select  mada,tenda,diadiem_da,phg 
FROM view6 WITH CHECK OPTION

--Sau đó thêm một dòng dữ liệu sau thông qua View6c:
INSERT View6c
VALUES('99',N'Xây dựng đường',N'Đồng Nai','5')

--Bạn có thêm được không, tại sao?
ko thêm được vì dạng xem chỉ định WITH CHECK OPTION hoặc mở rộng dạng xem chỉ định WITH CHECK OPTION 
và một hoặc nhiều hàng do thao tác không đủ điều kiện theo ràng buộc WITH CHECK OPTION.

--Sửa lại dữ liệu để có thể thêm được thông qua View6c.
update view6c
SET tenda=N'Xây dựng đường biển'
--d.	 Xóa dữ liệu vừa thêm ở câu c thông qua View6c.
delete from view6c
where tenda like N'%Xây dựng đường biển%'

