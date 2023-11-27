# PBP Tugas UAS Tahap 1

### Nama Aplikasi : Bookstagram

### Nama dan NPM anggota:

- Adinda Nurdzykra Putri Nugraini - 2206082083 
- Darryl Nawawi - 2206083104
- Edwin Daniel Toliansa - 2206082386
- Scudetto Ciano Syam - 2206083294
- Sri Saraswati Widhisari - 2206812180 

### Deskripsi aplikasi:

Dalam upaya meningkatkan literasi di Indonesia, kami mempersembahkan aplikasi "Bookstagram." Aplikasi ini muncul dari kesadaran akan rendahnya peringkat PISA Indonesia dibandingkan dengan negara - negara lainnya serta kebutuhan tren positif baru yang dapat meningkatkan minat individu dalam membaca.Aplikasi ini menghadirkan cara interaktif dan menghibur untuk menginspirasi perluasan minat membaca masyarakat luas.

### Daftar modul: 
- Main Page (oleh Adinda Nurdzykra Putri Nugraini)   

Halaman utama setelah pengguna login. Halaman ini berisi keterangan singkat tentang aplikasi (tujuan aplikasi + apa yang bisa dilakukan di aplikasi ini) , menampilkan list buku dalam website, dan testimoni.
- Profil Pengguna (oleh Sri Saraswati Widhisari)  

Halaman ini berisi form user yang menampilkan foto profil, role, dan dashboard sederhana yang berisi daftar bacaan profil pengguna. Di halaman ini, pengguna juga bisa menambah status seperti tweet. 
- Forum diskusi (oleh Edwin Daniel Toliansa)  

Halaman ini menampilkan urutan forum diskusi berbentuk card yang berada di rangking 1 sampai 15. Ketika card diklik akan muncl diskusi seperti bubble di stackoverflow. Satu komen bisa direply dengan komen lainnya. Pengguna bisa menghapus dan edit komen sendiri.  Di halaman ini, akan ada button “add forum discussion”, yang jika diklik oleh pembaca akan menampilkan pop-up message “gagal” dan kalau diklik oleh author maka beralih ke halaman form add book forum discussion. 
- Katalog Buku (oleh Scudetto Ciano Syam) 

Halaman ini menampilkan buku-buku yang ada pada aplikasi juga dapat melihat informasi detail mengenai buku tersebut, halaman ini juga memiliki fitur menambahkan buku.
- Communities (oleh Darryl Nawawi )   

Halaman ini interfacenya seperti feed, menampilkan event - event yang akan ada, yang mana penulis buku dapat menambahkan acara communities.

### Modul yang bukan modul buku, tetapi harus ada:
- Navbar 
- Login/Register (Authentication)

### Pembagian

Main Page         → Adinda Nurdzykra Putri Nugraini
Profil Pengguna   → Sri Saraswati Widhisari
Forum diskusi     → Edwin Daniel Toliansa
Add book          → Scudetto Ciano Syam
Communities       → Darryl Nawawi

### Persona

Semua user harus login terlebih dahulu untuk dapat mengakses website

**Penulis Buku** : 

Dapat membuka forum diskusi, dapat menambahkan buku di dataset dapat menambahkan event buku

**Pembaca Buku** : 

Tidak bisa menambahkan forum diskusi baru,  tidak bisa menambahkan buku di dataset, dan tidak bisa menambahkan event buku

### Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web
1. Memodifikasi struktur proyek Flutter agar setiap modul berdiri sendiri.
2. Melakukan transformasi model dari setiap modul dalam proyek Django dengan menggunakan QuickType.
3. Membuat berkas baru .dart pada aplikasi Flutter yang akan menyimpan data hasil transformasi dari QuickType untuk aplikasi Flutter.
4. Menyisipkan modul autentikasi baru ke dalam proyek Django.
5. Memasukkan modul autentikasi ke daftar aplikasi yang terinstal di settings.py.
6. Menyertakan django-cors-headers ke dalam daftar kebutuhan yang terinstal di requirements.txt.
7. Memasukkan corsheaders ke dalam daftar aplikasi yang terinstal di settings.py pada proyek utama Django.
8. Menerapkan corsheaders.middleware.CorsMiddleware ke dalam daftar middleware di settings.py pada proyek utama Django.
9. Mendefinisikan serangkaian variabel baru di settings.py sebagai berikut:
    ```python
    CORS_ALLOW_ALL_ORIGINS = True
    CORS_ALLOW_CREDENTIALS = True
    CSRF_COOKIE_SECURE = True
    SESSION_COOKIE_SECURE = True
    CSRF_COOKIE_SAMESITE = 'None'
    SESSION_COOKIE_SAMESITE = 'None'
    ```
10. Mengembangkan fungsi dalam views.py dan jalur URL dalam urls.py pada modul autentikasi untuk mengelola proses login, logout, dan pendaftaran.
11. Memakai paket pbp_django_auth, http, dan provider untuk berinteraksi dengan server web menggunakan data JSON, serta melakukan operasi HTTP GET dan POST untuk mengelola data dalam basis data server web.

### Link berita acara 

https://docs.google.com/spreadsheets/d/1judTlCUSbn3VJkPtibodogsr5YUfOiIIVIW_4Ir_ViM/edit?usp=sharing