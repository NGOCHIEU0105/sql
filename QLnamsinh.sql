create DATABASE QLNS
USE QLNS 

create table danhsachphong
(maphong nvarchar(10)  primary key,
tenphong nvarchar(10) null ,
sodthoai nvarchar(10) null constraint sdt unique )

create table dsachpxuong 
(mapxuong nvarchar(20) primary key ,
tenxuong nvarchar(20) null ,
sodoanvien nvarchar(20) null constraint sdvvv check (sodoanvien>0) )

create table nhanvien 
(manv nvarchar(5) constraint nv_manv primary key ,
holot nvarchar(20)null,
ten nvarchar(20) null ,
ngaysinh datetime constraint ngay_sinh check (22<=ngaysinh and ngaysinh<=45) ,
gioitinh bit null ,
maphong nvarchar (10) foreign key references danhsachphong(maphong) 
on delete cascade on update cascade ,
mapxuong nvarchar(20) foreign key references dsachpxuong(mapxuong) 
on delete cascade on update cascade ,
diachi nvarchar(30) null )

alter table nhanvien
drop constraint ngay_sinh


create table thunhap_nv 
(manv nvarchar(5) primary key references nhanvien(manv)
on delete cascade on update cascade,
luongchinh float(8) null default(1350000) ,
heso smallint null default(2.34) ,
phucap float(8) null ,
thue float(8) null ,
thamnien tinyint null ,
tongluong float(8) null )


insert into danhsachphong values('P1',N'Phòng 1','0352713841')
insert into danhsachphong values('P2',N'Phòng 2','0222710044')
insert into danhsachphong values('P3',N'Phòng 3','0993728129')
insert into danhsachphong values('P4',N'Phòng 4','0718293740')
insert into danhsachphong values('P5',N'Phòng 5','0352391100')
insert into danhsachphong values('P6',N'Phòng 6','2390391190')

DELETE FROM danhsachphong
SELECT *FROM danhsachphong


insert into dsachpxuong values('X1',N'Xưởng 1','1')
insert into dsachpxuong values('X2',N'Xưởng 2','2')
insert into dsachpxuong values('X3',N'Xưởng 3','3')
insert into dsachpxuong values('X4',N'Xưởng 4','4')
insert into dsachpxuong values('X5',N'Xưởng 5','5')
insert into dsachpxuong values('X6',N'Xưởng 6','6')

select *from dsachpxuong
DELETE FROM dsachpxuong

INSERT INTO nhanvien (manv,holot,ten,ngaysinh,maphong,mapxuong)
values 
('NV1',N'Trần',N'Bình','1999/4/3','P1','X1'),
('NV2',N'Trần',N'Hoài Nam','1991/9/13','P2','X2'),
('NV3',N'Nguyễn',N'Nhàn','1983/11/8','P3','X3'),
('NV4',N'Lê',N'Đông','1980/12/8','P4','X4'),
('NV5',N'Nam',N'Tiến','1990/1/11','P5','X5')
INSERT INTO nhanvien (manv,holot,ten,ngaysinh,maphong,mapxuong,diachi)
values
('NV6',N'Phan',N'Văn B','1990/1/11','P5','X2',N'Hà Nội')

select *from nhanvien
delete from nhanvien
--smallint ==0 ---> 65535
--tinyint ==0 ---> 255
insert into thunhap_nv (manv,phucap,thue,thamnien,tongluong)
values 
('NV1','1000000','2','2',2500000),
('NV2','400000','3','8',9200000),
('NV3','250000','3','10',7000000),
('NV4','700000','2','21',8500000),
('NV5','400000','4','9',9000000)

select *from thunhap_nv
delete from thunhap_nv 


--BAI 1 .	Cập nhật cột thâm niêm: năm hiện tại - năm sinh - 22
UPDATE thunhap_nv
set thamnien=year(getdate())-year(ngaysinh)-22 
from nhanvien 
where thunhap_nv.manv=nhanvien.manv
--cast (thamnien as smallint )
SELECT *FROM thunhap_nv
--bai 2     1<=Thâm niên<5	: 500000
--5<=thâm niên<10	: 1000000
--Thâm niên>=10		: 1500000
update thunhap_nv
set phucap=case 
               when 1<=thamnien and thamnien<5 then 500000  
			   when 5<=thamnien and thamnien<10 then 1000000
			   when thamnien>=10 then 1500000
			   end 
from thunhap_nv


--3.	Mỗi pxuong có bao nhiêu nhân viên làm việc--
select mapxuong , count(manv)
from nhanvien 
group by mapxuong


--4.	Tăng thêm 1,2 vào cột hệ số cho nhân viên có thâm niêm trên 5 năm 
update thunhap_nv
set heso=heso+1.2
select *from thunhap_nv

--5.	Cập nhật cột tongluong=luongchinh*heso+phucap-thue
update thunhap_nv
set tongluong=(luongchinh*heso) + phucap - thue


--6.	Xem danh sách nhân viên có tongluong trên 3000000
select manv,thamnien,tongluong
from thunhap_nv
where tongluong>=3000000


--7.	Hiển thị danh sách nhân viên gồm manv, ho va ten (Nối từ cột holot với cột ten), gioitinh (hiển thị Nam hoặc Nữ), tên phòng, tên pxuong, tongluong
select CONCAT_WS(' ',holot,ten) as hovaten ,case gioitinh when 1 then N'Nam' 
when 0 then N'Nữ' end as GT ,
tenphong,tenxuong,tongluong
from nhanvien,thunhap_nv,danhsachphong,dsachpxuong
where nhanvien.maphong=danhsachphong.maphong
and nhanvien.mapxuong=dsachpxuong.mapxuong
and nhanvien.manv=thunhap_nv.manv

--8.	Tạo một bảng DSHuu dữ liệu lấy từ bảng nhân viên gồm những nhân viên sắp về hưu theo quy định. 
-- gom 2 cot === ngaysinh AND tuoi ( da tinh xong )  
select manv,holot,ten,ngaysinh into DShuu 
from nhanvien
where ngaysinh>=40

select *from DShuu

--9.	Xóa nhân viên có điạ chỉ Hà Nội
delete from nhanvien
where diachi like N'%Hà%'


--10.	Tìm các nhân viên trùng ngày sinh 
select v1.manv,v1.holot,v1.ten 
from nhanvien v1 , nhanvien v2
where v1.ngaysinh=v2.ngaysinh
--and v1.manv <> v2.manv  (hoten và manv phải khác nhau )
