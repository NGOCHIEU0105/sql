alter table phidoxe
alter column tgketthuc time
go
alter table phidoxe
alter column tgbatdau time
go
alter table khuvuc
alter column makv varchar(10) not null
go
alter table khuvuc
add constraint ph_kv primary key (makv)
go
alter table loaixe
alter column malx varchar(10) not null
go
alter table loaixe
add constraint pk_lx primary key (malx)
go
alter table loaixe
alter column makv varchar(10) not null
go
alter table loaixe
add constraint fk_lx foreign key (makv)
references khuvuc(makv) on delete cascade on update cascade
go
alter table nhanvien
alter column manv varchar(10) not null
go
alter table nhanvien
add constraint pk_nv primary key (manv)
go
alter table phidoxe
alter column maphi varchar(10) not null
go
alter table phidoxe
add constraint pk_phdx primary key (maphi)
go
alter table NHATKYdoxe
alter column maDX varchar(10) not null
go
alter table NHATKYdoxe
add constraint pk_NKDX primary key (maDX)
GO
alter table NHATKYdoxe
alter column maLX varchar(10) not null
go
alter table NHATKYdoxe
alter column manv varchar(10) not null
go
alter table NHATKYdoxe
alter column maphi varchar(10) not null
go
alter table NHATKYdoxe
add constraint fk_mlx foreign key (malx)
references loaixe(malx) on delete cascade on update cascade
go
alter table NHATKYdoxe
add constraint fk_nv foreign key (manv)
references nhanvien(manv) on delete cascade on update cascade
go
alter table NHATKYdoxe
add constraint fk_mp foreign key (maphi)
references phidoxe(maphi) on delete cascade on update cascade
go

--1a
CREATE VIEW V_Doxe AS
SELECT *
FROM NHATKYDOXE
WHERE DATEDIFF(mi,TGVao,TGRA) > 120 AND 
MaLX IN (
    SELECT MaLX
    FROM LOAIXE
    WHERE TENLX = 'Xe bốn bánh' )

select datepart(day,tgra) from NHATKYDOXE
--1b
UPDATE V_Doxe
SET TGVao = '8:00'
WHERE TGVao = '7:30'

--2a
CREATE PROCEDURE Sp_1
    @MaNV varchar(10)
AS
BEGIN
    DELETE FROM NHANVIEN WHERE MaNV = @MaNV
END
--2b
CREATE PROCEDURE Sp_2
    @MADOXE NVARCHAR(100),
	@MAPHI NVARCHAR(100),
    @BienSo varchar(10),
    @MaLoaiXe varchar(10),
    @TGVao datetime,
    @TGRa datetime,
    @MaNV varchar(10)
AS
BEGIN
    IF EXISTS (SELECT * FROM LOAIXE WHERE MaLX = @MaLoaiXe) 
	AND EXISTS (SELECT * FROM NHANVIEN WHERE MaNV = @MaNV)
    BEGIN
        INSERT INTO NHATKYDOXE(MADX,MaPhi,BIENSOXE, MALX, TGVao, TGRa, MaNV)
        VALUES (@MADOXE,@MAPHI,@BienSo, @MaLoaiXe, @TGVao, @TGRa, @MaNV);
    END
END 

SELECT * FROM NHATKYDOXE

INSERT INTO NHATKYDOXE(MADX,MaPhi,BienSoXe, MALX, TGVao, TGRa, MaNV)
VALUES('DX005','P03','29DJ','LX02','2019/3/4','2022/1/9 8:23:12','NV001')

--3A Trigger_1: Thực hiện đăng ký mới một lượt đỗ xe thì hiển thị tổng số lượt đỗ xe của tất cả
--các xe cùng loại với xe cần đỗ.
CREATE TRIGGER Trigger_1
ON NHATKYDOXE 
AFTER INSERT -- Thay cho lệnh if insert (malx)
AS
BEGIN
    SELECT COUNT(*) AS TONG
    FROM NHATKYDOXE 
    WHERE  MaLX = (SELECT MaLX FROM inserted)
END

--CACH KIEMTRA
INSERT INTO NHATKYDOXE VALUES 
('DX004','LX03','NV002','P02','75U-3211','2014/2/6 8:22','2014/2/6 9:22')

--3B
CREATE TRIGGER Trigger_2
ON NHATKYDOXE	
AFTER UPDATE
AS
BEGIN
    IF UPDATE(TGVao) OR UPDATE(TGRa)
    BEGIN
        IF EXISTS (SELECT * FROM NHATKYDOXE WHERE DATEDIFF(MI,TGVAO,TGRA) < 15)

            PRINT ('Thời gian ra phải lớn hơn thời gian vào ít nhất 15 phút')
            ROLLBACK TRAN
    END
END
                                
--4A
CREATE FUNCTION func1 
(@MaLoaiXe NVARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @SoNhanVien INT
    SELECT @SoNhanVien = COUNT(MaNV) FROM NHATKYDOXE WHERE MaLX = @MaLoaiXe
    RETURN @SoNhanVien
END

SELECT DBO.func1('LX03')

--4B
CREATE FUNCTION func2 (@BIENSOXE NVARCHAR(100))
RETURNS INT
AS
BEGIN
    DECLARE @MaxFee INT
    SELECT @MaxFee = MAX(MUCPHI) FROM PHIDOXE,NHATKYDOXE WHERE BienSoXe = @BIENSOXE
	AND PHIDOXE.MAPHI=NHATKYDOXE.MAPHI
    RETURN @MaxFee
END

SELECT DBO.func2('75U-36584')

select datediff(ms,TGVao,TGRa) 
from NHATKYDOXE 
select *from NHATKYDOXE

--bai 5
create proc bb5 
@mota nvarchar(20) 
as
begin
      delete from loaixe where mota like @mota

	  DELETE FROM PHIDOXE WHERE MoTa  like @mota

	  UPDATE PHIDOXE 
	  SET MoTa = N'cần điều chỉnh'
	  where MoTa like @mota
end

exec bb5 '%ô tô%'




--1.Tính tiền trả phí đỗ xe cho Madx 'Dx001'
select datediff(hour,tgvao,tgra) * MucPhi as N'phí đỗ xe'
from phidoxe,nhatkydoxe
where PHIDOXE.maphi=NHATKYDOXE.maphi
and madx='Dx001'

--2. Thay đổi loại xe hai bánh có động cơ sang Khu vực Kv02
update LOAIXE
set makv='kv02'
where TenLX like N'xe hai bánh có động cơ'

select *from LOAIXE
--3. Nếu xe 43H-03941 gửi 25 ngày thì ngày lấy xe là ngày nào?
select biensoxe,dateadd(day,25,tgvao) as N'ngày lấy xe'
from NHATKYDOXE
where BienSoXe='43H-03941'

--4. Xe nào gửi nhiều ngày nhất
select top 1 malx,datediff(day,tgvao,tgra) 
from NHATKYDOXE
group by malx,tgvao,tgra
order by datediff(day,tgvao,tgra) desc
--5. Xóa nhật ký những xe ra ngày hôm nay
delete from NHATKYDOXE
where TGRa=getdate()
--6.Viết thủ tục tìm kiếm thông tin xe có biển số X
create proc bai666
(@x nvarchar(20))
as begin 
        select tenlx,loaixe.malx 
		from NHATKYDOXE,LOAIXE
		where NHATKYDOXE.malx=LOAIXE.malx
		and BienSoXe=@x
end 
exec bai666 '43H-03941'
--7. Viết trigger không cho xe gửi quá 3 tháng mà không lấy xe ra lần nào
create trigger bai777
on nhatkydoxe
for insert 
as begin 
        if exists (select malx,datediff(month,tgvao,tgra)
		           from NHATKYDOXE group by MaLX,tgvao,tgra having datediff(month,tgvao,tgra) >3)
        print('ko cho phep xe gui qua 3 thang')
		rollback tran 
end 

