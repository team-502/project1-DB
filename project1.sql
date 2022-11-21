use master
CREATE database PhanMem_BanGiay_Limited
GO
use PhanMem_BanGiay_Limited
GO

-- Sản Phẩm
CREATE TABLE Product(
    Id UNIQUEIDENTIFIER Primary KEY DEFAULT NEWID(),
    id_product VARCHAR(20) UNIQUE,
    _name NVARCHAR(100)
)

-- Màu Sắc
CREATE TABLE Color(
    Id UNIQUEIDENTIFIER primary key DEFAULT newid(),
    id_color VARCHAR(20) UNIQUE,
    _name NVARCHAR(20)
)

-- Chất Liệu
CREATE TABLE ProductLine(
    Id UNIQUEIDENTIFIER primary key DEFAULT newid(),
    id_product_line varchar(20) UNIQUE,
    _name NVARCHAR(50)
) 

-- Nhà Sản Xuất (Hãng)
CREATE TABLE producer(
    Id UNIQUEIDENTIFIER primary key DEFAULT newId(),
    id_producer VARCHAR(20) UNIQUE,
    _name NVARCHAR(100)
)

-- Sản Phẩm Chi Tiết
CREATE TABLE ProductDetail(
    Id UNIQUEIDENTIFIER primary key default newid(),
    product UNIQUEIDENTIFIER,
    color UNIQUEIDENTIFIER,
    product_line UNIQUEIDENTIFIER,
    producer UNIQUEIDENTIFIER,
    -- XuatXu NVARCHAR(50) DEFAULT null,
    Size int,
    quantity int,
    --vitri,
    decription NVARCHAR(100),
    -- NgayN date DEFAULT null,
    import_price DECIMAL(20,0),
    export_price Decimal(20,0)
)

-- Hoá Đơn
CREATE TABLE Invoice(
    id UNIQUEIDENTIFIER primary key DEFAULT newid(),
    customer UNIQUEIDENTIFIER NOT NULL,
    staff UNIQUEIDENTIFIER NOT NULL,
    id_invoice varchar(20) UNIQUE,
    created_date date NOT NULL,
    payment_date date NOT NULL,
    -- delivery_date date NOT NULL,
    received_date date NOT NULL,
    _state int NOT NULL,
    payment_method INT NOT NULL
    -- recipiment_name NVARCHAR(100) NOT NULL,
    -- _address NVARCHAR(100) NOT NULL,
    -- phone_number NVARCHAR(100) NOT NULL,
)

-- Hoá Đơn Chi tiêt
CREATE TABLE InvoiceDetail(
    -- id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    invoice UNIQUEIDENTIFIER,
    product_detail UNIQUEIDENTIFIER,
    quantity int NOT NULL,
    CONSTRAINT PK_HoaDonCT primary key (invoice, Product_Detail),
    CONSTRAINT FK1 FOREIGN key (invoice) REFERENCES Invoice(id),
    CONSTRAINT FK2 FOREIGN KEY (product_detail) REFERENCES ProductDetail(id),
)

-- Giỏ Hàng
-- CREATE TABLE GioHang(
--     Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
--     IdKH UNIQUEIDENTIFIER,cd
--     IdNV UNIQUEIDENTIFIER,
--     Ma VARCHAR(20) UNIQUE,
--     NgayTao DATE DEFAULT NULL,
--     NgayThanhToan DATE DEFAULT NULL,
--     TenNguoiNhan NVARCHAR(50) DEFAULT NULL,
--     DiaChi NVARCHAR(100) DEFAULT NULL,
--     Sdt VARCHAR(30) DEFAULT NULL,
--     TinhTrang INT DEFAULT 0
-- )
-- Giỏ Hàng Chi TiếtTiếtt
-- CREATE TABLE GioHangChiTiet(
--     IdGioHang UNIQUEIDENTIFIER,
--     IdChiTietSanPham UNIQUEIDENTIFIER,
--     SoLuong INT,
--     DonGia DECIMAL(20,0) DEFAULT 0,
--     DonGiaKhiGiam DECIMAL(20,0) DEFAULT 0,
-- )
-- Khách Hàng
CREATE TABLE Customer(
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT newid(),
    id_customer VARCHAR(20) UNIQUE,
    full_name NVARCHAR(100) DEFAULT null,
    email NVARCHAR(100) DEFAULT null,
    gender BIT NOT NULL,
    phone_number VARCHAR(100) DEFAULT null,
    _address NVARCHAR(100) DEFAULT null,
    country NVARCHAR(100) DEFAULT null,
    _state BIT NOT NULL
)

-- Nhân Viên 
CREATE TABLE staff(
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT newid(),
    id_staff VARCHAR(20) NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    gender BIT NOT NULL,
    emai NVARCHAR(100) NOT NULL,
    birth date NOT NULL,
    _address NVARCHAR(100) NOT NULL,
    _password VARCHAR(100) NOT NULL,
    phone_number VARCHAR(100) NOT NULL,
    -- IdGiaoCa UNIQUEIDENTIFIER,
    _state int NOT NULL
)

CREATE TABLE Promotion (
    id UNIQUEIDENTIFIER PRIMARY KEY,
    _name NVARCHAR(1000),
    state_date DATE NOT NULL,
    end_date DATE NOT NULL,
    _percent INT NOT NULL,
    _money BIGINT NOT NULL,
    _type BIT NOT NULL
)

CREATE TABLE PromotionDetail (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Promotion UNIQUEIDENTIFIER NOT NULL,
    product_detail UNIQUEIDENTIFIER NOT NULL
)

-- Mối Quan Hệ Giữa Các Bảng
-- Nhân Viên - Giao Ca
-- ALTER table staff Add FOREIGN key (IDGiaoCa) REFERENCES NhanVien(Id)

-- Hoá Đơn - Khách Hàng
ALTER TABLE Invoice add FOREIGN KEY (customer) REFERENCES Customer(id)

-- Hoá Đơn - Nhân Viên
ALTER TABLE Invoice add FOREIGN KEY (staff) REFERENCES Staff(id)

-- Chi Tiết Sản Phẩm - Sản Phẩm 
ALTER TABLE ProductDetail add FOREIGN KEY (product) REFERENCES Product(id)

-- Chi Tiết Sản Phẩm - NSX (Hãng)
ALTER TABLE ProductDetail add FOREIGN KEY (producer) REFERENCES producer(Id)

--Chi tiết Sản Phẩm - Màu Sắc
ALTER TABLE ProductDetail add FOREIGN KEY (color) REFERENCES Color(Id)

--Chi tiết Sản Phẩm - Dòng SP
ALTER TABLE ProductDetail add FOREIGN KEY (product_line) REFERENCES ProductLine(Id)

-- promotion
ALTER TABLE PromotionDetail ADD FOREIGN KEY (product_detail) REFERENCES ProductDetail(id)

ALTER TABLE PromotionDetail ADD FOREIGN KEY (promotion) REFERENCES Promotion(id)

select * from ProductLine

-- SELECT * from Product
-- go
-- delete productdetail