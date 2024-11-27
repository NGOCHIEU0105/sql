create database CONGTAC
USE CONGTAC

--tao bang nhanvien
create table nhanvien
(manv nvarchar(20) constraint mm primary key ,
tennv nvarchar(20) ,
ngaysinh date constraint ngay_sinh check (18<=year(getdate())-year(ngaysinh) and year(getdate())-year(ngaysinh)<=40),
gioitinh bit )

--tao bang dotcongtac
create table dotcongtac
(madot nvarchar(20) constraint nnn primary key ,
ngaydi date constraint nve_ndi unique ,
ngayve date )

--tao bang thamgiacongtac
create table thamgiacongtac
(madot nvarchar(20) ,
manv nvarchar(20) ,
phicongtac float default(0) ,
constraint nv_dot primary key(madot,manv))
--them rang buoc 
alter table thamgiacongtac add constraint fk1 foreign key(madot) references dotcongtac(madot) 
on delete cascade on update cascade

alter table thamgiacongtac add constraint fk2 foreign key(manv) references nhanvien(manv) 
on delete cascade on update cascade

--nhap du lieu cho 3 bang 
insert into nhanvien values('NV1',N'Lê Ân Thiên','2001/3/18',1)
insert into nhanvien values('NV2',N'Trần Văn Thiên','1998/3/21',0)
insert into nhanvien values('NV3',N'Nguyễn Minh Cường','2001/8/12',0)
insert into nhanvien values('NV4',N'Trần Văn Mẫn','1993/9/11',1)
insert into nhanvien values('NV5',N'Ngô Gia Hiệp','2002/12/1',0)
select *from nhanvien


insert into dotcongtac values('D1','2023/4/3','2023/4/5')
insert into dotcongtac values('D2','2019/3/8','2023/4/5')
insert into dotcongtac values('D3','2020/12/3','2022/1/17')
insert into dotcongtac values('D4','2021/5/8','2021/7/19')
insert into dotcongtac values('D5','2022/12/9','2023/8/5')
select *from dotcongtac


insert into thamgiacongtac(madot,manv) values ('D1','NV1')
insert into thamgiacongtac(madot,manv) values('D2','NV2')
insert into thamgiacongtac(madot,manv) values('D3','NV3')
insert into thamgiacongtac(madot,manv) values('D4','NV4')
insert into thamgiacongtac(madot,manv) values('D5','NV5')
select *from thamgiacongtac

--cau 2
--a. 
UPDATE thamgiacongtac
SET phicongtac = DATEDIFF(day, ngaydi, ngayve) * 120000 
FROM dotcongtac WHERE thamgiacongtac.madot = dotcongtac.madot

select  *from thamgiacongtac

UPDATE thamgiacongtac
SET phicongtac = case when ngaydi=ngayve then 1 
else convert(int,convert(datetime,ngayve)-convert(datetime,ngaydi)) *120000 end
FROM dotcongtac WHERE thamgiacongtac.madot = dotcongtac.madot

--b.  danh sách những nhân viên nữ đi công tác ngày 8/3.
select nhanvien.manv,tennv 
from nhanvien,dotcongtac,thamgiacongtac as t
where nhanvien.manv=t.manv
and t.madot=dotcongtac.madot
and gioitinh=0
and month(ngaydi)=3 and day(ngaydi)=8

--c. cho biết thông tin những nhân viên có phí đi công tác cao nhất 
select nv.manv,tennv,sum(phicongtac)
from nhanvien as nv,thamgiacongtac
where nv.manv=thamgiacongtac.manv
group by nv.manv,tennv
having sum(phicongtac)>=all(select sum(phicongtac)
from nhanvien as nv,thamgiacongtac
where nv.manv=thamgiacongtac.manv
group by nv.manv,tennv)

select nv.manv,tennv 
from thamgiacongtac,nhanvien nv
where phicongtac = (select max(phicongtac) from thamgiacongtac)
and  thamgiacongtac.manv=nv.manv

select top 1 nv.manv,tennv,max(phicongtac)
from nhanvien nv,thamgiacongtac
where nv.manv=thamgiacongtac.manv
group by nv.manv,tennv
order by max(phicongtac) desc 

--d. những đợt đi công tác có số ngày dưới 5
SELECT madot,ngayve,ngaydi,DATEDIFF(day, ngaydi, ngayve) as N'số ngày đi CT'
FROM dotcongtac
group by madot,ngayve,ngaydi
HAVING DATEDIFF(day, ngaydi, ngayve) <= 5

--e. Tăng phí công tác lên 20% cho nhân viên có tên là trần văn mẫn
update thamgiacongtac
set phicongtac=phicongtac+phicongtac*0.2
from thamgiacongtac,nhanvien
where tennv like N'Trần Văn Mẫn'
and thamgiacongtac.manv=nhanvien.manv

select *from thamgiacongtac