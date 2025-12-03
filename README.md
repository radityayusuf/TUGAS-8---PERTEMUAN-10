Dokumentasi Aplikasi TokoKita (Frontend Flutter)

Aplikasi ini adalah client-side (frontend) yang dibangun menggunakan Flutter untuk sistem manajemen Toko. Aplikasi ini dirancang untuk melakukan operasi CRUD (Create, Read, Update, Delete) pada data produk, serta memiliki fitur autentikasi (Registrasi & Login) yang terintegrasi dengan REST API CodeIgniter 4.

Struktur Folder & Penjelasan File

1. Konfigurasi Utama

File: lib/main.dart

Fungsi: Titik masuk (entry point) aplikasi.

Logika Utama:

Mengatur tema aplikasi (ThemeData) menggunakan primarySwatch: Colors.blue dan useMaterial3: false untuk mempertahankan gaya desain klasik Material 2.

Mengecek status login pengguna. Jika token tersedia, arahkan ke ProdukPage, jika tidak, arahkan ke LoginPage.

2. Model Data (lib/model/)

Folder ini berisi representasi objek data untuk memetakan format JSON dari API ke objek Dart.

registrasi.dart: Menampung respon status registrasi (code, status, data).

login.dart: Menampung data token autentikasi, ID user, dan email user.

produk.dart: Mendefinisikan atribut produk (id, kodeProduk, namaProduk, hargaProduk) dengan penanganan konversi tipe data yang aman.

3. Helpers & Bloc

lib/helpers/api.dart: Menangani HTTP Request (POST, GET, PUT, DELETE) dan Error Handling.

lib/helpers/api_url.dart: Menyimpan daftar endpoint API (IP Address Server).

lib/bloc/: Berisi Business Logic Component untuk memisahkan logika bisnis dari UI (contoh: login_bloc.dart, produk_bloc.dart).

Implementasi Fitur & Alur Kerja (CRUD)

Berikut adalah penjelasan langkah demi langkah untuk setiap fitur utama dalam aplikasi.

1. Proses Registrasi

Halaman ini digunakan untuk mendaftarkan pengguna baru.

Tampilan: Form input Nama, Email, Password, dan Konfirmasi Password.

Validasi: Email harus format valid (Regex), password minimal 6 karakter, dan konfirmasi password harus cocok.

Langkah:

Pengguna mengisi form registrasi.

Saat tombol "Registrasi" ditekan, fungsi _submit dipanggil.

Aplikasi mengirim data ke API melalui RegistrasiBloc.

Screenshot:

(Ganti dengan screenshot halaman registrasi Anda)

Kode Implementasi (registrasi_page.dart):

RegistrasiBloc.registrasi(
  nama: _namaTextboxController.text,
  email: _emailTextboxController.text,
  password: _passwordTextboxController.text,
).then((value) {
  // Jika sukses, tampilkan dialog sukses
  showDialog(..., builder: (context) => SuccessDialog(...));
}, onError: (error) {
  // Jika gagal, tampilkan dialog warning
  showDialog(..., builder: (context) => WarningDialog(...));
});


2. Proses Login

Halaman masuk untuk pengguna yang sudah terdaftar.

Tampilan: Input Email dan Password.

Logika: Jika login berhasil, Token dan User ID disimpan ke SharedPreferences (penyimpanan lokal) agar sesi tetap terjaga.

Langkah:

Pengguna memasukkan email dan password.

Sistem memverifikasi kredensial ke API.

Jika kode respon 200 (Sukses), token disimpan dan halaman berpindah ke List Produk.

Screenshot:

(Ganti dengan screenshot halaman login)

Kode Implementasi (login_page.dart):

LoginBloc.login(
  email: _emailTextboxController.text,
  password: _passwordTextboxController.text,
).then((value) async {
  if (value.code == 200) {
    // Simpan Token & ID User
    await UserInfo().setToken(value.token.toString());
    await UserInfo().setUserID(int.parse(value.userID.toString()));
    // Pindah ke Halaman Produk
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const ProdukPage()));
  } else {
    showDialog(..., builder: (context) => const WarningDialog(...));
  }
});


3. Menampilkan Data Produk (Read)

Menampilkan daftar semua produk yang diambil dari database server.

Tampilan: List produk menggunakan ListView dan Card.

Logika: Menggunakan FutureBuilder untuk memuat data secara asynchronous dari API.

Screenshot:

(Ganti dengan screenshot halaman list produk)

Kode Implementasi (produk_page.dart):

body: FutureBuilder<List<Produk>>(
  future: ProdukBloc.getProduks(), // Memanggil API Get Produk
  builder: (context, snapshot) {
    if (snapshot.hasError) print(snapshot.error);
    // Tampilkan List jika data ada, atau Loading jika belum
    return snapshot.hasData
        ? ListProduk(list: snapshot.data)
        : const Center(child: CircularProgressIndicator());
  },
),


4. Tambah Data Produk (Create)

Fitur untuk menambahkan produk baru ke database.

Akses: Klik tombol tambah (+) di halaman List Produk.

Logika: Menggunakan ProdukForm dengan mode "TAMBAH". Data dikirim menggunakan method POST.

Screenshot:

(Ganti dengan screenshot form tambah produk)

Kode Implementasi (produk_form.dart):

ProdukBloc.addProduk(produk: createProduk).then((value) {
  // Jika sukses, kembali ke list produk (refresh)
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => const ProdukPage()));
}, onError: (error) {
  showDialog(..., description: "Simpan gagal");
});


5. Detail & Hapus Produk (Delete)

Melihat rincian produk dan menghapusnya.

Akses: Klik salah satu item di List Produk.

Fitur: Menampilkan detail Kode, Nama, Harga. Terdapat tombol Edit dan Delete.

Logika Hapus: Memunculkan dialog konfirmasi sebelum menghapus data permanen via API (Method DELETE).

Screenshot:

(Ganti dengan screenshot halaman detail)

Kode Implementasi (produk_detail.dart):

// Konfirmasi Hapus
AlertDialog alertDialog = AlertDialog(
  content: const Text("Yakin ingin menghapus data ini?"),
  actions: [
    OutlinedButton(
      child: const Text("Ya"),
      onPressed: () {
        // Panggil API Delete
        ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!)).then(
            (value) => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProdukPage()))
                }, ... );
      },
    ),
    // ... Tombol Batal
  ],
);


6. Ubah Data Produk (Update)

Mengedit data produk yang sudah ada.

Akses: Klik tombol "EDIT" di halaman Detail Produk.

Logika: Membuka ProdukForm dengan mode "UBAH". Kolom input otomatis terisi data lama. Data dikirim via API (Method PUT).

Screenshot:

(Ganti dengan screenshot form ubah produk)

Kode Implementasi (produk_form.dart):

// Logika Update (Mengirim data sebagai Body Form, bukan JSON)
ProdukBloc.updateProduk(produk: updateProduk).then((value) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => const ProdukPage()));
}, onError: (error) {
  showDialog(..., description: "Ubah data gagal");
});


7. Logout

Keluar dari aplikasi dan menghapus sesi.

Akses: Melalui Drawer (Menu samping kiri).

Logika: Menghapus token dari SharedPreferences dan mengarahkan kembali ke LoginPage.

Kode Implementasi (produk_page.dart):

ListTile(
  title: const Text('Logout'),
  onTap: () async {
    await LogoutBloc.logout().then((value) => {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false)
        });
  },
)

<img width="300"  alt="Screenshot_1764724298" src="https://github.com/user-attachments/assets/7c94e1df-7937-48e9-8fff-db837127943e" />

<img width="300" alt="Screenshot_1764724328" src="https://github.com/user-attachments/assets/73d9836d-339b-4d3c-bb19-bf1499fa7ec0" />

<img width="300" alt="Screenshot_1764725308" src="https://github.com/user-attachments/assets/2d73e178-d989-4d91-aa7b-c65af9b4e697" />

<img width="300" alt="Screenshot_1764725316" src="https://github.com/user-attachments/assets/0b23ab64-e49a-4067-b2c5-97002321fbf7" />

<img width="300" alt="Screenshot_1764725325" src="https://github.com/user-attachments/assets/166d1777-ee77-433b-92fd-90f2ac50a698" />

<img width="300" alt="Screenshot_1764725335" src="https://github.com/user-attachments/assets/7473bfb3-e0e4-4d16-acf6-af19421c94a8" />

<img width="300" alt="Screenshot_1764725346" src="https://github.com/user-attachments/assets/37349095-e498-4919-a1eb-3c83e691a231" />

<img width="300" alt="Screenshot_1764725362" src="https://github.com/user-attachments/assets/f1832bb9-f816-4d49-9da4-3ae1dd59167e" />

<img width="300" alt="Screenshot_1764725369" src="https://github.com/user-attachments/assets/6ca7d593-d65e-45b7-b0dd-73edb6bf4792" />



