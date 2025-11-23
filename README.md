Dokumentasi Aplikasi TokoKita (Frontend Flutter)
Aplikasi ini adalah client-side (frontend) yang dibangun menggunakan Flutter untuk sistem manajemen Toko. Aplikasi ini dirancang untuk melakukan operasi CRUD (Create, Read, Update, Delete) pada data produk, serta fitur autentikasi (Registrasi & Login).

Struktur Folder & Penjelasan File
1. Konfigurasi Utama
File: lib/main.dart
Fungsi: Merupakan titik masuk (entry point) aplikasi.
Logika Utama:
Mengatur tema aplikasi (ThemeData).
Menggunakan primarySwatch: Colors.blue dan useMaterial3: false untuk mempertahankan gaya desain klasik (Material 2) sesuai modul .
Menentukan halaman awal yang dimuat, yaitu ProdukPage (atau LoginPage sesuai kebutuhan pengujian) .
2. Model Data (lib/model/)
Folder ini berisi representasi objek data untuk memetakan format JSON dari API ke objek Dart.
registrasi.dart
Menampung respon status registrasi (code, status, data).
login.dart 
Menampung data token autentikasi, ID user, dan email user setelah login berhasil.
produk.dart 
Mendefinisikan atribut produk: id, kodeProduk, namaProduk, dan hargaProduk.
3. User Interface (lib/ui/)
A. Autentikasi
File: lib/ui/registrasi_page.dart 
Fungsi: Halaman pendaftaran pengguna baru.
Fitur & Validasi:
Nama: Wajib diisi, minimal 3 karakter.
Email: Validasi format email menggunakan Regex.
Password: Wajib diisi, minimal 6 karakter.
Konfirmasi Password: Harus sama persis dengan input password.
Judul AppBar: "Registrasi Radit".
File: lib/ui/login_page.dart 
Fungsi: Halaman masuk pengguna.
Fitur:
Input Email dan Password dengan validasi kelengkapan data.
Tautan (Link) menuju halaman Registrasi jika belum punya akun.
Judul AppBar: "Login Radit"
B. Manajemen Produk
File: lib/ui/produk_page.dart 
Fungsi: Menampilkan daftar semua produk (List Produk).
Logika Utama:
Menggunakan ListView untuk menampilkan daftar produk.
Saat ini menampilkan data dummy (hardcoded) seperti Kamera, Kulkas, dan Mesin Cuci.
Navigasi:
Klik item produk -> Membuka ProdukDetail.
Klik tombol tambah (+) -> Membuka ProdukForm (Mode Tambah).
Menu Drawer -> Terdapat tombol Logout untuk kembali ke halaman Login.
Judul AppBar: "List Produk Radit".
File: lib/ui/produk_detail.dart 
Fungsi: Menampilkan rincian lengkap satu produk.
Fitur:
Menampilkan Kode, Nama, dan Harga Produk.
Tombol Edit: Membuka ProdukForm dengan membawa data produk yang sedang dilihat (Mode Ubah).
Tombol Delete: Memunculkan Dialog Konfirmasi ("Yakin ingin menghapus data ini?").
Judul AppBar: "Detail Produk Radit".
File: lib/ui/produk_form.dart 
Fungsi: Halaman formulir yang bersifat dinamis (bisa untuk Tambah atau Ubah).
Logika isUpdate():
Mengecek apakah ada data produk yang dikirim dari halaman sebelumnya.
Jika Ada (Mode Ubah): Judul menjadi "UBAH PRODUK RADIT", tombol menjadi "UBAH", dan kolom input terisi otomatis dengan data produk.
Jika Kosong (Mode Tambah): Judul menjadi "TAMBAH PRODUK RADIT", tombol menjadi "SIMPAN", dan kolom input kosong.
Validasi: Semua kolom (Kode, Nama, Harga) wajib diisi.
Alur Navigasi Aplikasi
Buka Aplikasi -> Masuk ke ProdukPage (List Produk).
Tambah Data: Dari List Produk -> Klik ikon + -> Masuk ke ProdukForm.
Lihat Detail: Dari List Produk -> Klik salah satu item -> Masuk ke ProdukDetail.
Edit Data: Dari Detail Produk -> Klik tombol EDIT -> Masuk ke ProdukForm (Data terisi).
Hapus Data: Dari Detail Produk -> Klik tombol DELETE -> Muncul Pop-up Konfirmasi.
Logout: Dari List Produk -> Buka Drawer (menu kiri) -> Klik Logout -> Masuk ke LoginPage.



<img width="300" alt="Screenshot_1763913626" src="https://github.com/user-attachments/assets/2dad36ce-fa3a-4276-b766-7b634439b01f" />


<img width="300" alt="Screenshot_1763913635" src="https://github.com/user-attachments/assets/b11103aa-f61a-40c1-a695-571da0cab8a1" />

<img width="300" alt="Screenshot_1763913830" src="https://github.com/user-attachments/assets/3198ad4e-a75e-4fa2-8327-c33d39faafe8" />

<img width="300" alt="Screenshot_1763913837" src="https://github.com/user-attachments/assets/63d4bc98-dcba-4dc7-932c-f0c18a83328d" />


<img width="300"  alt="Screenshot_1763913843" src="https://github.com/user-attachments/assets/0d445759-ba6d-423e-bdcc-79f80a0af330" />

<img width="300" alt="Screenshot_1763913848" src="https://github.com/user-attachments/assets/96a35c77-5869-45a6-93f8-4ec799e313a6" />
