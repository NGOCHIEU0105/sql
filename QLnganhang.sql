create database QLTKnganhang
use QLTKnganhang

create table khachhang
(maKH nvarchar(20) primary key ,
hovaten nvarchar(20) not null ,
diachi nvarchar(20) not null ,
sdt nvarchar(20) not null )

--THEM RANG BUOC
ALTER TABLE KHACHHANG
ADD CONSTRAINT BBB UNIQUE (MAKH)

create table taikhoan 
(soTK nvarchar(15) constraint mmm primary key ,
kieuTK nvarchar(20) not null ,
makh nvarchar(20) not null ,
ngaymoTK date not null , 
sotien float not null ,
CONSTRAINT fk01_TK FOREIGN KEY(makh) REFERENCES KHACHHANG(makh)
on delete cascade on update cascade)

--thay kieu du lieu cho 1 cot 
alter table taikhoan
alter column kieuTK nvarchar(50)


create table giaodich 
( maGD nvarchar(20)  ,
makh nvarchar(20) not null ,
thoigianGD date not null ,
sotienGD float not null ,
sodu float not null ,
motaGD nvarchar(20) null,
CONSTRAINT nnn PRIMARY KEY (magd),
CONSTRAINT fk01_GD FOREIGN KEY(makh) REFERENCES khachhang(makh)
on delete cascade on update cascade)
--
--
--

--nhap du lieu bang khachhang
insert into khachhang values('KH1',N'Trần Văn Chiến',N'Lạng Sơn','0947297442')
insert into khachhang values('KH2',N'Lân Tây',N'Kon Tum','0947297442')
insert into khachhang values('KH3',N'Nguyễn An Lợi',N'Vĩnh Long','0947297442')
insert into khachhang values('KH4',N'Trần Minh Văn',N'Hà Nội','0947297442')
insert into khachhang values('KH5',N'Lê Hoài Thu',N'Khánh Hòa','0947297442')
insert into khachhang values('KH6',N'An Lạc Hầu',N'Đà Nẵng','0489391039')
insert into khachhang values('KH7',N'Man Lan',N'Hà Nội','0382716432')
insert into khachhang values('KH8',N'Man Lan',N'H Nội','0380016432')

select *from khachhang

--nhap du lieu bang taikhoan
insert into taikhoan values('0782737731',N'saving','KH1','2019/3/2',3000000)
insert into taikhoan values('847294949626',N'checking','KH2','2010/1/27',7000000)
insert into taikhoan values('7373828',N'tài khoản cá nhân trong nước','KH3','2021/7/9',1000000)
insert into taikhoan values('939737471764',N'tài khoản tổ chức trong nước','KH4','1998/8/21',40000000)
insert into taikhoan values('352545771',N'tài khoản tổ chức ngoài nước','KH5','2013/12/15',850000000)
insert into taikhoan values('383994929',N'checking','KH6','2003/2/11',7000000)
insert into taikhoan values('48298494',N'tài khoản cá nhân trong nước','KH3','2016/2/19',1000000)
insert into taikhoan values('3917839491',N'checking','KH7','2004/1/1',8000000)
insert into taikhoan values('7373899',N'checking','KH8','2002/1/1',89910000)

Select *from taikhoan order  by makh asc
DELETE FROM taikhoan

--nhap du lieu bang giao dich 
insert into giaodich values('GD001','KH1','2022/7/20',500000,3500000,N'gửi tiền')
insert into giaodich values('GD002','KH2','2016/2/9',100000,6900000,N'chuyển khoản')
insert into giaodich values('GD003','KH3','2023/1/14',910000,90000,N'rút tiền')
insert into giaodich values('GD004','KH4','2007/7/20',724000,32760000,N'thanh toán hóa đơn')
insert into giaodich values('GD005','KH5','2014/9/21',32000000,818000000,N'chuyển khoản')
insert into giaodich values('GD006','KH6','2005/1/30',300000,7300000,N'gửi tiền')
insert into giaodich values('GD007','KH7','2017/4/28',300000,500000,N'rút tiền')
insert into giaodich values('GD008','KH8','2017/12/28',3500000,9900000,N'nộp tiền')

select *from giaodich order by maGD asc --desc
DELETE FROM giaodich

--Câu 1: Tạo các truy vấn dữ liệu trong sql sử dụng trên một bảng
--1.1. Tạo truy vấn hiển thị thông tin tất cả các tài khoản có kiểu là “Checking”
select sotk,taikhoan.makh,hovaten
from taikhoan,khachhang
where kieuTK like N'%checking%'
and taikhoan.makh=khachhang.maKH

--1.2. Tạo truy vấn hiển thị các thông tin gồm (MaKH, SoTK, KieuTK, NgayMoTK) của các tài khoản có kiểu
--“Tài khoản cá nhân trong nước” và sắp xếp kết quả hiển thị 
--sao cho ngày mở gần nhất( gần ngày hiện tại ) sẽ được hiển thị trước (tức là ngày mở được sắp xếp giảm dần)
select makh,soTK,kieuTK,ngaymoTK 
from taikhoan 
where kieuTK like N'%cá NHÂN%' order by ngaymoTK desc

--1.3. Tạo truy vấn hiển thị Tên, địa chỉ, thành phố các khách hàng sống tại thành phố “Hà Nội”.
--Sắp xếp kết quả theo thứ tự Alphabet của tên khách hàng
--a--->z == asc == tang
--z--->a == desc == giam
select hovaten,diachi
from khachhang
where diachi like N'%Hà Nội%' order by hovaten asc

--1.4. Tạo truy vấn hiển thị thông tin các khách hàng đã mở tài khoản trước ngày 01/07/2011.
select kh.makh , hovaten , diachi ,sdt ,ngaymoTK
from khachhang kh , taikhoan
where kh.maKH=taikhoan.makh
and ngaymoTK < '2011/7/1'


--Câu 2: Tạo các truy vấn dữ liệu trong sql sử dụng trên nhiều bảng
--2.1. Thực hiện truy vấn hiển thị thông tin khách hàng, kiểu tài khoản, ngày mở.
select kh.makh,hovaten,diachi,kieutk,ngaymotk
from khachhang kh , taikhoan
where kh.maKH=taikhoan.makh order by makh desc 
--2.2. Thực hiện truy vấn hiển thị tất cả các thông tin như truy vấn trên và thỏa mãn 
--điều kiện ngày mở sau ngày 01/07/2011.
select kh.makh , hovaten , diachi ,sdt ,ngaymoTK
from khachhang kh , taikhoan
where kh.maKH=taikhoan.makh
and ngaymoTK > '2011/7/1'

SELECT *
FROM  khachhang JOIN (
  SELECT makh,ngaymotk
  FROM taikhoan
  WHERE ngaymoTK > '2011/7/1'
) taikhoan ON khachhang.maKH = taikhoan.makh
--2.3. Thực hiện truy vấn hiển thị tất cả các thông tin như truy vấn trên 
--và thỏa mãn điều kiện ngày mở sau ngày 01/07/2011 
--và kiểu tài khoản là “Tài khoản tổ chức trong nước”.... được sắp xếp theo thứ tự Alphabet của tên khách hàng.
select kh.makh , hovaten , diachi ,sdt ,ngaymoTK
from khachhang kh , taikhoan
where kh.maKH=taikhoan.makh
and ngaymoTK > '2011/7/1'
and kieuTK like N'%tổ chức trong %' order by hovaten asc

--2.4. Thực hiện truy vấn hiển thị các thông tin: SoTK,KieuTK,SoTienGD,
--MoTaGD,ThoiGianGD,SoDuTaiKhoan cuả tài khoản 000000003 và giao dịch
--ngày 20/07/2007.
select soTK,kieuTK,sotien,sotienGD,sodu,motaGD,thoigianGD
from taikhoan,giaodich,khachhang
where taikhoan.makh=khachhang.maKH
and khachhang.makh=giaodich.makh
and sotk='939737471764'
and thoigianGD='2007/7/20'

--2.5. Liệt kê các thông tin về tất cả các lần giao dịch gồm: 
--HoTenKH, DiaChi, SoTK, KieuTK, ThoiGianGD, SoTienGD, MoTaGD, SoDuTaiKhoan 
--của khách hàng có số tài khoản là: 500000
select khachhang.hovaten,diachi,soTK,kieuTK,sotienGD,motaGD,thoigianGD,sodu
from taikhoan,giaodich,khachhang
where taikhoan.makh=khachhang.maKH
and khachhang.makh=giaodich.makh
and sotk='7373828'
