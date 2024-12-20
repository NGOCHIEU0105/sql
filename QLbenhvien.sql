create database QLbenhvien
go
use QLbenhvien
go
CREATE TABLE KHOA(
	Makhoa char(20) NOT NULL primary key ,
	Tenkhoa nvarchar(50) NULL)
go
CREATE TABLE PHONG(
	Maphong char(20) NOT NULL primary key,
	Tenphong nvarchar(50) NULL,
	Makhoa char(20) NULL foreign key references khoa(makhoa)
	on delete cascade on update cascade)
go
 CREATE TABLE BACSI(
	MaBs char(20) NOT NULL primary key,
	TenBS nvarchar(50) NULL,
	Gioitinh bit NULL,
	Chuyen_mon nvarchar(50) NULL,
	Namsinh date NULL,
	CMND int NULL,
	Makhoa char (20) NULL foreign key references khoa(makhoa)
	on delete cascade on update cascade)
go
CREATE TABLE BENHNHAN(
	MaBN char(20) NOT NULL primary key,
	Hoten nvarchar(50) NULL,
	Gioitinh bit NULL,
	Diachi nvarchar(50) NULL,
	Namsinh date NULL,
	 CMND int NULL)
go
CREATE TABLE GIUONGBENH(
	Magiuong char(20) NOT NULL,
	Trang_thai nvarchar(50) NULL,
	Maphong char(20) NOT NULL foreign key references phong(maphong)
	on delete cascade on update cascade,
	MaBN char(20) NOT NULL foreign key references benhnhan(mabn)
	on delete cascade on update cascade,
	primary key(magiuong,maphong,mabn))
go
	INSERT INTO KHOA(Makhoa, Tenkhoa)
     VALUES('KH01','Hoi suc cap cuu'),
('KH02',N'Cap cuu'),
('KH03','Rang Ham Mat'),
('KH04','Phau Thuat'),
('KH05','Ngoai'),
('KH06','Noi'),
('KH07','Than kinh'),
('KH08','Ung buu'),
('KH09','San'),
('KH10','Nhi')
go
INSERT INTO PHONG(Maphong, Tenphong, Makhoa)
VALUES ('PCC1','Phau thuat','KH02'),                
('PCC10','Nhi2','KH10'),                
('PCC11',N'Chờ sinh','KH09'),                
('PCC12',N'Hậu sản','KH09'),                
('PCC2','Hoi suc 01','KH01'),                
('PCC3','Phau thuat 02','KH04'),                
('PCC4','Benh 01','KH03'),                
('PCC5','Benh 02','KH01'),                
('PCC6','Benh 03','KH02'),                
('PCC7','Benh 04','KH02'),                
('PCC8','Benh 05','KH05'),                
('PCC9','Nhi1','KH10')
go 
INSERT INTO BACSI(MaBS,TenBS,Gioitinh,Chuyen_mon,Namsinh,CMND,Makhoa)
VALUES ('BS01','Binh Thuan',1,N'Phẫu thuật','1989-11-09',13245678,'KH01'),                
('BS02','Nhu Ngoc',0,N'Chỉnh hình','1979-01-17',8763278,'KH01'),                
('BS03','Dinh Ton',1,N'Răng hàm mặt','1969-10-09',3762178,'KH03'),                
('BS04','Nguyet',0,N'Phẫu thuật','1999-01-19',134365678,'KH02'),                
('BS05','Duc',1,N'Phẫu thuật','1980-12-09',132324218,'KH04'),                
('BS06','Kha',0,N'Nội soi','1987-09-08',12345678,'KH01')
go
INSERT INTO BENHNHAN(MaBN,Hoten,Gioitinh,Diachi,Namsinh,CMND)
VALUES  ('BN01','Nguyen An',1,'12 Dinh Tien Hoang','1976-01-04',12345678),
('BN010','Ngo Truc',0,'DakLak','1997-09-12',1),
('BN02','Nguyen Ba',1,'Dong Nai','1976-01-04',123455678),
('BN03','Nguyen Canh',1,'Binh Duong','1979-11-04',19845678),
('BN04','Nguyen Dung',0,'Nha Trang','1986-01-08',98735678),
('BN05','Nguyen Em',1,'Vung Tau','1979-01-09',4387678),
('BN06','Le An',0,'Binh Dinh','1987-09-04',0),
('BN07','Ho Nguyet',1,'Quang Ngai','1967-03-06',0),
('BN08','Tran Phong',1,'Phu Yen','1985-05-03',0),
('BN09','Dao Tam',1,'Gia Lai','1990-05-09',0)
go
INSERT INTO GIUONGBENH(Magiuong,Trang_thai,Maphong,MaBN)
VALUES ('m110','on','pcc1','BN03'),                
('m1110','ON','PCC1','BN01'),                
('m1110','on','pcc1','bn02'),                
('M1210','ON','PCC1','BN06'),                
('M1210','ON','PCC1','BN07'),                
('M1210','ON','PCC1','BN08'),                
('m1210','OFF','PCC2','BN02'),                
('m1320','OFF','PCC4','BN04'),                
('m1350','ON','PCC2','BN02'),                
('m1510','ON','PCC3','BN03'),                
('m1650','ON','PCC5','BN01'),                
('m3110','ON','PCC6','BN05') 

go

--Phần 1:
--1. Thống kê số lượng bệnh nhân của mỗi phòng?
select maphong,count(mabn)
from GIUONGBENH
group by maphong
--2. Hiển thị danh sách bệnh nhân ở phòng số PCC1, PCC3, PCC5?
select maphong,count(mabn)
from GIUONGBENH
where Maphong in ('PCC1','PCC3', 'PCC5')
group by maphong
--3. Hiển thị danh sách bệnh nhân ở phòng Hoi suc 1, sắp xếp kết quả tăng dần theo mabn (mã bệnh nhân)
select BENHNHAN.MaBN,hoten
from PHONG,BENHNHAN,GIUONGBENH
where phong.Maphong=GIUONGBENH.Maphong
and GIUONGBENH.MaBN=BENHNHAN.MaBN
and tenphong like N'Hoi suc 01'
order by MaBN asc
--4. Cập nhật giường bệnh nhân ‘BN01’ sang giường mã số ‘M1210’
update GIUONGBENH
set Magiuong='M1210'
WHERE MaBN='BN01'   

select *from GIUONGBENH
--5. Xem danh sách phòng không có bệnh nhân nào điều trị
select maphong
from PHONG where Maphong not in (select maphong from GIUONGBENH)

--6.Tạo bảng benhnhan_ĐB dữ liệu lấy từ bảng BENHNHAN gồm những bệnhnhân ở phòng ‘Hoi suc 01’
SELECT hoten into benhnhan_db 
FROM BENHNHAN,phong,GIUONGBENH
where phong.Maphong=GIUONGBENH.Maphong
and GIUONGBENH.MaBN=BENHNHAN.MaBN
and tenphong = 'Hoi suc 01'
 
--7. Hiển thị danh sách bệnh nhân chưa có số CMND
select * from BENHNHAN where cmnd is null 
--8. Thống kê số lượng bác sĩ của mỗi khoa?
select khoa.makhoa , count(mabs)
from khoa,bacsi 
where khoa.makhoa=bacsi.makhoa
group by khoa.makhoa

--9. Hiển thị danh sách bác sĩ ở khoa Phẫu thuật?
select mabs
from bacsi , khoa 
where khoa.makhoa=bacsi.makhoa
and tenkhoa like N'cap cuu'

--10. Cho biết các khoa nào chưa có bác sĩ?
--la nhung mmakhoa trong bang khoa ko có trong bảng bacsi 
select makhoa
from khoa where makhoa not in(select makhoa from bacsi)

--11. Xem thông tin các phòng bệnh của khoa Rang Ham Mat
--12. Xem thông tin bác sĩ nữ, chuyên môn Chỉnh hình

--13. Chuyển (cập nhật thông tin) bác sĩ có mã ‘BS01’ sang khoa Ngoai.
UPDATE BACSI 
SET Makhoa = (SELECT makhoa FROM khoa WHERE tenkhoa = N'Ngoai')
where mabs = 'BS01'

select *from BACSI
select *from KHOA


--14. Xóa thông tin các phòng không thuộc khoa nào
--la nhung maphong của bang phong khong nam trong bang khoa 
select *from phong 
select *from khoa 

DELETE FROM phong
WHERE maphong NOT IN (SELECT phong.maphong FROM phong JOIN khoa 
ON phong.makhoa = khoa.makhoa)

đoạn code này sẽ xóa tất cả các bản ghi trong bảng 'phong' mà không thuộc về bất kỳ 
khoa nào trong bảng 'khoa'--nghia la maphong ko có trong makhoa

--15. Thống kê số lượng phòng của mỗi khoa?
--16. Hiển thị danh sách bác sĩ ở khoa Nhi?
--17. Xem thông tin các phòng bệnh của khoa Sản
--18. Cho biết khoa chưa có phòng bệnh?
select makhoa 
from khoa where makhoa not in (select makhoa from phong)

--19. Cập nhật chuyên môn của bác sĩ mã ‘BS01’ thành Nội soi
update BACSI
set Chuyen_mon=N'Nội soi'
where MaBs='BS01'
--20. Xem thông tin bác sĩ trên 40 tuổi, chuyên môn Phẫu thuật
--21. Chọn ra 2 bác sĩ trẻ tuổi nhất
select top 2 tenbs,mabs
from bacsi 
order by (year(getdate())-year(namsinh)) asc 

--22. Thống kê trạng thái của giường bệnh?
select trang_thai,count(magiuong)
from GIUONGBENH
group by trang_thai 
--23. Hiển thị danh sách bệnh nhân nam ở phòng số PCC1?
select hoten
from benhnhan b 
where b.MaBN in (select MaBN from GIUONGBENH where maphong = 'PCC1') 
AND Gioitinh='1'

select *from benhnhan
select *from GIUONGBENH
--24. Hiển thị danh sách bệnh nhân ở phòng Nhi1, Nhi2, sắp xếp kết quả tăng dần theo mabn
select hoten,benhnhan.mabn
from PHONG,BENHNHAN,GIUONGBENH
where phong.Maphong=GIUONGBENH.Maphong
and GIUONGBENH.MaBN=BENHNHAN.MaBN 
and tenphong in ('Hoi suc 01','Phau thuat 02')
order by benhnhan.mabn asc

--25. Xem thông tin những khoa chỉ có 1 phòng bệnh
select makhoa,count(maphong)
from phong 
group by makhoa 
having count(maphong) = 1


--13 14 19 

--Phần 2.
--1. Viết thủ tục tham số truyền vào là mabn (mã bệnh nhân), thủ tục sẽ in ra thông
--tin về bệnh nhân đó (tên bệnh nhân, ở phòng điều trị nào, giường số mấy).
create procedure bai11
@x nvarchar(20)
as begin 
        select hoten,tenphong,p.Maphong
		from benhnhan b ,GIUONGBENH g,PHONG p 
		where b.mabn=g.MaBN and g.Maphong=p.Maphong
		and b.mabn=@x
end
exec bai11 'bn02'
--2.Viết thủ tục nhập vào mã bác sĩ bất kỳ (mabs là tham số), thủ tục sẽ in rathông tin của bác sĩ đó.

--3. Viết thủ tục nhập vào mã phòng bất kỳ (maphong là tham số), thủ tục sẽ in ra
--thông tin của phòng đó (thông tin gồm: tên phòng, tên khoa, tên bác sĩ)
create procedure bai33
@x nvarchar(20)
as begin 
         select tenphong,tenkhoa,tenbs
		 from phong p,khoa k , bacsi b
		 where p.Makhoa=k.Makhoa and k.Makhoa=b.Makhoa
		 and maphong=@x 
end 
exec bai33 'pcc3'
--4. Viết hàm tham số truyền vào là maphong (mã phòng), hàm sẽ trả về số giường của phòng đó.
create function bai44 (@x nvarchar(30))
returns int 
as begin 
        declare @sogiuong int 
		select @sogiuong=count(magiuong)
		from GIUONGBENH
		where maphong=@x 
		group by maphong 
		return @sogiuong 
end 
select dbo.bai44('pcc1') as N'tổng số giường'


	Phần 3.
--1. Viết trigger không cho phép một giường có quá 2 bệnh nhân.
create trigger bai1
on giuongbenh
for insert 
as begin 
        if exists (select count(mabn) from inserted group by Magiuong having count(mabn) >=2)
		print('ko cho phep nhap them ')
		rollback tran 
end

--2. Viết trigger ràng buộc một khoa không có quá 3 bác sĩ. GIONG BAI 1

--3. Viết trigger ràng buộc không cho phép xóa bác sĩ khoa Rang Ham Mat
alter trigger bai3
on bacsi
for delete 
as begin 
        if exists (select mabs from deleted d,khoa where d.Makhoa=khoa.Makhoa
		and tenkhoa like N'Rang Ham Mat')
		print('ko the xoa') rollback tran 
end 

delete BACSI from khoa  where bacsi.Makhoa=khoa.Makhoa
and tenkhoa like N'Rang Ham Mat'

--4. Viết trigger thực hiện công việc sau: Khi xóa 1 bệnh nhân thì trigger tự động
--cập nhật trạng thái giường của bệnh nhân đó thành OFF
alter trigger bai4
on giuongbenh
after delete 
as begin 
        update giuongbenh 
		set trang_thai = 'onnnn'
		from inserted
		where inserted.mabn=GIUONGBENH.MaBN
end 

delete from GIUONGBENH where MaBN='bn06'

select *from GIUONGBENH

