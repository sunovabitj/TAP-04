create database tpa4;
use tpa4;

-- membuat tabel --
create table pembeli (
id_pembeli int primary key not null auto_increment,
nama varchar(25),
nohp varchar(15),
email varchar(25)
);

create table penjual (
id_penjual int primary key not null auto_increment,
nama varchar(25),
nohp varchar(15)
);

create table kategori (
id_kategori int primary key not null auto_increment,
nama varchar(25)
);

create table produk (
id_produk int primary key not null auto_increment,
nama varchar(50),
harga int,
id_penjual int,
id_kategori int,
foreign key (id_penjual) references penjual(id_penjual),
foreign key (id_kategori) references kategori(id_kategori)
);

create table transaksi (
id_transaksi int primary key not null auto_increment,
id_produk int,
id_pembeli int,
foreign key (id_produk) references produk(id_produk),
foreign key (id_pembeli) references pembeli(id_pembeli),
tanggal_beli datetime,
total_harga int
);

-- tambah data ke tabel--
insert into pembeli (nama, nohp, email) values
("Adnisa Sabina", "081316447367", "adnisa@gmail.com"),
("Auzan Assidqi", "081286856900", "auzan@gmail.com"), 
("Hirzi Nurfakhrian", "083116823235", "hirzi@gmail.com"), 
("Muhammad Zaidan", "081585556517", "zaidan@gmail.com"),
("Zahrine Hanani", "085225019098", "zahrine@gmail.com");

insert into penjual (nama, nohp) values
("Toko Paradise","021345678"),
("Toko Terang","021635487"),
("Eka Surya"," 0281636763"),
("Toko Hero","0281631908"),
("Rita Pasaraya","02817772509");  

insert into kategori (nama) values
("makanan"),
("minuman"),
("Rumah Tangga"),
("elektronik"),
("skincare");

insert into produk (nama, harga, id_penjual, id_kategori) values
("Nabati", 7000, 1, 1),
("Malkist", 12000, 1, 1),
("Air Mineral", 5000, 2, 2),
("Sapu Lidi", 15000, 3, 3),
("Mesin Cuci", 740000, 4, 4),
("AC Sharp", 1200000, 4, 4),
("Wardah Lightening Day Cream", 20000, 5, 5);

insert into transaksi (id_produk, id_pembeli, tanggal_beli, total_harga) values
(5,1,"2022-12-12 10:39:00", 740000),
(1,4,"2022-8-21 17:17:00", 7000),
(2,3,"2022-10-20 09:00:00", 12000),
(7,5,"2022-9-15 13:57:00", 20000),
(6,2,"2022-11-18 22:00:40", 1200000),
(3,4,"2022-8-21 17:17:00", 5000);

-- jika ingin mengulang auto increment --
ALTER TABLE pembeli AUTO_INCREMENT = 1;

-- menghapus database --
drop database tpa4;

-- menghapus tabel --
drop table transaksi;
drop table produk;
drop table pembeli;
drop table kategori;

-- menghapus data pada tabel --
delete from pembeli where id = 5;
delete from penjual where nama = 'Toko Terang';

-- mengambil data dan melihat data --
use tpa4;
select * from pembeli;
select * from transaksi;
select * from produk;
select nama from produk;
select * from transaksi where id_pembeli = 4;
desc pembeli;

-- update data --
update produk set nama = "Sapu" where id_produk = 4;


-- kasus --
-- 1 pelanggan membeli 3 barang berbeda --
insert into transaksi (id_produk, id_pembeli, tanggal_beli, total_harga) values
(5, 3, "2022-12-29 09:10:37", 740000),
(4, 3, "2022-10-12 08:00:00", 15000),
(1, 3, "2022-11-5 10:50:21", 7000);

-- melihat beberapa produk yang paling sering dibeli --
select nama, (count(jumlahbarang)) as "Laris" from transaksi
left join produk on transaksi.id_produk=produk.id_produk group by id_produk
order by count(id_produk) desc limit 5;

-- melihat kategori produk yang paling banyak produk nya --
select id_kategori, count(id_kategori) as "jumlah produk" from produk group by id_kategori
order by count(id_kategori) desc;

-- rata-rata transaksi yang dilakukan pembeli dalam 1 bulan terakhir --
select count(id_transaksi) as "Jumlah transaksi dalam 1 bulan", avg(total_harga) as "rata-rata transaksi"
from transaksi where tanggal_beli between "2022-10-10 00:00:00" and "2022-11-10 00:00:00";