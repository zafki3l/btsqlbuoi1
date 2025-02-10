-- QLGV 

CREATE DATABASE QLGV

USE QLGV

-- TAO BANG MON HOC 
CREATE TABLE MONHOC
(
    maMon CHAR(10) PRIMARY KEY,
    tenMon VARCHAR(50),
    soTiet INT
)

-- TAO BANG GIAO VIEN 
CREATE TABLE GIAOVIEN
(
    maGV CHAR(10) PRIMARY KEY,
    tenGV CHAR(50),
    diaChi CHAR(30),
    SDT INT
)

-- TAO BANG TIEN DO 
CREATE TABLE TIENDO
(
    maLop CHAR(10),
    maMon CHAR(10),
    maGV CHAR(10),
    phongHoc CHAR(20),
    CONSTRAINT FK1_TIENDO FOREIGN KEY (maMon) REFERENCES MONHOC(maMon),
    CONSTRAINT FK2_TIENDO FOREIGN KEY (maGV) REFERENCES GIAOVIEN(maGV),
)

-- CHEN DU LIEU VAO BANG 
INSERT INTO MONHOC(maMon, tenMon, soTiet)
VALUES
('AC', 'Access co ban', 60),
('AN', 'Access nang cao', 60),
('CB', 'Tin hoc co ban', 45),
('CO', 'Corel Draw', 75),
('IN', 'Mang may tinh', 60),
('SQL', 'Structer Query Language', 60)

INSERT INTO GIAOVIEN(maGV, tenGV, diaChi, SDT)
VALUES
('GV01', 'Nguyen Bao An', 'Ha Noi', 32164994),
('GV02', 'Pham Chi Bao', 'Nam Dinh', 987456123),
('GV03', 'Le Hoai An', 'Ha Noi', NULL),
('GV04', 'Pham Minh Thu', 'Quang Ninh', NULL),
('GV05', 'Nguyen Van Bach', 'Ha Noi', 97845612),
('GV06', 'Nguyen Thu', 'Nam Dinh', 23564789)

INSERT INTO TIENDO(maLop, maMon, maGV, phongHoc)
VALUES
('L01', 'AC', 'GV01', 'P001'),
('L02', 'AN', 'GV02', 'P002'),
('L03', 'CB', 'GV03', 'P003'),
('L04', 'CO', 'GV06', 'P004'),
('L05', 'IN', 'GV05', 'P005'),
('L06', 'SQL', 'GV03', 'P006'),
('L03', 'IN', 'GV03', 'P007')

-- TRUY VAN DU LIEU 
SELECT * FROM MONHOC
SELECT * FROM GIAOVIEN
SELECT * FROM TIENDO

-- CAU 1: Cho biết những giảng viên có địa chỉ ở Hà nội và dạy lớp 01. 
-- Thông tin lấy ra gồm: Mã giảng viên, mã lớp, tên giảng viên, Địa chỉ, Điện thoại. 
SELECT GIAOVIEN.maGV, maLop, tenGV, diaChi, SDT
FROM GIAOVIEN
JOIN TIENDO
ON GIAOVIEN.maGV = TIENDO.maGV
WHERE diaChi = 'Ha Noi' AND maLop = 'L01'

-- CAU 2: Cho biết những giảng viên không có số điện thoại và dạy môn Tin học căn bẳn. 
-- Thông tin lấy ra gồm: Mã giảng viên, tên giảng viên, Địa chỉ, Điện thoại, Tên môn học. 
SELECT GIAOVIEN.maGV, tenGV, diaChi, SDT, tenMon
FROM GIAOVIEN
JOIN TIENDO ON GIAOVIEN.maGV = TIENDO.maGV
JOIN MONHOC ON TIENDO.maMon = MONHOC.maMon
WHERE SDT IS NULL AND tenMon = 'Tin hoc co ban'

-- CAU 3: Đưa ra những môn học có số tiết lớn hơn 60 do giảng viên Nguyen Van Bach giảng dạy.
-- Thông tin lấy ra bao gồm: Tên giảng viên, Tên môn, Số tiết, Mã lớp.
SELECT tenGV, tenMon, soTiet, maLop
FROM MONHOC
JOIN TIENDO ON MONHOC.maMon = TIENDO.maMon
JOIN GIAOVIEN ON TIENDO.maGV = GIAOVIEN.maGV
WHERE soTiet > 60 AND tenGV = 'Nguyen Van Bach'

-- CAU 4: Tìm giảng viên dạy nhiều lớp nhất.
-- Thông tin lấy ra bao gồm: Mã giảng viên, tên giảng viên, Tên môn, tổng số lớp.
SELECT TOP 1 GIAOVIEN.maGV, tenGV, STRING_AGG(MONHOC.tenMon, ', ') AS 'Cac mon day', COUNT(maLop) AS 'Tong so lop'
FROM GIAOVIEN
JOIN TIENDO ON GIAOVIEN.maGV = TIENDO.maGV
JOIN MONHOC ON TIENDO.maMon = MONHOC.maMon
GROUP BY GIAOVIEN.maGV, tenGV
ORDER BY COUNT(maLop) DESC

