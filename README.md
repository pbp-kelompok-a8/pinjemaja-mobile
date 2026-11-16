# Pinjem Aja Mobile

Aplikasi mobile **Pinjem Aja** dibangun dengan Flutter sebagai versi mobile dari situs web Pinjem Aja (Proyek Tengah Semester). Data tetap disimpan di situs web Django (PWS) dan diakses aplikasi melalui web service Django REST Framework.

Proyek Akhir Semester — Pemrograman Berbasis Platform, Fasilkom UI, Gasal 2026/2027.

## Anggota Kelompok

| NPM | Nama |
|-----|------|
| 2506656614 | Della Permata Prasilda |
| 2506656835 | Joceline Nadine Immanuella |
| 2506533614 | Fatma Widya Rachma |
| 2506589755 | Khanyfatul Muflikhat |
| 2506604573 | Nafeeza Arwatabina |

## Tautan Penting

| Keterangan | Tautan |
|------------|--------|
| Situs web (PWS) | _(isi nanti)_ |
| Repositori situs web Django | _(isi nanti)_ |
| Desain Figma | _(isi nanti)_ |
| APK (Release GitHub) | _(isi nanti, setelah Checkpoint 1)_ |
| APK (Bitrise) | _(isi nanti, setelah Checkpoint 1)_ |

## Deskripsi Aplikasi

**Nama aplikasi:** Pinjem Aja

**Topik utama:** Sustainable Consumption

Pinjem Aja adalah platform berbasis komunitas yang memungkinkan pengguna meminjam dan meminjamkan barang. Pengguna dapat mengunggah barang yang sedang tidak dipakai beserta informasi dan harganya. Pengguna lain yang membutuhkan dapat mencari barang berdasarkan kategori, lokasi, ketersediaan, dan kondisi barang, lalu mengajukan peminjaman.

**Masalah yang diselesaikan:**
- Barang sering dibeli meski hanya digunakan sesekali (kalkulator, setrika, speaker, dll.).
- Banyak barang milik orang lain belum dimanfaatkan secara maksimal.
- Sulit menemukan barang yang bisa dipinjam dari orang di sekitar (tetangga, teman, komunitas).

**Public API:** OpenStreetMap / Overpass API, dipakai untuk fitur lokasi (menampilkan lokasi barang atau pemilik melalui peta).

## Peran / Aktor Pengguna

| Aktor | Keterangan |
|-------|------------|
| Peminjam | Mahasiswa atau individu yang membutuhkan suatu barang. Mencari barang dan mengajukan peminjaman atau barter. |
| Pemilik Barang | Pengguna yang mengunggah barang, menyetujui atau menolak pengajuan, dan mengatur jadwal ambil-kembali. |


## Daftar Modul dan Pembagian Kerja

| No | Modul | Deskripsi | Anggota |
|----|-------|-----------|---------|
| 1 | Barang (Item Listing) | Listing barang: kategori, foto, deskripsi, harga, status ketersediaan | Della |
| 2 | Transaksi Pinjam & Barter | Pengajuan, persetujuan, jadwal ambil-kembali, status transaksi | Nafeeza |
| 3 | Pencarian, Filter & Lokasi | Pencarian berdasarkan kategori, lokasi, jarak, ketersediaan, dan peta | Joceline |
| 4 | Profil | Profil pengguna dan riwayat transaksi | Khanyfatul |
| 5 | Chat | Komunikasi teks antarpengguna | Fatma |

### Pembagian Tugas Bersama (Checkpoint 1)

| Anggota | Tugas bersama |
|---------|---------------|
| Della | Struktur project Flutter, push skeleton ke repo, kerangka README |
| Nafeeza | Tema Flutter dan kerangka navigasi (drawer atau bottom navigation) |
| Joceline | Desain Figma versi mobile, palet warna, dan komponen referensi |
| Khanyfatul | Setup Django REST Framework, CORS, autentikasi, dan deploy ulang PWS |
| Fatma | Halaman contoh yang mengambil data dari API dengan tema dan komponen bersama |

## Alur Integrasi Data dengan Situs Web (PWS)

1. Data aplikasi disimpan di database situs web Django yang sudah di-deploy di PWS (Proyek Tengah Semester). Aplikasi Flutter tidak menyimpan data statis.
2. Di proyek Django, setiap modul menyediakan endpoint **Django REST Framework** (serializer dan view/viewset) yang mengembalikan data dalam format JSON.
3. Aplikasi Flutter memanggil endpoint tersebut secara asinkron lewat HTTP (`http` dan `pbp_django_auth`), dengan alamat dasar yang diatur di `lib/core/config/api_config.dart`.
4. Respons JSON diubah menjadi objek Dart (model) di `features/<modul>/models/`, lalu ditampilkan di halaman Flutter.
5. Untuk aksi tambah, ubah, dan hapus data, Flutter mengirim request ke endpoint yang sesuai. Perubahan langsung tersimpan di database Django, sehingga data di aplikasi mobile dan situs web selalu sama.
6. Endpoint yang butuh login (misalnya kontak pemilik barang) memakai autentikasi sesi Django lewat `pbp_django_auth`.


## Struktur Project

```
lib/
├── main.dart
├── core/                  # bagian bersama
│   ├── config/            # base URL API
│   ├── theme/             # ThemeData
│   ├── widgets/           # widget bersama (card, tombol, badge)
│   └── services/          # client API bersama / autentikasi
└── features/
    ├── item/              # Barang
    ├── transaction/       # Transaksi 
    ├── search/            # Pencarian, Filter & Lokasi
    ├── profile/           # Profil
    └── chat/              # Chat
        ├── models/
        ├── services/
        ├── screens/
        └── widgets/
```

## Deployment

- APK diunggah sebagai **Release** di repositori GitHub ini dan di platform **Bitrise**.
- Aplikasi memakai logo buatan kelompok sendiri.
- Tautan APK ada di bagian [Tautan Penting](#tautan-penting).

## Menjalankan Proyek

```bash
git clone <url-repo-ini>
cd pinjem_aja_mobile
flutter pub get
flutter run
```

Atur alamat server di `lib/core/config/api_config.dart`. Untuk emulator Android yang mengakses Django lokal, gunakan `http://10.0.2.2:8000`.

## Workflow Git

- Satu branch per modul atau fitur, misalnya `feat/item-screen`.
- Perubahan masuk ke `main` lewat Pull Request.
- Pesan commit memakai prefix `feat`, `fix`, `docs`, `chore`, atau `test`.