
create table adminn(
	id_admin serial primary key,
	username varchar(64) not null unique,
	pass_admin varchar(64) not null,
	tanggal_lahir date not null,
	no_telp varchar(64) not null unique,
	email varchar(64) not null unique
);


create table kota(
	id_kota serial primary key,
	nama_kota varchar(64) not null
);

create table kecamatan(
	id_kecamatan serial primary key,
	nama_kecamatan varchar(64) not null,
	id_kota integer not null,
	foreign key (id_kota) references kota(id_kota)
);

create table alamat(
	id_alamat serial primary key,
	nama_jalan varchar(64) not null,
	id_kecamatan integer not null,
	foreign key (id_kecamatan) references kecamatan(id_kecamatan)
);

create table karyawan(
	id_karyawan serial primary key,
	username varchar(64) not null unique,
	pass_karyawan varchar(64) not null,
	tanggal_lahir date not null,
	no_telp varchar(12) unique not null,
	email varchar(64) unique not null,
	status_karyawan boolean not null default true,
	id_admin integer not null,
	id_alamat integer unique,
	foreign key (id_admin) references adminn(id_admin),
	foreign key (id_alamat) references alamat(id_alamat)
);

create table pelanggan(
	id_pelanggan serial primary key,
	username varchar(64) not null unique,
	pass_pelanggan varchar(64) not null,
	tanggal_lahir date not null,
	no_telp varchar(12) unique not null,
	email varchar(64) unique not null
);

create table transaksi(
	id_transaksi serial primary key,
	tanggal_transaksi date not null,
	status_terkonfirmasi boolean default false,
	id_karyawan integer not null,
	id_pelanggan integer not null,
	foreign key (id_karyawan) references karyawan(id_karyawan),
	foreign key (id_pelanggan) references pelanggan(id_pelanggan)
);

create table kategori(
	id_kategori serial primary key,
	jenis_kategori varchar(64) not null
);

create table supplier(
	id_supplier serial primary key,
	nama_perusahaan varchar(64) not null,
	nama_kontak varchar(64) not null,
	no_kontak varchar(12) not null unique,
	id_alamat integer unique,
	foreign key (id_alamat) references alamat(id_alamat)
);

create table produk(
	id_produk serial primary key,
	nama_produk varchar(64) not null,
	stock_produk integer not null,
	harga_produk integer not null,
	hapus_produk boolean default false,
	id_kategori integer not null,
	id_admin integer not null,
	id_supplier integer not null,
	foreign key (id_kategori) references kategori(id_kategori),
	foreign key (id_admin) references adminn(id_admin),
	foreign key (id_supplier) references supplier(id_supplier)
);

create table detail_transaksi(
	id_detail_transaksi serial primary key,
	dicount integer not null,
	quantity integer not null,
	harga integer not null,
	id_transaksi integer not null,
	id_produk integer not null,
	foreign key (id_transaksi) references transaksi(id_transaksi),
	foreign key (id_produk) references produk(id_produk)
);

drop table kecamatan, kota, alamat, adminn, karyawan, supplier, produk,
kategori, transaksi, detail_transaksi, pelanggan  cascade