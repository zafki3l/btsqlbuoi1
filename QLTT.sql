
CREATE DATABASE QLTT

USE QLTT

-- TAO BANG KHOA
CREATE TABLE KHOA
(
	maKhoa CHAR(10) PRIMARY KEY,
	tenKhoa CHAR(30),
	SDT CHAR(10)
)

-- TAO BANG DE TAI
CREATE TABLE DE_TAI
(
	maDT CHAR(10) PRIMARY KEY,
	tenDT CHAR(30),
	kinhPhi INT,
	noiThucTap CHAR(30)
)

-- TAO BANG GIANG VIEN 
CREATE TABLE GIANG_VIEN
(
	maGV INT PRIMARY KEY,
	hoTenGV CHAR(30),
	Luong DECIMAL(5, 2),
	maKhoa CHAR(10),
	CONSTRAINT FK_GIANG_VIEN FOREIGN KEY (maKhoa) REFERENCES KHOA(maKhoa)
)

-- TAO BANG SINH VIEN
CREATE TABLE SINH_VIEN
(
	maSV INT PRIMARY KEY,
	hoTenSV CHAR(30),
	maKhoa CHAR(10),
	namSinh INT,
	queQuan CHAR(30),
	CONSTRAINT FK_SINH_VIEN FOREIGN KEY (maKhoa) REFERENCES KHOA(maKhoa)
)

-- TAO BANG HUONG DAN 
CREATE TABLE HUONG_DAN
(
	maSV INT,
	maDT CHAR(10),
	maGV INT,
	ketQua DECIMAL(5, 2),
	CONSTRAINT FK1_HUONG_DAN FOREIGN KEY (maSV) REFERENCES SINH_VIEN(maSV),
	CONSTRAINT FK2_HUONG_DAN FOREIGN KEY (maDT) REFERENCES DE_TAI(maDT),
	CONSTRAINT FK3_HUONG_DAN FOREIGN KEY (maGV) REFERENCES GIANG_VIEN(maGV)
)

-- CHEN DU LIEU VAO CAC BANG
INSERT INTO KHOA(maKhoa, tenKhoa, SDT)
VALUES
('K01', 'KE TOAN', '43855413'),
('K02', 'CNTT', '43855411'),
('K03', 'TCNH', '43855416'),
('K04', 'NNA', '43855415'),
('K05', 'QTKD', '43855412'),
('K06', 'Toan', '3855411')

INSERT INTO DE_TAI(maDT, tenDT, kinhPhi, noiThucTap)
VALUES
('Dt01', 'GIS', 100, 'Nghe An'),
('Dt02', 'ARC GIS', 500, 'Nam Dinh'),
('Dt03', 'Spatial DB', 100, 'Ha Tinh'),
('Dt04', 'MAP', 300, 'Quang Binh')

INSERT INTO GIANG_VIEN(maGV, hoTenGV, Luong, maKhoa)
VALUES
(1, 'Nguyen Thanh Xuan', 700, 'K01'),
(2, 'Le Thu Minh', 500, 'K02'),
(3, 'Le Chu Tuan', 650, 'K01'),
(4, 'Pham Thi Lan', 500, 'K03'),
(5, 'Hoang Tran Nam', 900, 'K04'),
(6, 'Pham Hai Anh', 900, 'K04')

INSERT INTO SINH_VIEN(maSV, hoTenSV, maKhoa, namSinh, queQuan)
VALUES
(1, 'Le Van Hoang', 'K01', 1990, 'Nghe An'),
(2, 'Nguyen Thi My', 'K02', 1990, 'Thanh Hoa'),
(3, 'Bui Xuan Duc', 'K03', 1992, 'Ha Noi'),
(4, 'Nguyen Van Tung', 'K04', NULL, 'Ha Tinh'),
(5, 'Le Khanh Linh', 'K05', 1989, 'Ha Nam'),
(6, 'Tran Khac Trong', 'K04', 1991, 'Thanh Hoa'),
(7, 'Le Thi Van', 'K05', NULL, NULl),
(8, 'Hoang Van Duc', 'K03', 1992, 'Nghe An')


INSERT INTO HUONG_DAN(maSV, maDT, maGV, ketQua)
VALUES
(1, 'Dt01', 1, 8),
(2, 'Dt03', 2, 0),
(3, 'Dt03', 3, 10),
(5, 'Dt04', 4, 7),
(6, 'Dt04', 5, 10),
(8, 'Dt03', 6, 6)

-- XEM BANG 
SELECT * FROM KHOA
SELECT * FROM DE_TAI
SELECT * FROM GIANG_VIEN
SELECT * FROM SINH_VIEN
SELECT * FROM HUONG_DAN

-- CAU 1: 
SELECT GIANG_VIEN.maGV, hoTenGV, tenKhoa
FROM GIANG_VIEN
JOIN KHOA ON GIANG_VIEN.maKhoa = KHOA.maKhoa

-- CAU 2: 
SELECT GIANG_VIEN.maGV, hoTenGV, Luong, tenKhoa
FROM GIANG_VIEN
JOIN KHOA ON GIANG_VIEN.maKhoa = KHOA.maKhoa
WHERE Luong > 700

-- CAU 3:
SELECT maSV, hoTenSV, namSinh, queQuan, tenKhoa
FROM SINH_VIEN
JOIN KHOA ON SINH_VIEN.maKhoa = KHOA.maKhoa
WHERE tenKhoa = 'TCNH'

-- CAU 4: 
SELECT maSV, hoTenSV, namSinh, queQuan
FROM SINH_VIEN
WHERE namSinh = 1990 AND queQuan = 'Nghe An'

-- Câu 5: Sử dụng lệnh SQL để xuất ra thông tin về những sinh viên chưa có điểm thực tập .
SELECT SINH_VIEN.maSV, hoTenSV, maKhoa, namSinh, queQuan
FROM SINH_VIEN
WHERE SINH_VIEN.maSV NOT IN (SELECT maSV FROM HUONG_DAN)

-- CAU 6:
SELECT SDT from KHOA
JOIN SINH_VIEN ON KHOA.maKhoa = SINH_VIEN.maKhoa
WHERE hoTenSV = 'Le Khanh Linh'

-- CAU 7:
SELECT DE_TAI.maDT, tenDT 
FROM DE_TAI
WHERE DE_TAI.maDT IN
(
	SELECT HUONG_DAN.maDT
	FROM HUONG_DAN
	GROUP BY HUONG_DAN.maDT
	HAVING COUNT(HUONG_DAN.maDT) > 2
)

-- CAU 8:
SELECT GIANG_VIEN.maGV, hoTenGV, Luong
FROM GIANG_VIEN
WHERE Luong = (SELECT MAX(Luong) FROM GIANG_VIEN)

-- CAU 9:
SELECT DE_TAI.maDT, tenDT, kinhPhi
FROM DE_TAI
WHERE kinhPhi = (SELECT MAX(kinhPhi) FROM DE_TAI)

-- CAU 10:
SELECT tenKhoa, COUNT(maSV) AS 'So sinh vien'
FROM KHOA
JOIN SINH_VIEN ON KHOA.maKhoa = SINH_VIEN.maKhoa
GROUP BY tenKhoa
ORDER BY COUNT(maSV) DESC

