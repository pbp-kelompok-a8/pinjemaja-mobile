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
| Situs web (PWS) | [PinjemAja PWS](https://khanyfatul-muflikhat-pinjemaja.pws.cs.ui.ac.id/) |
| Repositori situs web Django | [pbp-kelompok-a8/PinjemAja](https://github.com/pbp-kelompok-a8/PinjemAja) |
| Desain Figma | [Wireframe & Desain PinjemAja – Figma](https://www.figma.com/design/6dKz48JAYCguCmL9fVptaa/Wireframe-PinjemAja) *(versi mobile sedang dilengkapi di halaman Mobile)* |
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

**Public API:**
- **OpenStreetMap / Overpass API** — dipakai untuk fitur lokasi (menampilkan lokasi barang atau pemilik melalui peta).
- **API Wilayah Indonesia** ([emsifa.com/api-wilayah-indonesia](https://emsifa.com/api-wilayah-indonesia/)) — dipakai untuk dropdown alamat bertingkat (provinsi, kota/kabupaten, kecamatan, kelurahan).

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
| 3 | Pencarian, Filter & Lokasi | Pencarian berdasarkan kategori, lokasi, jarak, ketersediaan, riwayat pencarian, dan peta | Joceline |
| 4 | Profil | Profil pengguna, autentikasi, info pembayaran, dan riwayat transaksi | Khanyfatul |
| 5 | Chat | Komunikasi teks antarpengguna terkait barang | Fatma |

### Pembagian Tugas Bersama (Checkpoint 1)

| Anggota | Tugas bersama |
|---------|---------------|
| Della | Struktur project Flutter, push skeleton ke repo, kerangka README |
| Nafeeza | Tema Flutter dan kerangka navigasi (bottom navigation bar) |
| Joceline | Desain Figma versi mobile, palet warna, dan komponen referensi |
| Khanyfatul | Setup Django REST Framework, CORS, autentikasi, dan deploy ulang PWS |
| Fatma | Halaman contoh yang mengambil data dari API dengan tema dan komponen bersama |

## Alur Integrasi Data dengan Situs Web (PWS)

1. Data aplikasi disimpan di database situs web Django yang sudah di-deploy di PWS (Proyek Tengah Semester). Aplikasi Flutter tidak menyimpan data statis.
2. Di proyek Django, setiap modul menyediakan endpoint **Django REST Framework** (serializer dan view/viewset) yang mengembalikan data dalam format JSON.
3. Aplikasi Flutter memanggil endpoint tersebut secara asinkron lewat HTTP (`http` dan `pbp_django_auth`), dengan alamat dasar yang diatur di `lib/config/api_config.dart`.
4. Respons JSON diubah menjadi objek Dart (model) di `lib/features/<modul>/models/`, lalu ditampilkan di halaman Flutter.
5. Untuk aksi tambah, ubah, dan hapus data, Flutter mengirim request ke endpoint yang sesuai. Perubahan langsung tersimpan di database Django, sehingga data di aplikasi mobile dan situs web selalu sama.
6. Endpoint yang butuh login (misalnya tambah barang, transaksi, profil pribadi, riwayat pencarian, dan chat) memakai autentikasi sesi Django lewat `pbp_django_auth`.

## Konvensi API (untuk semua modul)

- **Format respons JSON seragam:** `{"status": true/false, "message": "...", ...}`. Kalau validasi gagal, tambahkan `"errors": {"field": ["pesan"]}` dengan status HTTP 400.
- **Autentikasi:** session cookie Django. CSRF dinonaktifkan khusus untuk jalur API (`CsrfExemptSessionAuthentication`) karena klien adalah aplikasi mobile, jadi Flutter tidak perlu mengirim CSRF token.
- **Default endpoint privat:** semua view DRF butuh login. Endpoint yang harus bisa diakses tanpa login (misalnya daftar barang) wajib diberi `@permission_classes([AllowAny])`.
- **Data privat:** jangan kirim alamat detail dan data pembayaran di endpoint publik.
- **Prefix:** tiap modul memakai `/api/<nama-modul>/`.

## Daftar Endpoint Django REST Framework (DRF)

Base URL produksi: `https://khanyfatul-muflikhat-pinjemaja.pws.cs.ui.ac.id`

### 1. Autentikasi & Profil (`userprofile` — Khanyfatul)
| Method | Endpoint | Auth | Status | Keterangan |
|--------|----------|------|--------|------------|
| `POST` | `/api/auth/register/` | Tidak | Aktif | Registrasi akun baru. Respons `201` atau `400` (berisi `errors` per field) |
| `POST` | `/api/auth/login/` | Tidak | Aktif | Login dan mulai sesi. Respons `200` atau `401` |
| `POST` | `/api/auth/logout/` | Tidak | Aktif | Logout dan akhiri sesi |
| `GET` | `/api/auth/status/` | Tidak | Aktif | Cek apakah sesi masih login (`is_authenticated`) |
| `GET` | `/api/profile/me/` | Ya | Dikerjakan | Ambil profil pengguna login (termasuk alamat & rekening) |
| `PUT` / `PATCH` | `/api/profile/me/` | Ya | Dikerjakan | Perbarui profil, domisili, dan info pembayaran |
| `GET` | `/api/profile/<user_id>/` | Tidak | Dikerjakan | Profil publik (tanpa alamat detail dan data pembayaran) |
| `DELETE` | `/api/profile/avatar/` | Ya | Dikerjakan | Hapus foto avatar |
| `POST` | `/api/profile/delete/` | Ya | Dikerjakan | Hapus akun (soft/hard) dengan konfirmasi password |

### 2. Barang / Item Listing (`item` — Della)
| Method | Endpoint | Auth | Keterangan |
|--------|----------|------|------------|
| `GET` | `/api/items/` | Tidak | Daftar seluruh barang tersedia (mendukung filter `?category=`) |
| `POST` | `/api/items/` | Ya | Tambah barang baru beserta foto (wajib punya info pembayaran) |
| `GET` | `/api/items/my/` | Ya | Daftar barang milik pengguna yang sedang login |
| `GET` | `/api/items/<uuid:id>/` | Tidak | Detail 1 barang beserta seluruh foto carousel |
| `PUT` / `PATCH` | `/api/items/<uuid:id>/` | Ya | Edit detail barang milik sendiri |
| `DELETE` | `/api/items/<uuid:id>/` | Ya | Hapus barang milik sendiri |
| `DELETE` | `/api/items/<uuid:id>/images/<int:image_id>/` | Ya | Hapus satu foto dari barang milik sendiri |

### 3. Pencarian, Filter & Lokasi (`search` — Joceline)
| Method | Endpoint | Auth | Keterangan |
|--------|----------|------|------------|
| `GET` | `/api/search/` | Opsional | Pencarian & filter barang (`?q=`, `category`, `location`, `condition`, `min_price`, `max_price`, `sort`, `nearby`) |
| `GET` | `/api/search/locations/` | Tidak | Daftar lokasi kota unik dari barang yang tersedia |
| `GET` | `/api/search/history/` | Opsional | Ambil 5 riwayat pencarian terakhir pengguna |
| `DELETE` | `/api/search/history/<int:id>/` | Opsional | Hapus satu riwayat pencarian |
| `DELETE` | `/api/search/history/clear/` | Opsional | Hapus seluruh riwayat pencarian pengguna |

### 4. Transaksi Pinjam & Barter (`transaction` — Nafeeza)
| Method | Endpoint | Auth | Keterangan |
|--------|----------|------|------------|
| `GET` | `/api/transactions/borrowed/` | Ya | Riwayat peminjaman saya (sebagai peminjam) |
| `GET` | `/api/transactions/incoming/` | Ya | Daftar permintaan peminjaman masuk (sebagai pemilik barang) |
| `POST` | `/api/transactions/create/<uuid:item_id>/` | Ya | Ajukan peminjaman barang |
| `GET` | `/api/transactions/<uuid:id>/` | Ya | Detail transaksi |
| `PUT` / `PATCH` | `/api/transactions/<uuid:id>/` | Ya | Ubah jadwal/detail transaksi |
| `POST` | `/api/transactions/<uuid:id>/upload-proof/` | Ya | Upload atau ubah bukti pembayaran |
| `POST` | `/api/transactions/<uuid:id>/action/` | Ya | Ubah status transaksi (terima, tolak, konfirmasi bayar, batalkan, selesai) |
| `POST` | `/api/transactions/<uuid:id>/rating/` | Ya | Beri rating ke pemilik barang setelah transaksi selesai |

### 5. Chat (`chat` — Fatma)
| Method | Endpoint | Auth | Keterangan |
|--------|----------|------|------------|
| `GET` | `/api/chat/conversations/` | Ya | Daftar percakapan (inbox) pengguna |
| `POST` | `/api/chat/start/<uuid:item_id>/` | Ya | Mulai atau buka percakapan terkait barang tertentu |
| `GET` | `/api/chat/conversations/<int:id>/messages/` | Ya | Ambil daftar pesan dalam percakapan |
| `POST` | `/api/chat/conversations/<int:id>/messages/` | Ya | Kirim pesan baru |
| `PUT` / `PATCH` | `/api/chat/messages/<int:id>/` | Ya | Edit pesan milik sendiri |
| `DELETE` | `/api/chat/messages/<int:id>/` | Ya | Hapus pesan milik sendiri |

> **Catatan:** Endpoint autentikasi sudah di-deploy dan dapat diakses dari luar jaringan. Endpoint modul lain dapat disesuaikan sebelum pengumpulan akhir; tanda ✅/🚧 di tabel menunjukkan statusnya.

## Struktur Project

```text
lib/
├── main.dart                  # ThemeData & AppColors
├── menu.dart                  # Bottom Navigation Bar 5 modul
├── config/
│   └── api_config.dart        # base URL API
├── core/                      # bagian bersama
│   ├── config/
│   ├── theme/
│   ├── widgets/               # widget bersama (card, tombol, badge)
│   └── services/              # client API bersama / autentikasi
└── features/
    ├── item/                  # Barang
    ├── transaction/           # Transaksi
    ├── search/                # Pencarian, Filter & Lokasi
    ├── profile/               # Profil
    └── chat/                  # Chat
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
git clone https://github.com/pbp-kelompok-a8/pinjemaja-mobile.git
cd pinjemaja-mobile
flutter pub get
flutter run -d chrome
```

Atur alamat server di `lib/config/api_config.dart`. Untuk emulator Android yang mengakses Django lokal, gunakan `http://10.0.2.2:8000`.

## Workflow Git

- Satu branch per modul atau fitur, misalnya `feat/search-screen`.
- Perubahan masuk ke `main` lewat Pull Request.
- Pesan commit memakai prefix `feat`, `fix`, `docs`, `chore`, atau `test`.

## Keterbatasan yang Diketahui

- CSRF dinonaktifkan di jalur API, dan CORS hanya mengizinkan origin `localhost` untuk keperluan development (Flutter Web di Chrome).
- Autentikasi memakai session cookie, bukan token.