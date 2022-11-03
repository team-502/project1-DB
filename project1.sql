CREATE database PhanMem_BanGiay_Limited
GO
use PhanMem_BanGiay_Limited
GO

-- Sản Phẩm
create table SanPham(
Id UNIQUEIDENTIFIER Primary KEY DEFAULT NEWID(),
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(100)
)

-- Màu Sắc
create table MauSac(
    Id UNIQUEIDENTIFIER primary key DEFAULT newid(),
    Ma VARCHAR(20) UNIQUE,
    Ten NVARCHAR(20)
)

-- Chất Liệu
create table DongSP(
    Id UNIQUEIDENTIFIER primary key DEFAULT newid(),
    Ma varchar(20) UNIQUE,
    Ten NVARCHAR(50)
) 

-- Nhà Sản Xuất (Hãng)
create table NSX(
    Id UNIQUEIDENTIFIER primary key DEFAULT newId(),
    Ma VARCHAR(20) UNIQUE,
    Ten NVARCHAR(100)
)

-- Sản Phẩm Chi Tiết
create table ChiTietSanPham(
Id UNIQUEIDENTIFIER primary key default newid(),
IdSP UNIQUEIDENTIFIER,
IdMauSac UNIQUEIDENTIFIER,
IdDongSP UNIQUEIDENTIFIER,
IdNSX UNIQUEIDENTIFIER,
XuatXu NVARCHAR(50) DEFAULT null,
Size int,
SoLg int,
--vitri,
MoTa NVARCHAR(100) DEFAULT null,
NgayN date DEFAULT null,
GiaN DECIMAL(20,0) default 0,
GiaB Decimal(20,0) DEFAULT 0
)

-- Hoá Đơn
create table HoaDon(
    Id UNIQUEIDENTIFIER primary key DEFAULT newid(),
    IdKh UNIQUEIDENTIFIER,
    IdNv UNIQUEIDENTIFIER,
    Ma varchar(20) UNIQUE,
    NgayTao date DEFAULT null,
    NgayThanhToan date DEFAULT null,
    NgayShip date DEFAULT null,
    NgayNhan date DEFAULT null,
    TinhTrang int DEFAULT 0,
    TenNguoiNhan NVARCHAR(100) DEFAULT null,
    DiaChi NVARCHAR(100) DEFAULT null,
    Sdt NVARCHAR(100) DEFAULT null,
)

-- Hoá Đơn Chi tiêt
Create table HoaDonChitiet(
    IdHoaDon UNIQUEIDENTIFIER,
    IdChiTietSanPham UNIQUEIDENTIFIER,
    SoLg int,
    CONSTRAINT PK_HoaDonCT primary key (IdHoaDon, IdChiTietSanPham),
    CONSTRAINT FK1 FOREIGN key (IdHoaDon) REFERENCES HoaDon(Id),
    CONSTRAINT FK2 FOREIGN KEY (IdChiTietSanPham) REFERENCES ChiTietSanPham(Id),
    )

-- Giỏ Hàng
CREATE TABLE GioHang(
Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
IdKH UNIQUEIDENTIFIER,
IdNV UNIQUEIDENTIFIER,
Ma VARCHAR(20) UNIQUE,
NgayTao DATE DEFAULT NULL,
NgayThanhToan DATE DEFAULT NULL,
TenNguoiNhan NVARCHAR(50) DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
Sdt VARCHAR(30) DEFAULT NULL,
TinhTrang INT DEFAULT 0
)
-- Giỏ Hàng Chi TiếtTiếtt
CREATE TABLE GioHangChiTiet(
IdGioHang UNIQUEIDENTIFIER,
IdChiTietSanPham UNIQUEIDENTIFIER,
SoLuong INT,
DonGia DECIMAL(20,0) DEFAULT 0,
DonGiaKhiGiam DECIMAL(20,0) DEFAULT 0,
CONSTRAINT PK_GioHangCT PRIMARY KEY (IdGioHang,IdChiTietSanPham),
CONSTRAINT FK1_IdGioHang FOREIGN KEY(IdGioHang) REFERENCES GioHang(Id),
CONSTRAINT FK2_IdChiTietSanPham FOREIGN KEY(IdChiTietSanPham) REFERENCES ChiTietSanPham(Id),
)
-- Khách Hàng
create table KhachHang(
    Id UNIQUEIDENTIFIER primary key DEFAULT newid(),
    Ma VARCHAR(20) UNIQUE,
    HoTen NVARCHAR(100) DEFAULT null,
    Email NVARCHAR(100) DEFAULT null,
    Sdt VARCHAR(100) DEFAULT null,
    DiaChi NVARCHAR(100) DEFAULT null,
    QuocGia NVARCHAR(100) DEFAULT null,
)

-- Nhân Viên 
Create table NhanVien(
    Id UNIQUEIDENTIFIER primary key DEFAULT newid(),
    Ma VARCHAR(20) UNIQUE,
    HoTen NVARCHAR(100) DEFAULT null,
    GioiTinh NVARCHAR(20) DEFAULT null,
    Email NVARCHAR(100) DEFAULT null,
    NgaySinh date DEFAULT null,
    DiaChi NVARCHAR(100) DEFAULT null,
    Sdt VARCHAR(100) DEFAULT null,
    IdGiaoCa UNIQUEIDENTIFIER,
    TrangThai int DEFAULT 0
)

-- Mối Quan Hệ Giữa Các Bảng
-- Nhân Viên - Giao Ca
ALTER table NhanVien Add FOREIGN key (IDGiaoCa) REFERENCES NhanVien(Id)

-- Hoá Đơn - Khách Hàng
ALTER TABLE HoaDon add FOREIGN KEY (IdKh) REFERENCES KhachHang(Id)

-- Hoá Đơn - Nhân Viên
ALTER TABLE HoaDon add FOREIGN KEY (IdNv) REFERENCES NhanVien(Id)

-- Chi Tiết Sản Phẩm - Sản Phẩm 
ALTER TABLE ChiTietSanPham add FOREIGN KEY (IdSP) REFERENCES SanPham(Id)

-- Chi Tiết Sản Phẩm - NSX (Hãng)
ALTER TABLE ChiTietSanPham add FOREIGN KEY (IdNSX) REFERENCES NSX(Id)

--Chi tiết Sản Phẩm - Màu Sắc
ALTER TABLE ChiTietSanPham add FOREIGN KEY (IdMauSac) REFERENCES MauSac(Id)

--Chi tiết Sản Phẩm - Dòng SP
ALTER TABLE ChiTietSanPham add FOREIGN KEY (IdDongSP) REFERENCES DongSP(Id)
