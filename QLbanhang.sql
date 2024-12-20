
create database QLBANHANG01  

use QLBANHANG01
--BANG KHACHHANG        
create table khachhang
(makh char(10) primary key ,
hovaten nvarchar(100),
sdt char (10) constraint nnn unique ,
ngaysinh date ,
doanhso float default (0))


--BANG NHANVIEN
create table nhanvien 
(manv char (10) primary key ,
hovaten nvarchar (70) not null ,
ngaysinh datetime constraint vvv check (ngaysinh>18) ,
gioitinh bit ,
ngaylamviec date ,
sdt char(10) not null) 

--BANG SANPHAM
create table sanpham 
(masp char (10) primary key ,
tensp nvarchar (60) not null ,
dvt nvarchar (30) , 
nuocsx nvarchar (50) ,
gia float not null ,
soluong float not null constraint mmm check (soluong >=50))

--BANG HOADON 
create table hoadon 
(sohd char (10) primary key ,
ngayHD date ,
makh char (10)  ,
manv char (10) ,
trigia float default (0))


--BANG CTHD
create table CTHD 
(sohd char (10)  ,
masp char (10) ,
soluong float not null ,
giaban float not null ,
constraint fk_01 primary key (sohd,masp))


--them cot vao cac bang....
alter table khachhang
add diachi nvarchar(50)

alter table nhanvien
add diachi nvarchar(50) 


---	THEM RANG BUOC ///    
alter table hoadon 
add constraint AAA default (getdate()) for ngayHD 
alter table nhanvien
DROP column diachi
--xoa rang buoc................
alter table sanpham    
drop constraint mmm


-- Khoa ngoai cho bang HOADON
ALTER TABLE HOADON ADD CONSTRAINT fk01_HD FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH)
on delete cascade on update cascade
ALTER TABLE HOADON ADD CONSTRAINT fk02_HD FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV)
on delete cascade on update cascade
-- Khoa ngoai cho bang CTHD
ALTER TABLE CTHD ADD CONSTRAINT fk01_CTHD FOREIGN KEY(SOHD) REFERENCES HOADON(SOHD)
on delete cascade on update cascade
ALTER TABLE CTHD ADD CONSTRAINT fk02_CTHD FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)
on delete cascade on update cascade
----------------------------------------


--nhap du lieu ...........

insert into KHACHHANG values('KH1',N'Lê Văn Long','0913863877','2006/12/31',20000,N'Quy Nhơn')
insert into KHACHHANG values('KH2',N'Minh Ngọc Hoàng','0945563877','2003/4/23',12000,N'Nam Định')
insert into KHACHHANG values('KH3',N'Nguyễn Văn An','0913863777','1987/9/12',30000,N'Quy Nhơn')
insert into KHACHHANG values('KH4',N'Lê Văn Nam','0713812377','1999/7/30',8000,N'Hà Nội')
insert into KHACHHANG values('KH5',N'Vũ Thanh','0913113877','2011/2/27',21000,N'Ninh Thuận')
insert into KHACHHANG values('KH6',N'Vũ Văn','0913113007','2002/2/25',15500,N'Ninh Bình')
insert into KHACHHANG values('KH7',N'An Nhân','0913113077','2000/9/25',150000,N'Hòa Bình')
insert into KHACHHANG values('KH8',N'Lê Thanh Hoa','0990013077','2023/3/8',60000,N'Gia Lai')
insert into KHACHHANG values('KH9',N'Mận Đào','0352778164','2011/11/5',1000,N'Cà Mau')
insert into KHACHHANG values('KH10',N'Chua Đào','0227617393','1998/1/19',2100,N'Cà Mau')

select *from KHACHHANG
delete from KHACHHANG

insert into nhanvien values('NV1',N'Nguyên Trung ','1985/4/5',1,'2008/3/23','0705009288',N'Phú Yên')
insert into nhanvien values('NV2',N'Lê Uông ','1970/6/7',0,'2012/4/3','0405839288',N'Quãng Nam')
insert into nhanvien values('NV3',N'Trần Bình ','1996/2/3',0,'2018/9/21','0375839288',N'Quãng Ngãi')
insert into nhanvien values('NV4',N'Ung Trung ','1996/1/1',1,'2020/12/9','0475839008',N'Quảng Bình')
insert into nhanvien values('NV5',N'Nguyên Trung ','2004/4/24',1,'2023/4/19','0475830288',N'Bình Định')
insert into nhanvien values('NV6',N'Công Đông','2004/4/24',1,'2023/4/19','0475839923',N'Bình Định')
insert into nhanvien values('NV7',N'Hoài Nam','1984/1/24',1,'2010/4/19','0475839111',N'Gia Lai')
insert into nhanvien values('NV8',N'Trần Văn Nam','2002/1/11',1,'2021/1/19','0990013077',N'Gia Lai')
insert into nhanvien values('NV9',N'Trần An Hoài ','2001/10/29',1,'2023/3/21','0335289077',N'Lạng Sơn')
insert into nhanvien values('NV10',N'Trần An Hoài ','1988/1/9',1,'2004/7/12','0335293747',N'Cao Bằng')

select *from nhanvien
delete from nhanvien

insert into sanpham values ('BC1',N'bút chì',N'cây',N'Nhật Bản',11000,55)
insert into sanpham values ('B1',N'bánh ',N'mặn',N'Việt Nam',20000,40)
insert into sanpham values ('BB1',N'bút bi',N'hộp',N'China',7000,20)
insert into sanpham values ('BL1',N'bút lông',N'cây',N'Japan',10000,100)
insert into sanpham values ('B2',N'bánh',N'ngọt',N'Việt Nam',3000,600)
insert into sanpham values ('B3',N'bánh',N'táo',N'Việt Nam',3000,10)
insert into sanpham values ('K1',N'kẹo',N'ngọt',N'Việt Nam',30000,20)
insert into sanpham values ('K2',N'kẹo',N'dang',N'Pháp',70000,10)
insert into sanpham values ('SH1',N'sữa',N'hộp',N'Hà Lan',4000,210)
insert into sanpham values ('SL1',N'sữa',N'lon',N'Hà Lan',4000,210)

select *from sanpham
delete from sanpham 
 

insert into hoadon values (1,'2006/7/28','KH1','NV1',22000)
insert into hoadon values (2,'2023/1/6','KH2','NV2',310000)
insert into hoadon values (3,'2018/11/4','KH3','NV3',25500)
insert into hoadon values (4,'2022/3/28','KH4','NV4',12000)
insert into hoadon values (5,'2022/4/8','KH5','NV5',9000)
insert into hoadon (sohd,makh,manv,trigia)
values(6,'KH6','NV6',10000)
insert into hoadon values (7,'2023/1/8','KH7','NV7',200000)
insert into hoadon values (8,'2023/3/8','KH1','NV2',200000)
insert into hoadon (sohd,ngayHD,manv,trigia)
values (9,'2023/3/8','NV3',200000)
insert into hoadon values (10,'2003/7/28','KH10','NV1',22000)
select *from hoadon 
delete from hoadon


insert into CTHD values(1,'BC1',55,11000)
insert into CTHD values(2,'B1',40,20000)
insert into CTHD values(3,'BB1',20,7000)
insert into CTHD values(4,'BL1',100,10000)
insert into CTHD values(5,'B2',600,3000)
insert into CTHD values(6,'B3',10,3000)
insert into CTHD values(7,'K1',20,30000)
insert into CTHD values(8,'K2',10,70000)
insert into CTHD values(9,'SH1',210,4000)
insert into CTHD values(9,'SL1',210,4000)

select *from CTHD
DELETE FROM CTHD 
--cap nhat du lieu ...
--------


update sanpham set gia=gia+gia*0.1 where nuocsx like N'%Nhật%'
--------
update CTHD  
set giaban=gia * 0.2
from sanpham 
where CTHD.giaban=sanpham.gia 
 

--them cot email and cap email la makh@gmail.com......
alter table khachhang
add email nvarchar(50)

update KHACHHANG 
set email =(makh+'@gmail.com')  

update KHACHHANG 
set email=replace(email,' ','')


--XOA DU LIEU UUUUUUUUUU.....
--xoa nhan vien > 40 tuoi 
delete from nhanvien 
where (year(getdate())-year(ngaysinh) > 40) 


--xoa nhung don hang truoc nam ....
delete from CTHD  
from hoadon
where year(ngayHD)<2006
and CTHD.sohd=hoadon.soHD

--huy don hang so KH co sdt .... dat hang 
delete from hoadon 
from KHACHHANG
where sdt=0913863877
and KHACHHANG.makh=hoadon.makh

 
--xoa KH chua mua hang 1 nam qua ....
DELETE FROM KHACHHANG 
where makh in (select makh from hoadon 
			        where convert(int,convert(datetime,getdate())-convert(datetime,ngayHD)) > 365)
--tên một makh phải có trong 2 bảng (khachhang ,, hoaodon)			        
SELECT *FROM hoadon 
select *from KHACHHANG
   

   --- BT bo sung cho BTH 2 ---
--2/ xoa cot email trong table NHANVIEN  
alter table nhanvien
drop column email 

--3/Tăng giá cua san pham lên 10%
UPDATE sanpham 
set gia=giaban*0.1
from CTHD 
where sanpham.masp=CTHD.masp

--4.hiển thị ds khachhang chauw có số điện thoai
select hovaten from KHACHHANG 
where sdt is null
or sdt='null'

--5/  thong ke moi khach hang dat bao nhieu don hang ....
select makh  , count(soHD) AS dondadat 
from hoadon 
group by makh 

--6// sanpham chua ban duoc .... tuc la khong co ngayhd trong bang hoadon 
select h.sohd,s.masp,tensp
from hoadon h ,sanpham s,CTHD
where h.sohd=cthd.sohd
and cthd.masp=s.masp
and ngayhd is null
 
--7.	Hóa đơn so 1 cua Khách hàng nào? 
select hovaten,diachi
from KHACHHANG inner join hoadon 
on soHD=1 
where KHACHHANG.makh=hoadon.makh
 
--8.	Xem danh sách khách hàng sinh nhat hôm nay
select hovaten
from KHACHHANG
where ngaysinh='2023/3/8'       --// yy/mm/dd   '-'
select *from khachhang
--10. Th?ng kê t?ng s? lư?ng lên đơn c?a m?i s?n ph?m và nh?n xét t?nh tr?ng bán 
--hàng n?u s? lư?ng>=200 th? bán ch?y, n?u 20=<s? lư?ng <200: bán ch?m, c?n l?i: bán ? --
select tensp , sum(soluong) as N' tổng số lượng '
from sanpham 
group by tensp 

select tensp ,
    case  
	  when sum(soluong)>=200 then N'bán chạy'
	  when sum(soluong)>=20 and sum(soluong)<200 then N'bán chậm'
	  when sum(soluong)<20 then N'bán ế'
	      END AS N'nhận xét'
from sanpham 

--11.	Ngày hôm nay bán được bao nhiêu sản phẩm? tổng tiền thu được là bao nhiêu? 
--Tiền lời bao nhiêu?
select COUNT(cthd.masp) as sosp ,SUM(cthd.soluong) as tongsoluong,
SUM(cthd.soluong*giaban) as tongtien ,SUM(cthd.soluong*giaban)-SUM(cthd.soluong*sanpham.gia)
from hoadon,CTHD,sanpham
where ngayhd=getdate()
and hoadon.sohd=CTHD.sohd
and cthd.masp=sanpham.masp

select *from hoadon 


--14.	Tính trung b?nh m?i ngày bán đư?c bao nhiêu s?n ph?m
--Cách 1(2008)
select ngayhd, SUM(soluong)
from hoadon join CTHD  
on hoadon.soHD=CTHD.sohd
group by ngayhd


--15.	Xu?t ra nh?ng hóa đơn có t? 3 m? s?n ph?m tr? lên
Select sohd, count(masp)
From CTHD
Group by sohd
Having count(masp)>=3

--16.	DS khách hàng đon mua hàng ngày hôm qua
select hovaten 
from KHACHHANG , hoadon 
where ngayHD=dateadd(day,-1,'2023/3/29')
and Khachhang.makh=hoadon.makh

select*from hoadon
select*from khachhang
--17.	In ra nhung san pham khong ban đuoc trong 1 nam qua
select s.masp,tensp from sanpham s
where s.masp  not in ( select c.masp from CTHD c join hoadon h 
                     on c.sohd=h.sohd 
					 where convert(int,convert(datetime,getdate())-convert(datetime,ngayHD))<365)
------------                       
------------nhung san pham khong ban duoc trong nam 2023 
select s.masp,tensp from sanpham s 
where s.masp not in ( select c.masp from CTHD c join hoadon h 
                     on c.sohd=h.sohd where year(ngayHD)='2023')
------------                      

--18.	Cho biet hóa đơn số 1 lập cách đây mấy ngày
select sohd,CONVERT(int,(convert(datetime,getdate())-convert(datetime,ngayhd))) as songaylap
from hoadon
where sohd=1

select *from hoadon


--****** BAI THUC HANH SO 2 
-- 1 
select masp,tensp,soluong 
from sanpham

--2
select hovaten,ngaylamviec
from nhanvien

--3
select diachi,sdt
from KHACHHANG
where diachi =N'Quy Nhơn'

--4 
select masp,tensp 
from sanpham 
where gia>=10000 and soluong <50 

--5--xoa KH chua tung mua hang 

delete from KHACHHANG 
where makh not in (select makh from hoadon)

--6
select tensp 
from sanpham 
where nuocsx like N'Nhật Bản'
or nuocsx LIKE N'%pan%'

--7 Những khách hàng nào đã mua sữa hộp của công ty
select distinct hoten 
from ((CTHD inner join hoadon
      on CTHD.sohd=hoadon.sohd)
	  inner join sanpham
	  on CTHD.masp=sanpham.masp)
	  inner join KHACHHANG 
	  on hoadon.makh=KHACHHANG.makh
where tensp=N'kẹo'

select *from hoadon

select hovaten from khachhang,hoadon,sanpham,CTHD
where khachhang.makh=hoadon.makh
and hoadon.sohd=cthd.sohd 
and cthd.masp=sanpham.masp
and sanpham.tensp=N'kẹo'

--8 Đơn hàng số 1 do ai đặt và do nhân viên nào lập, trị giá là bao nhiêu?

select khachhang.hovaten ,nhanvien.hovaten ,hoadon.trigia
from khachhang,hoadon,nhanvien
where khachhang.makh=hoadon.makh
and hoadon.manv=nhanvien.manv
and hoadon.sohd=1

--9    Hãy cho biết có những nhân viên nào lại chính là khách hàng của công ty 
--(có cùng sodt)
select KHACHHANG.hovaten
from nhanvien , KHACHHANG 
where KHACHHANG.hovaten=nhanvien.hovaten
or khachhang.sdt=nhanvien.sdt
 

--10 danh sach nhan vien co cung ngay sinh 
select a.hovaten,b.ngaysinh,b.hovaten,a.ngaysinh
from nhanvien a inner join nhanvien b
on a.ngaysinh=b.ngaysinh
and a.hovaten <> b.hovaten   -- or  // a.manv=b.manv
--hovaten và manv phải khác nhau 

-- cau 1:xem nhung sanpham co gia tu 100000 den 500000
select sanpham.masp , sanpham.tensp
from sanpham , hoadon ,cthd
where trigia >= 100000 and trigia <= 500000
and sanpham.masp=cthd.masp
and cthd.sohd=hoadon.sohd

--- bai thuc hanh so 3 
--1. Những sản phẩm nào chưa từng được khách hàng mua tính đến thời điểm này 
select masp,tensp
from sanpham
where masp not in (select masp from cthd,hoadon   --where not exists 
where sanpham.masp=cthd.masp
and hoadon.sohd=CTHD.sohd)


--2. Những nhân viên nào chưa từng lập 1 hóa đơn tính đến thời điểm này?
select nhanvien.manv,hovaten,count(sohd) 
from nhanvien,hoadon 
group by nhanvien.manv , hovaten 
having count(sohd)=0

select manv,hovaten from nhanvien where manv not in (select manv from nhanvien)

select *from hoadon
select *from nhanvien
--3. Những nhân viên nào của công ty có thâm niên cao nhất?
select top 1 manv,hovaten 
from nhanvien 
order by (year(getdate())-year(ngaylamviec)) desc


--4. Tổng số tiền mà khách hàng phải trả cho mỗi hóa đơn là bao nhiêu?
select kh.hovaten,kh.makh,hoadon.sohd,sum(cthd.soluong*giaban)
from khachhang kh , hoadon ,cthd
where kh.makh=hoadon.makh
and hoadon.sohd=CTHD.sohd
group by kh.hovaten,hoadon.sohd,kh.makh

select *from CTHD
--5. Trong năm 2023 những sản phẩm nào đặt mua đúng một lần?
select sanpham.masp,tensp,count(hoadon.sohd)
from sanpham,cthd,hoadon
where hoadon.sohd=cthd.sohd
and cthd.masp=sanpham.masp and year(ngayHD)=2023
group by sanpham.masp,tensp
having count(CTHD.sohd)=1
--can tao ra ngayHD có nam 2023 nhiu hon cung 1 sanpham 

--6. Tính trị giá của mỗi hóa đơn?
select hoadon.sohd , sum(trigia)
from sanpham , hoadon,CTHD
where sanpham.masp=CTHD.masp
and cthd.sohd=hoadon.sohd
group by hoadon.sohd

--7. Tính doanh số mua hàng của mỗi khách hàng--###CAN false
select hovaten,khachhang.makh,sum(doanhso)
from khachhang join hoadon
on khachhang.makh=hoadon.makh
group by hovaten,khachhang.makh

--8. Mỗi nhân viên của công ty đã lập bao nhiêu hóa đơn (nếu chưa từng lập hóa đơn nào 
--thì cho kết quả là 0)? 
select nv.manv,hovaten,count(sohd)
from nhanvien nv,hoadon
where nv.manv=hoadon.manv
group by nv.manv , hovaten

--9. Thống kê số lượng hàng tồn(nguồn vật tư) của công ty? 
select count(convert(int,hoadon.sohd)) 
from sanpham,hoadon,CTHD
where sanpham.masp=CTHD.masp
and cthd.sohd=hoadon.sohd

--10. Tính tổng số tiền lời mà công ty thu được từ mỗi mặt hàng trong năm 2018? 
--tien loi == doanh thu(gia*soluong) - chi phi.................................
select SUM(CTHD.soluong*giaban)-SUM(CTHD.soluong*sanpham.gia) as N'tiền lời'
from hoadon,CTHD,sanpham
where year(ngayhd)=2023
and hoadon.sohd=CTHD.sohd
and cthd.masp=sanpham.masp

--Bài thực hành số 4: Câu lệnh SQL (tiếp theo – 3 tiết) 
--1. Nhân viên nào của công ty bán được số lượng hàng nhiều nhất và số lượng hàng bán 
--được của những nhân viên này là bao nhiêu? 
select hovaten , nhanvien.manv,sum(soluong)
from nhanvien,CTHD,hoadon
where nhanvien.manv=hoadon.manv
and hoadon.sohd=cthd.sohd
group by hovaten , nhanvien.manv
having sum(soluong) >=all (select sum(soluong)
from nhanvien,CTHD,hoadon
where nhanvien.manv=hoadon.manv
and hoadon.sohd=cthd.sohd
group by hovaten , nhanvien.manv)

select top 1 nhanvien.manv,hovaten,sum(soluong)
from nhanvien,CTHD,hoadon
where nhanvien.manv=hoadon.manv
and hoadon.sohd=cthd.sohd
group by nhanvien.manv , hovaten
order by sum(soluong) desc 


--2. Đơn đặt hàng nào có số lượng hàng được đặt mua ít nhất? 
select CTHD.sohd,sum(soluong)
from CTHD,hoadon
where hoadon.sohd=cthd.sohd
group by CTHD.sohd
having sum(soluong) <=all (select sum(soluong)
from CTHD,hoadon
where hoadon.sohd=cthd.sohd
group by CTHD.sohd)

--3. Số tiền nhiều nhất mà khách hàng đã từng bỏ ra để đặt hàng trong các đơn đặt hàng là bao nhiêu? 
select top 1 sum(soluong*giaban-soluong*trigia),cthd.sohd
from cthd ,hoadon 
where cthd.sohd=hoadon.sohd
group by cthd.sohd
order by 1 ,cthd.sohd desc

--4. Mỗi đơn đặt hàng đặt mua những mặt hàng nào và tổng số tiền của đơn đặt hàng? 
select hoadon.sohd,cthd.masp,tensp,sum(CTHD.soluong*giaban)  as TT
from hoadon,CTHD,sanpham
where hoadon.sohd=cthd.sohd 
and sanpham.masp=CTHD.masp
group by hoadon.sohd,cthd.masp,tensp

--5. Mỗi một loại hàng bao gồm những mặt hàng nào, tổng số lượng của mỗi loại và tổng 
--số lượng của tất cả các mặt hàng hiện có trong công ty? 
select masp,tensp,SUM(SOLUONG)
from sanpham 
group by masp,tensp 
  
SELECT SUM(SOLUONG) FROM sanpham
SELECT *FROM sanpham
--tong so luong cua moi loaij hang 
--tong so luongn cua tat ca cac mat hang 



--BAI THUC HANH so 6

--bai 1:viết thủ tục để xem doanh số mua hàng của khách hàng có mã X nào đó (X là tham số của thủ tục)
ALTER proc bai1 
@makh nvarchar(20) 
AS
begin
if(NOT EXISTS (SELECT doanhso FROM khachhang WHERE @makh=makh))
   BEGIN 
     PRINT('KO CO KHACH HANG '+ @makh)
   END 
ELSE 
   BEGIN SELECT doanhso FROM khachhang WHERE @makh=makh
   END
END

exec bai1 'KH4'
select *from khachhang
--bai 2:Viết thủ tục để xem masp và tensp của các sản phẩm có giá trị lớn hơn x và số lượng 
--hiện có ít hơn y (x,y là tham số) 
CREATE PROCEDURE bai2
    @x INT,
    @y INT
AS
BEGIN
    SELECT masp , tensp
    FROM sanpham
    WHERE gia > @x  AND soluong < @y;
END
SELECT *FROM sanpham
exec bai2 20000,60

--bai3 : Viết thủ tục cho biết nhân viên X đã lập bao nhiêu hóa đơn (tham số x là manv) 
create proc bai3
@manv nvarchar(20)
as 
begin 
     select nhanvien.manv,hovaten,count(sohd)
	 from nhanvien,hoadon
	 where nhanvien.manv=hoadon.manv
	 and @manv=nhanvien.manv
	 group by nhanvien.manv,hovaten
end

exec bai3 'NV1'

select *from nhanvien
select *from hoadon

--bai 4 :. Viết thủ tục cho biết hóa đơn X do nhân viên nào lập, có bao nhiêu sản phẩm trên hóa 
--đơn đó (tham số X là maHD) 
create proc bai4
@sohoadon nvarchar(20)
as 
begin 
     select nv.manv,hovaten,soluong
	 from nhanvien nv , hoadon , CTHD
	 where nv.manv=hoadon.manv
	 and hoadon.sohd=cthd.sohd
	 and @sohoadon=hoadon.sohd
end 

exec bai4 4
select *from CTHD

--bai 5:Viết thủ tục để xem những sản phẩm nào đã được mua với số lượng nhiều nhất
ALTER proc bai5
as 
begin
     select TOP 1 sp.masp,tensp,sum(cthd.soluong)
	 from CTHD,sanpham sp
	 where cthd.masp=sp.masp
	 group by sp.masp,tensp
	 ORDER BY sum(cthd.soluong) DESC  
end

exec bai5
select *from sanpham


--BAI THUC HANH SO 7
--Bai 1 :viết hàm trả về tổng tiền (trị giá) mà khách hàng phải trả trên mỗi hóa đơn
alter FUNCTION tongtien()
RETURNS INT
as
BEGIN
    DECLARE @TongTien INT , @sohd int 
    SELECT @sohd=makh, @TongTien=SUM(trigia) 
    FROM HOADON 
    GROUP BY makh                            
    RETURN  @sohd
END
select makh, sum(trigia) as doanhso from hoadon group by(makh)

SELECT HOADON.sohd, SUM(CTHD.SoLuong * CTHD.giaban) AS TongTien
FROM HOADON JOIN CTHD ON HOADON.sohd = CTHD.sohd
GROUP BY HOADON.sohd

select dbo.tongtien()
select *from hoadon

--bai 2 "Viết hàm trả về tình trạng bán của các sản phẩm. Nếu soluong các sản phẩm 
--(trong bảng CTHD) >100 thì bán chạy, ngược lại là bán chậm
alter FUNCTION b2()
RETURNS table  
AS
RETURN 
(
    SELECT masp,
        CASE 
            WHEN soluong > 100 THEN N'Bán chạy' 
            ELSE N'Bán chậm' 
        END AS tinh_trang_ban 
    FROM CTHD
)
SELECT *FROM dbo.b2()
--bai 3 :Viết hàm trả về một bảng  gồm các thông tin Masp, tensp và soluong của các sảnphẩm hiện có trong công ty.

CREATE FUNCTION b3()
RETURNS TABLE
AS
RETURN
    SELECT masp, tensp, soluong
    FROM sanpham; 
	

select *from dbo.b3()
select *from sanpham

create FUNCTION TinhTrangBan()
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @TinhTrang NVARCHAR(50)
    IF (SELECT COUNT(*) FROM CTHD WHERE SoLuong > 100) > 0
        SET @TinhTrang = 'Bán chạy'
    ELSE
        SET @TinhTrang = 'Bán chậm'
    RETURN @TinhTrang
END


--bai4 "Viết hàm trả về một bảng gồm danh sách khách hàng có doanh số mua hàng cao nhất tính đến thời điểm này. 
ALTER FUNCTION b4 ()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 makh, SUM(doanhso) AS 'tongdoanhso'
    FROM Khachhang
    GROUP BY makh
    ORDER BY SUM(doanhso) DESC
)
select *from dbo.b4 () 
select *from khachhang

--5. Viết hàm trả về số lượng sản phẩm bán chạy nhất trong tháng 6/2019 
CREATE FUNCTION b5 (@TopN INT)
RETURNS TABLE 
as 
return
(
SELECT top (@TopN) masp , sum(soluong) AS num_sales
FROM cthd,hoadon
WHERE MONTH(ngayhd) = 6 AND YEAR(ngayhd) = 2019
and cthd.sohd=hoadon.sohd
group by masp
ORDER BY num_sales DESC 
)
CREATE FUNCTION b5 (@TopN INT)
RETURNS TABLE 
AS 
RETURN
(
    SELECT TOP (@TopN) sp.masp, SUM(cthd.soluong) AS num_sales
    FROM cthd 
    INNER JOIN hoadon ON cthd.sohd = hoadon.sohd
    INNER JOIN sanpham AS sp ON cthd.masp = sp.masp
    WHERE MONTH(hoadon.ngayhd) = 6 AND YEAR(hoadon.ngayhd) = 2019
    GROUP BY sp.masp
    ORDER BY num_sales DESC 
)




--BAI THUC HANH so 8 
--viết trigger thay đổi --giaban(cthd) , soluong(sanpham) , doanhso(khách hàng) , trigia(hóa đơn)


--bai1:Tạo Trigger ràng buộc soluong trong bảng Sanpham >= soluong nhập vào bảng CTHD(cùng mã hàng) 
-- on trong bang // CTHD // phu thuoc vao bang sanpham 
--de kiem tra ta INSERT 1 du lieu vao bang CTHD voi 
--so luong lon hon so luong sanpham trong bang SANPHAM

CREATE TRIGGER bb1
ON CTHD
FOR INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM Sanpham s JOIN inserted i ON s.MaSP = i.MaSP 
	           WHERE s.SoLuong < i.SoLuong)
    BEGIN
        print ('so luong san pham ko du')
        ROLLBACK TRANSACTION
    ENd
END

select *from sanpham
insert into CTHD values (10,'SL1',200,4000)
--bai 2 : Tạo Trigger không cho phép nhập vào bảng Sanpham những mặt hàng có số lượng <=10
CREATE TRIGGER bb2
ON sanpham
FOR INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM Sanpham s  WHERE s.SoLuong <= 10)
        print ('so luong san pham qua it ')
        ROLLBACK TRANSACTION
END 

insert into sanpham values('M1',N'mức',N'chua',N'CHINA',30000,8)

--3. Viết trigger khi sửa giá cho một (hoặc nhiều) masp thì in ra:  
-- Danh sách các masp vừa được sửa giá.  - Danh sách các masp vừa được sửa cùng giá cũ và giá mới 
CREATE TRIGGER bb3
ON Sanpham
after INSERT,DELETE ,update
AS
BEGIN
     select deleted.masp , deleted.gia as giacu ,inserted.gia as giamoi
	 from inserted,deleted
	 where inserted.masp=deleted.masp
END

select *from sanpham
update sanpham 
set gia=3900 where masp='B2'
delete from sanpham
where masp='B2'
AND masp='B3'
--4 : 4. Tạo Trigger không cho phép xóa những nhân viên có thâm niên trên 10 năm 
create trigger bb4
on nhanvien
after delete 
as 
   begin
        if exists (select *from deleted 
		where datediff(year,ngaylamviec,getdate())>10)
		print 'khong xoa nhanvien nay'
		rollback tran
end

delete from nhanvien
where manv='NV1'

--5. Viết trigger sao cho khi nhập soluong mua hàng ở bảng CTHD thì Trigia ở bảng 
--Hoadon và doanhso ở bảng Khachhang tự động cập nhật theo. 
create trigger bb5
on cthd 
after insert  
as begin
       --cap nhat bang hoadon -- inserted có the thay bang cthd 
       update hoadon 
	   set trigia=trigia+(soluong*giaban) from inserted i , hoadon hd where i.sohd=hd.sohd
 
       --cap nhat bang khachhang -- inserted có the thay bang cthd 
	   update khachhang
	   set doanhso=doanhso+(soluong*giaban) 
	   from inserted i join hoadon hd
	   on i.sohd=hd.sohd  join khachhang kh on hd.makh=kh.makh
end

--kiemtra bang cach nhap du lieu vao bang cthd 
SELECT *FROM khachhang
SELECT *FROM hoadon

--6 Tạo Trigger có nhiệm vụ sửa lại giaban trong bảng CTHD sao cho giaban=1.3*gia(gia trong bảng Sanpham) 
CREATE TRIGGER b6
ON CTHD
AFTER INSERT 
as
BEGIN
    UPDATE CTHD SET giaban = 1.3 * (SELECT gia FROM Sanpham ,inserted i WHERE Sanpham.masp = i.masp) 
	from sanpham,inserted
	WHERE inserted.masp = sanpham.masp
END
-- kiem tra
update sanpham set gia=2300 where masp='KH1'

select *from cthd where masp='KH1'	


--**********************

create trigger trg_insert_CTHD
  on CTHD
  for insert -- update -- delete
  as
--cập nhật giá bán cao hơn giá sản phẩm 20%
update cthd
  set giaban=gia+gia*0.2
  from sanpham
  where sanpham.masp=cthd.MASP

--cập nhật số lượng trong bảng sản phẩm (trừ đi 1 số lượng bán)
if (select soluong from inserted)> 
				(select sanpham.soluong from sanpham, inserted
					where sanpham.masp=inserted.masp)
	begin
		print N'Hết hàng'
		rollback tran
	end
else
update sanpham
  set sanpham.soluong=sanpham.soluong-
								(select soluong from inserted)
  from inserted
  where inserted.MASP=sanpham.masp


-- Cập nhật trị giá hóa đơn
update hoadon
	set trigia=(select SUM(soluong*giaban) from CTHD
				where sohd=(select sohd from inserted))
	where sohd=(select sohd from inserted)


--ràng buộc 1 đơn hàng chỉ có tối đa 4 sản phẩm
-- sanpham co masp phải có cùng sohd <= 4 
if (select COUNT(cthd.masp) from CTHD, inserted 
	where cthd.sohd=inserted.sohd
	group by cthd.sohd)>4
    begin
         print 'don du 4 sp roi'
    rollback tran
end
-- cach kiemtra : 1 hoa don chi co toi da 4 masp ...
select *from sanpham
select *from cthd	


--cập nhật doanh số của khách hàng
update khachhang set doanhso = (select sum(trigia) 
from hoadon where khachhang.makh=hoadon.makh group by makh ) 
-- khi có dấu toán tử = , < , >= .... thi phai lệnh where (lệnh điều kiện)

update khachhang
	set doanhso=ctds.doanhso
	from (select makh, sum(trigia) as doanhso from hoadon group by(makh)) as ctds
	where khachhang.makh=ctds.makh

	select *from khachhang



