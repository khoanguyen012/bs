use BANSACH
go

select * from Admin
select * from CTDATHANG
select * from DONDATHANG
select * from CTTHAMDO
select * from CHUDE

select * from KHACHHANG
select * from NHAXUATBAN
select * from SACH
select * from VIETSACH
select * from TACGIA
go
SET IDENTITY_INSERT [dbo].[SACH] on
go
Create Proc NHAPSACH  @Masach int, 
                         @Tensach nvarchar(100), 
						 @Donvitinh nvarchar(50), 
						 @Dongia money, 
						 @MaTG1 int,
						 @MaTG2 int
As
Begin
if not exists(select * from TACGIA where MaTG=@MaTG1)
   raiserror ('Tac gia nay khong ton tai,',16,1)
  else if exists (select * from SACH where Masach=@Masach)
    raiserror ('Trung khoa chinh,',16,1)
  else
     begin
	    insert into SACH (MaSach,TenSach,Donvitinh,Dongia)
		values(@Masach,@Tensach,@Donvitinh,@Dongia)
		insert into VIETSACH (MaTG,Masach)
		values(@MaTG1,@Masach)
		insert into VIETSACH (MaTG,Masach)
		values(@MaTG2,@Masach)
	end
End
go
--
exec NHAPSACH '25',N'Sách A',N'Cuốn','18000','1','2'
exec NHAPSACH '26',N'Sách B',N'Cuốn','20000','2','3'



Create Proc NHAPDONHANG @SoDH int,
                        @MaKH int,
                        @Masach1 int,
						@Masach2 int,
						@Soluong1 int,
						@Soluong2 int,
						@Dongia1 money,
						@Dongia2 money
As
Begin
   Insert into DONDATHANG(SoDH,MaKH)
   values(@SoDH,@MaKH)
   Insert into CTDATHANG(SoDH,Masach,Soluong,Dongia)
   values(@SoDH,@Masach1,@Soluong1,@Dongia1)
   Insert into CTDATHANG(SoDH,Masach,Soluong,Dongia)
   values(@SoDH,@Masach2,@Soluong2,@Dongia2)
End
go

SET IDENTITY_INSERT [dbo].[DONDATHANG] ON
SET IDENTITY_INSERT [dbo].[KHACHHANG] ON 

drop proc NHAPDONHANG
go

exec NHAPDONHANG '6','23','2','6',1,2,'50000','60000'



