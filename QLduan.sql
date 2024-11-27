Create database Quanlyduan
go
use quanlyduan
go
create table phongban
(Maphong char(5) primary key,
tenphong nvarchar(30) null,
sodt char(10) null)
go
Create table duan
(maduan char(5) primary key,
tenduan nvarchar(30) null,
diadiem nvarchar(30) null,
maphong char(5) foreign key references phongban(maphong) on delete cascade on update cascade,
)
go
Create table nhanvien
(manv char(5) primary key,
holot nvarchar(30) null,
ten nvarchar(15) null,
gioitinh bit null,
ngaysinh date null,
diachi nvarchar(30) null,
luong int null,
maphong char(5)foreign key references phongban(maphong) on delete cascade on update cascade,
)
go
Create table phancong
(manv char(5) foreign key references nhanvien(manv),--on delete cascade on update cascade,
maduan char(5)foreign key references duan(maduan)on delete cascade on update cascade,
sogio float null,
primary key (manv, maduan))
go


insert into phongban
values(1, N'Big Data', '0256789012')
insert into phongban
values(2, N'Xử lý ngôn ngữ tự nhiên','0278901234')
insert into phongban
values(3, N'Phát triển phần mềm','0876594323')
insert into phongban
values(4, N'Marketing', '0987689067')
insert into phongban
values(5, N'Kế toán','0745734890')
insert into phongban
values(6, N'Truyền thông','0134325678')
insert into phongban
values(7, N'Dự án 1','0634325679')
insert into phongban
values(8, N'Dự án 2','0834933679')
insert into phongban
values(9, N'Dự án 3','0834933622')
go
insert into duan
values(1, N'Sản phẩm X',N'Quy Nhơn',1)
insert into duan
values(2, N'Sản phẩm Y',N'Nha Trang',2)
insert into duan
values(3, N'Sản phẩm Z',N'TP.HCM',3)
insert into duan
values(10, N'Tin học hóa',N'Bình Dương',4)
insert into duan
values(4, N'Nhận diện khuôn mặt',N'Bình Định',4)
insert into duan
values(5, N'Nhà thông minh',N'Bình Định',2)
insert into duan
values(6, N'Bãi đậu xe thông minh',N'Bình Phước',1)
insert into duan
values(7, N'Thư viện số',N'Dak Lak',4)
insert into duan
values(8, N'Sổ tay điện tử',N'Bình Định',6)
insert into duan
values(9, N'Quản lý nhân sự',N'Bình Định',5)
insert into duan
values(10, N'Quản lý bệnh nhân',N'Bình Định',4)

select *from duan
go
insert into nhanvien
values('mv1', N'Nguyễn Minh',N'Tâm', 1, '1/4/1988', N'Bình Định', 4000,1)
insert into nhanvien
values('mv2', N'Nguyễn Ngọc',N'Bích', 0, '10/9/1984', N'Phú Yên', 2000,2)
insert into nhanvien
values('mv3', N'Hồ Văn',N'Tâm', 1, '11/9/1986', N'Gia Lai', 5000,3)
insert into nhanvien
values('mv4', N'Lê Minh',N'Thành', 1, '2/14/1987', N'Quảng Ngãi', 3000,2)
insert into nhanvien
values('mv5', N'Nguyễn Thị',N'Thắm', 0, '10/4/1980', N'Bình Dương', 6000,5)
insert into nhanvien
values('mv6', N'Trần Thị',N'Hoa', 0, '1/4/1975', N'Bình Phước', 6000,6)
insert into nhanvien
values('mv7', N'Lê Văn',N'Nam', 1, '8/4/1985', N'Bình Phước', 6000,7)
insert into nhanvien
values('mv8', N'Hồ Ngọc',N'Hà', 0, '9/5/1995', N'Bình Dương', 5000,7)
insert into nhanvien
values('mv9', N'Nguyễn Kim',N'Kha', 1, '6/8/1991', N'Bình Dương', 5000,8)
insert into nhanvien
values('mv10', N'Nguyễn Ngọc',N'Hoa', 0, '7/8/1990', N'Bình Định', 5000,9)
go
select *from phancong
insert into phancong
values('mv1',1,30.0)
insert into phancong
values('mv2',2,8.0)
insert into phancong
values('mv3',3,15.0)
insert into phancong
values('mv4',1,20.0)
insert into phancong
values('mv5',3,25.0)
insert into phancong
values('mv1',4,25.0)
insert into phancong
values('mv2',6,25.0)
insert into phancong
values('mv1',5,25.0)
insert into phancong
values('mv2',4,20.0)

insert into phancong
values('mv3',6,20.0)


--Phần 1. Dùng câu lệnh SQL để tạo các truy vấn sau:
--1. Xem thông tin dự án số 1 và dự án số 3
select *from duan
where maduan=1 and maduan=3
--2. Cho biết 3 dự án nào có số giờ ít nhất
select top 3 duan.maduan,sum(sogio) as sogio1
from duan,phancong
where duan.maduan=phancong.maduan
group by duan.maduan 
order by sogio1 asc

--3. Hiển thị danh sách những nhân viên có lương thấp nhất.
select top 1 manv,ten,luong as tongluong
from nhanvien
group by manv,ten,luong
order by tongluong asc

--4. Cho biết mỗi nhân viên tham gia bao nhiêu dự án, nhân viên không tham gia dựán nào thì kết quả là 0.
select nv.manv,ten,count(phancong.manv) as soduan 
from nhanvien as nv right join phancong
on nv.manv=phancong.manv
group by nv.manv,ten

--5. Xóa dự án có tổng số giờ dưới 50?
delete from duan
where maduan in (select maduan from phancong group by maduan having sum(sogio)<50)

--6. Cho biết phòng ban nào chưa có dự án?
select phongban.maphong,tenphong,count(maduan) as soduan
from phongban,duan
where phongban.maphong=duan.maphong
group by phongban.maphong,tenphong
having count(maduan) = 0
--7. Xem thông tin phòng ban có 2 nhân viên trở lên và thực hiện 3 dự án trở lên.
select phongban.maphong,tenphong,count(manv),count(maduan)
from phongban,nhanvien,duan
where phongban.Maphong=nhanvien.maphong
and phongban.Maphong=duan.maphong
group by phongban.maphong,tenphong
having count(manv)>2 and count(maduan)>3
--Phần 2.
--1. Viết hàm nhập vào mã nhân viên X (X là tham số), hàm sẽ in ra tổng số giờthực hiện dự án của nhân viên đó
alter FUNCTION b1(@x nvarchar(20))
RETURNS float
as
BEGIN
    declare @tongsogio float 
    SELECT @tongsogio=sum(sogio) 
	from phancong where manv=@x --group by manv
	return @tongsogio
END
select *from phancong
select dbo.b1('mv1') as 'tongsogio'
--2. Viết thủ tục nhập vào mã dự án X (X là tham số), thủ tục in ra ngày hoàn thành
--dự án, biết rằng ngày hoàn thành dự án=ngày hôm nay+số giờ
create proc b2 
(@x nvarchar(20))
as
  begin 
  select dateadd(hour,sogio,getdate())
  from phancong 
  where @x=maduan
end

exec b2 1



--Phần 3. Viết trigger không cho phép một dự án có nhiều hơn 5 nhân viên thực hiện.
--Nghĩa là khi nhập vào bảng phân công, nếu dự án đã phân công nhiều hơn 5 nhân
--viên thì không cho phép nhập  

CREATE TRIGGER p3
ON phancong
for INSERT
AS
BEGIN
      IF (SELECT COUNT(*) FROM phancong p , inserted  WHERE p.manv = inserted.manv) > 5
-- or  IF (SELECT COUNT(p.maduan) FROM phancong p ,inserted WHERE p.manv = inserted.manv AND p.maduan <> inserted.maduan) > 5
        print ('ko cho phep nhap')
        ROLLBACK TRANSACTION
END


--1. Hiển thị thông tin những dự án ở Nha Trang hoặc Bình Phước?
select *from duan 
where diadiem like N'Nha Trang' or diadiem like N'Bình Phước'

--2. Hiển thị danh sách nhân viên phòng Phát triển phần mềm, nhỏ hơn 25 tuổi?
select ten,manv from nhanvien,phongban
where tenphong like N'Phát triển phần mềm'
and year(getdate())-year(ngaysinh) > 25
and nhanvien.maphong=phongban.maphong 

--3. Thống kê số lượng nhân viên theo mã phòng?
select phongban.maphong , count(manv)
from phongban,nhanvien
where phongban.maphong=nhanvien.maphong
group by phongban.maphong

--4. Hiển thị danh sách những nhân viên có lương cao nhất?
select top 1 ten,manv,luong
from nhanvien 
order by luong desc

--5. Hãy cho biết tổng số giờ của mỗi dự án?
select duan.maduan , sum(sogio)
from phancong , duan
where phancong.maduan=duan.maduan
group by duan.maduan 
select *from phancong
--6. Tăng lương thêm 200000 cho những nhân viên tham gia 2 dự án trở lên
update nhanvien 
set luong=luong+200000
where manv in (select manv
from nhanvien,duan,phongban
where nhanvien.maphong=phongban.maphong
and phongban.maphong=duan.maphong
group by manv 
having count(duan.maduan) >= 2)

select *from nhanvien
--7. Cho biết có bao nhiêu dự án ở Bình Định ?
select diadiem , count(maduan)
from duan 
where diadiem like N'Bình Định'
group by diadiem 

--8. Hiển thị danh sách nhân viên nam (gioitinh=1), trên 30 tuổi
select ten,manv
from nhanvien 
where gioitinh=1 
and year(getdate())-year(ngaysinh) > 30
--9. Hiển thị danh sách các dự án ở Bình Định, có số giờ > 20 
select tenduan,sogio from duan,phancong as p 
where duan.maduan=p.maduan
and sogio > 20 

--10. Thống kê số dự án theo mã phòng, phòng nào chưa nhận dự án thì sẽ cho kết quả là 0.
select p.maphong,count(maduan) 
from duan right join phongban as p
on p.maphong=duan.maphong
group by p.maphong 
--11. Hiển thị thông tin những dự án có số giờ (sogio) thực hiện nhiều nhất?
select top 1 tenduan,sogio
from duan , phancong as p
where duan.maduan=p.maduan
order by sogio desc

--12. Cho biết mỗi dự án bao nhiêu nhân viên tham gia?
select tenduan , count(manv)
from duan,nhanvien,phongban
where duan.maphong=phongban.maphong
and nhanvien.maphong=phongban.maphong
group by tenduan

--13. Liệt kê danh sách nhân viên không tham gia dự án nào?
select ten,manv
from nhanvien where manv not in(select manv from phancong)

--14. Xóa những dự án chưa phân công cho ai
--nghia la duan do khong co nhanvien 
delete from duan
where maduan not in(select maduan from phancong)  

--15. Xem danh sách nhân viên quê ở Quy Nhơn, làm dự án ở Bình Dương?
select ten,manv 
from duan,nhanvien,phongban
where duan.maphong=phongban.maphong
and nhanvien.maphong=phongban.maphong
and diachi like N'Bình Dương'
and diadiem like N'Bình Định'

--16. Cập nhật cột lương nhân viên = lương hiện có + sogio*500 (sogio trong bảng phancong)
update nhanvien 
set luong=luong + (sogio*500)
from phancong , nhanvien 
where phancong.manv=nhanvien.manv 

select *from nhanvien 

--17. Hiển thị thông tin dự án số 1 (maduan=1): Tên dự án, địa điểm, ai tham gia,phòng nào quản lý?
select tenduan,diadiem,ten,manv,tenphong 
from duan,nhanvien,phongban
where duan.maphong=phongban.maphong
and nhanvien.maphong=phongban.maphong
and maduan=1

--18. Xem thông tin những nhân viên chưa được phân công vào dự án nào
-- nghia la manv khong nam trong bat cu maduan nao cua bang phancong
SELECT ten,manv FROM nhanvien 
WHERE manv NOT IN (SELECT manv FROM phancong)

--19. Cho biết phòng nào đảm nhận nhiều dự án nhất
select top 1 tenphong,count(maduan)
from duan,phongban
where duan.maphong=phongban.Maphong
group by tenphong
order by count(maduan) desc

--vì có hàm count nên mới dùng thêm hàm GROUP BY 

--20. In ra những dự án có 1 nhân viên tham gia
select tenduan,maduan,count(manv) 
from duan,nhanvien n,phongban p
where n.maphong=p.Maphong
and p.Maphong=duan.maphong
group by tenduan,maduan
having count(manv)=1

--21. Liệt kê các dự án của phòng Big Data?
select tenduan from duan,phongban p
where p.Maphong=duan.maphong
and tenphong like N'Big Data'

--22. Xem thông tin dự án số 1 và dự án số 3
select *from duan
where maduan in ('1','3')

--cách 2 ---------------------------
SELECT * FROM DUAN WHERE MaDuAn = '1'
UNION
SELECT * FROM DUAN WHERE MaDuAn = '3'

--23. Cho biết 3 dự án nào có số giờ ít nhất
select top 3 tenduan,sogio
from duan , phancong p 
where duan.maduan=p.maduan
order by sogio asc  

--24. Hiển thị danh sách những nhân viên có lương thấp nhất.
select *from nhanvien
order by luong asc

--25.Cho biết mỗi nhân viên tham gia bao nhiêu dự án,nhân viên không tham gia dự án nào thì kết quả là 0.
select ten,manv,count(maduan)
from nhanvien left join phongban left join duan
on duan.maphong=phongban.maphong
on nhanvien.maphong=phongban.maphong
group by ten,manv 

--26. Xóa dự án có tổng số giờ dưới 50?
delete from duan 
where maduan in (select maduan from phancong group by maduan having sum(sogio) < 10)

--27. Cho biết phòng ban nào chưa có dự án?
select tenphong
from phongban 
where maphong not in (select maphong from duan)

--28. Xem thông tin phòng ban có 2 nhân viên trở lên và thực hiện 3 dự án trở lên.
--ko the dung 1 ten cot cho 2 count 

SELECT PHONGBAN.Maphong, PHONGBAN.tenphong
FROM PHONGBAN
WHERE PHONGBAN.Maphong IN
(SELECT NHANVIEN.maphong FROM NHANVIEN GROUP BY NHANVIEN.maphong HAVING COUNT(manv) >= 1)
AND PHONGBAN.Maphong IN 
(SELECT duan.maphong FROM duan GROUP BY duan.maphong 
HAVING COUNT(maduan) >= 2)


--Phần 2:
--1. Viết thủ tục nhập vào mã dự án bất kỳ (maduan là tham số), thủ tục sẽ in ra
create procedure bai1
@x nvarchar(20)
as begin
        select tenduan,tenphong
		from duan,phongban
		where duan.maphong=phongban.Maphong
		and maduan=@x 
end
exec bai1 1
--thông tin về dự án đó (tên dự án, phòng nào đảm nhận, số giờ thực hiện).

--2. Viết hàm trả về tổng số dự án do phòng X đảm nhận (X là mã phòng, X là tham số của hàm)
create function bai2(@x int)
returns int 
as begin 
         declare @tongduan int 
         select @tongduan=count(maduan)
		 from duan,phongban
		 where duan.maphong=phongban.Maphong
		 and phongban.maphong=@x
		 return @tongduan
end 

select dbo.bai2(1)
--3. Viết thủ tục nhập vào mã nhân viên bất kỳ (manv là tham số), thủ tục sẽ in ra
--thông tin của nhân viên đó (tên nhân viên, phòng ban nào, tham gia dự án nào).
create procedure bai3
@x nvarchar(20)
as begin 
         select ten,manv,tenphong,tenduan
		 from duan,phongban,nhanvien 
		 where duan.maphong=phongban.Maphong
		 and phongban.Maphong=nhanvien.maphong
		 and manv=@x
end 
exec bai3 mv2
--4. Viết hàm trả về tổng số giờ của 1 dự án X (X là mã dự án, X là tham số của hàm)
create function bai4(@x int)
returns int 
as begin 
        declare @tongsogio int 
		select @tongsogio=sum(sogio)
		from phancong,duan
		where duan.maduan=phancong.maduan
		and duan.maduan=@x 
		return @tongsogio
end 
select dbo.bai4(3)
--5 Viết hàm nhập vào mã nhân viên X (X là tham số)hàm sẽ trả về tổng số dựán mà nhân viên đó tham gia.
alter function bai5(@x nvarchar(20))
returns int 
as begin
        declare @tongduan int 
		select @tongduan=count(maduan) 
		from duan,phongban,nhanvien 
		where duan.maphong=phongban.Maphong
		and phongban.Maphong=nhanvien.maphong 
		and manv=@x group by manv 
		return @tongduan 
end
select dbo.bai5('mv1') AS N'TỔNG DỰ ÁN'

--6. Viết thủ tục nhập vào mã phòng X (X là tham số), thủ tục in ra thông tin của
--phòng và các dự án mà phòng đó đảm nhận.
create procedure bai6 (@x nvarchar(10))
as begin 
         select tenphong,tenduan
		 from duan,phongban
		 where duan.maphong=phongban.Maphong
		 and phongban.maphong=@x 
end
exec bai6 1
--7. Viết hàm nhập vào mã nhân viên X (X là tham số), hàm sẽ in ra tổng số giờ
--thực hiện (tất cả) dự án của nhân viên đó.
GIONG BAI 4 

--8. Viết thủ tục nhập vào mã dự án X (X là tham số), thủ tục in ra ngày hoàn thành
--dự án, biết rằng ngày hoàn thành dự án=ngày hôm nay+số giờ
alter procedure bai8(@x nvarchar(10))
as begin 
		declare @tongsogio int
		select @tongsogio=sum(sogio) from phancong where maduan=@x 
        select DATEADD(hour,@tongsogio,GETDATE()) as N'ngày hoàn thành'
end 


exec bai8 4 


Phần 3.
--1. Viết trigger không cho phép một nhân viên thực hiện quá 3 dự án. Nghĩa là khi nhập dữ liệu
--vào bảng Phancong, nếu manv đó đã phân đủ 3 dự án thì không cho phép phân công nữa.
create trigger bai11
on phancong 
for insert 
as begin 
        if exists (select manv,count(maduan)
		          from inserted 
		          group by manv
		          having count(manv) > 2)
		    print('so luong duan cua 1 nhanvien da du')
			rollback tran 
end

(select manv,count(maduan)
		          from phancong
		          group by manv
		          having count(manv) > 2)
				  
insert into phancong
values('mv4',6,20.0)
--2. Viết trigger không cho phép xóa dự án ở Bình Dương. Nghĩa là khi xóa 1 dự
--án, nếu địa điểm là Bình Dương thì không cho xóa.
create trigger bai22
on duan
for delete  
as begin
        if exists(select tenduan from deleted where diadiem like N'Bình Dương')
		begin 
		    print('ko the xoa')
		rollback tran 
		end
end 

delete from duan 
where diadiem like N'Bình Dương'
delete from duan 
where diadiem like N'Bình Định'
select * from duan 
--3. Viết trigger không cho phép thêm dự án ở DakNong. Nghĩa là khi thêm 1 dự
--án, nếu địa điểm là DakNong thì không cho phép thêm.
create trigger bai33
on duan
after insert 
as begin 
        if exists (select *from inserted where diadiem like N'DakNong')
		begin 
		    print('ko cho phep them')
			rollback tran 
		end
end
--4. Viết trigger không cho phép một dự án có nhiều hơn 5 nhân viên thực hiện.Nghĩa là khi nhập 
--vào bảng phân công, nếu dự án đã phân công nhiều hơn 5 nhân viên thì không cho phép nhập.
create trigger bai44
on phancong
for insert 
as begin 
        if exists (select i.maduan--,count(i.manv)
		           from inserted  i, phancong
				   where i.manv=phancong.manv-- doi luc can viet 2 bang phancong va inserted 
				   group by i.maduan         -- where i.maduan=p.maduan
				   having count(i.manv) > 5)
		begin 
		     print('duan da du nhanvien')
		rollback tran 
		end
end

--IF EXISTS (SELECT * FROM ten_bang WHERE ma_du_an IN (SELECT ma_du_an FROM inserted) 
--GROUP BY ma_du_an HAVING COUNT(ma_nhan_vien) > 5)  chi dung khi maduan khong dung nam trong cha 
--nghia la can nhap du lieu tu bang nay thi bang kia on____ moi nhan du lieu 
select case @tongmonhoc=count(mamh) when @tongmonhoc=count(mamh) >= 3 then 'nhieu mon hoc'
                                    else 'binh thuong'
from tenbang
group by maphonghoc 
