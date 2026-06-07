# Wuthering Wares - Dokumentasi Proyek

## Daftar Isi
1. [Ringkasan Proyek](#ringkasan-proyek)
2. [Persyaratan Fungsional](#persyaratan-fungsional)
3. [Arsitektur Sistem](#arsitektur-sistem)
4. [Petunjuk Instalasi & Menjalankan](#petunjuk-instalasi--menjalankan)
5. [Database](#database)
6. [API Endpoints](#api-endpoints)
7. [Fitur UI & Desain](#fitur-ui--desain)
8. [Validasi Data](#validasi-data)
9. [Otentikasi & Token Bearer](#otentikasi--token-bearer)
10. [Perubahan Struktur](#perubahan-struktur)

---

## Ringkasan Proyek

**Wuthering Wares** adalah aplikasi marketplace mobile yang memungkinkan user membeli peralatan resonator. Admin dapat mengelola inventori equipment (CREATE, READ, UPDATE, DELETE), sementara user dapat melihat, membeli equipment, dan melihat riwayat pembelian mereka.

- **Frontend:** Flutter (Mobile App)
- **Backend:** Node.js + Express.js
- **Database:** MySQL
- **Fitur Autentikasi:** Login/Register + Google OAuth
- **Token:** JWT Bearer Token (20+ karakter alfanumerik)

---

## Persyaratan Fungsional

### 1. Database (MySQL) ✅
- **CREATE:** POST `/api/equipment` - Admin menambah equipment baru
- **READ:** GET `/api/equipment`, GET `/api/equipment/:id` - Mengambil daftar/detail equipment
- **UPDATE:** PUT `/api/equipment/:id` - Admin memperbarui equipment
- **DELETE:** DELETE `/api/equipment/:id` - Admin menghapus equipment
- **Tambahan:** POST `/api/orders` - User membuat order pembelian

### 2. Frontend (Flutter) ✅
**5 Halaman:**
1. **Login Page** - Autentikasi user dengan username/password
2. **Sign Up Page** - Registrasi user baru
3. **Market Page** - Daftar equipment dengan opsi beli
4. **Equipment Detail Page** - Detail equipment + tombol beli
5. **Order List Page** - Riwayat pembelian user
6. **Admin Page** - Daftar equipment untuk dikelola admin
7. **Admin Equipment Page** - Form tambah/edit equipment

**5+ UI Components:**
- TextField (untuk input)
- Card (untuk menampilkan equipment)
- ListView (untuk list equipment)
- ElevatedButton (untuk aksi)
- CircularProgressIndicator (loading)
- AppBar, Image, Container, AlertDialog, ScaffoldMessenger

**3 Validasi Data:**
1. **Username/Email Validation** - Format dan keunikan
2. **Password Validation** - Minimal 6 karakter + konfirmasi
3. **Equipment Input Validation** - Semua field wajib diisi, stok > 0

### 3. Backend (Node.js + Express) ✅
**4+ Endpoints:**
- **GET** `/api/equipment` - Ambil semua equipment
- **GET** `/api/equipment/:id` - Ambil equipment by ID
- **POST** `/api/auth/login` - Login user
- **POST** `/api/auth/register` - Registrasi user
- **POST** `/api/equipment` - Buat equipment (Admin)
- **PUT** `/api/equipment/:id` - Update equipment (Admin)
- **DELETE** `/api/equipment/:id` - Hapus equipment (Admin)
- **POST** `/api/orders` - Buat order pembelian
- **GET** `/api/orders` - Ambil order user

### 4. Otentikasi ✅
- **Local Auth:** Login dengan username & password dari database
- **OAuth:** Google OAuth (integrasi dengan google-auth-library)
- **Token Bearer:** JWT token dengan payload minimum 20 karakter
  - Format: `Authorization: Bearer <token>`
  - Token berisi: `id`, `username`, `email`, `role`
  - Expiry: 12 jam
- **Verifikasi:** Middleware `verifyToken` di endpoints yang memerlukan auth

### 5. Desain UI (Dark Theme dengan 2-4 Perubahan Properti) ✅

**Tema Utama: Dark Mode - Wuthering Waves Aesthetic**

| Properti | Nilai | Catatan |
|----------|-------|---------|
| **Latar Belakang** | `#0C1325` (Navy Gelap) | Warna dasar gelap untuk mata nyaman |
| **Primary Color** | `#6C63FF` (Purple Biru) | Aksen utama untuk tombol & highlight |
| **Secondary Color** | `#8E8DFF` (Purple Terang) | Variasi accent |
| **AppBar Background** | `#16213E` (Navy Dalam) | Kontras dengan background |
| **Font Size (Title)** | 32px, 20px, 16px | Hierarchy jelas |
| **Font Weight** | 700 (Bold), 600 (Semibold) | Emphasis pada judul |
| **Text Color** | `Colors.white` (Utama), `Colors.white70`, `Colors.white60` | Kontras terjamin |
| **Border Radius** | 8-12px | Desain modern rounded |
| **Opacity** | 0.2-0.3 pada overlay | Transparansi subtle |

**Perubahan dari Default Material:**
1. ✅ Background color: Dari putih → navy gelap (`#0C1325`)
2. ✅ Primary color: Default → purple biru (`#6C63FF`)
3. ✅ Font weight & size: Custom theme untuk title & body
4. ✅ Border radius: Semua input & button → 12px (rounded modern)

---

## Arsitektur Sistem

```
Frontend (Flutter)
├── lib/
│   ├── main.dart (Theme + Routing)
│   ├── login_form.dart (Login UI + Validasi)
│   ├── signup_form.dart (Register UI + Validasi)
│   ├── apis/
│   │   └── profile.dart (API Service dengan JWT)
│   ├── data_models/
│   │   ├── equipment.dart (Model Equipment)
│   │   ├── order.dart (Model Order)
│   │   └── equipment_detail.dart (Extends Equipment)
│   └── pages/
│       ├── market_page.dart (Daftar Equipment)
│       ├── equipment_detail_page.dart (Detail + Buy)
│       ├── order_list_page.dart (Order History)
│       ├── admin_page.dart (Admin Dashboard)
│       ├── admin_equipment_page.dart (Form Create/Edit)
│       └── checkout_page.dart (Placeholder)

Backend (Node.js + Express)
├── bin/
│   └── www (Entry Point, Port 3000)
├── database/
│   └── database.js (MySQL Connection + Schema Init)
├── middleware/
│   └── jwtAuth.js (JWT Token Handler)
├── routes/
│   ├── auth.js (Login, Register, Google OAuth)
│   ├── equipment.js (CRUD Equipment)
│   ├── orders.js (Create & Get Orders)
│   ├── index.js (Homepage)
│   └── users.js (Legacy)
├── app.js (Express Setup)
├── package.json (Dependencies)
└── bin/www (Server Config)

Database (MySQL)
├── wuthering_wares (Database)
├── users (Tabel Auth)
├── equipment (Tabel Inventory)
└── orders (Tabel Orders)
```

---

## Petunjuk Instalasi & Menjalankan

### Backend Setup

**1. Install Dependencies:**
```bash
cd express
npm install
```

**Packages yang ditambahkan:**
- `bcryptjs` - Password hashing
- `cors` - Cross-origin support
- `jsonwebtoken` - JWT token
- `google-auth-library` - Google OAuth
- `mysql2` - Database

**2. Konfigurasi Database:**

Buat database MySQL:
```sql
CREATE DATABASE wuthering_wares;
```

Database schema akan otomatis dibuat saat server startup.

**3. Environment Variables (Opsional):**
```bash
# .env file (tidak di-include, buat manual)
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=wuthering_wares
JWT_SECRET=wuthering_wares_secret_2026
GOOGLE_CLIENT_ID=YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com
```

**4. Jalankan Server:**
```bash
npm start
# Server berjalan di http://localhost:3000
```

### Frontend Setup

**1. Install Flutter Dependencies:**
```bash
flutter pub get
```

**2. Update Android/iOS Settings:**
- Android: Ubah target SDK ke `33+`
- iOS: Update podspec jika perlu
- Web: Sudah support CORS

**3. Jalankan Aplikasi:**

**Android Emulator:**
```bash
flutter run
```

**iOS Simulator:**
```bash
flutter run -d "iPhone"
```

**Web:**
```bash
flutter run -d chrome
```

**4. Backend URL:**
- **Android Emulator:** `http://10.0.2.2:3000/api`
- **Physical Device:** `http://<PC_IP>:3000/api`
- **iOS/Web:** `http://localhost:3000/api`

---

## Database

### Skema Tabel

#### `users` Table
```sql
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(128) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('user','admin') NOT NULL DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### `equipment` Table
```sql
CREATE TABLE equipment (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  type VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  image_url TEXT NOT NULL,
  price INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### `orders` Table
```sql
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  equipment_id INT NOT NULL,
  quantity INT NOT NULL,
  total INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (equipment_id) REFERENCES equipment(id) ON DELETE CASCADE
);
```

### Akun Default
- **Username:** `admin`
- **Email:** `admin@wuthering.com`
- **Password:** `admin123`
- **Role:** `admin`

---

## API Endpoints

### Authentication

#### POST `/api/auth/register`
**Request:**
```json
{
  "username": "username",
  "email": "user@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Registrasi berhasil.",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "username": "username",
    "email": "user@example.com",
    "role": "user"
  }
}
```

#### POST `/api/auth/login`
**Request:**
```json
{
  "username": "admin",
  "password": "admin123"
}
```

**Response:** (sama dengan register)

#### POST `/api/auth/google`
**Request:**
```json
{
  "idToken": "GOOGLE_ID_TOKEN"
}
```

**Response:** (sama dengan register)

---

### Equipment (Public Read, Admin Write)

#### GET `/api/equipment`
**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "Stringmaster",
      "type": "Rectifier",
      "description": "...",
      "stock": 5,
      "imageUrl": "https://...",
      "price": 80
    }
  ]
}
```

#### GET `/api/equipment/:id`
**Response:** Single equipment object

#### POST `/api/equipment` (Admin Only)
**Headers:** `Authorization: Bearer <token>`
**Request:**
```json
{
  "name": "Equipment Name",
  "type": "Type",
  "description": "Description",
  "stock": 10,
  "imageUrl": "https://...",
  "price": 100
}
```

#### PUT `/api/equipment/:id` (Admin Only)
**Headers:** `Authorization: Bearer <token>`
**Request:** (sama dengan POST)

#### DELETE `/api/equipment/:id` (Admin Only)
**Headers:** `Authorization: Bearer <token>`

---

### Orders (Auth Required)

#### POST `/api/orders`
**Headers:** `Authorization: Bearer <token>`
**Request:**
```json
{
  "equipmentId": 1,
  "quantity": 2
}
```

#### GET `/api/orders`
**Headers:** `Authorization: Bearer <token>`
**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "equipmentName": "Stringmaster",
      "quantity": 2,
      "total": 160,
      "purchasedAt": "2025-06-07T10:30:00Z"
    }
  ]
}
```

---

## Fitur UI & Desain

### Komponen UI yang Digunakan

| Komponen | Deskripsi | Lokasi |
|----------|-----------|--------|
| **TextField** | Input form (username, password, equipment data) | Login, Signup, Admin Equipment |
| **Card** | Container rounded untuk daftar item | Market, Admin Page, Order List |
| **ListView** | Scrollable list items | Market, Admin, Order History |
| **ElevatedButton** | Tombol aksi utama | Login, Signup, Buy, Delete |
| **AppBar** | Header dengan title & actions | Semua pages |
| **CircularProgressIndicator** | Loading spinner | Saat loading atau submit |
| **Image.network** | Tampil gambar dari URL | Equipment Card & Detail |
| **Container** | Wrapper dengan styling | Badges, error messages |
| **AlertDialog** | Konfirmasi delete | Admin delete equipment |
| **ScaffoldMessenger + SnackBar** | Toast notification | Success/error messages |

### Warna & Styling

**Theme Colors:**
- Background: `#0C1325` (Navy Gelap)
- Primary: `#6C63FF` (Purple Biru)
- AppBar: `#16213E`
- Text: White dengan opacity variants

**Typography:**
- Large Title: 32px, Bold (700)
- Title: 20px, Bold (600)
- Body: 16px, Regular
- Caption: 14px-12px, Light opacity

**Radius & Spacing:**
- Border Radius: 12px (buttons, inputs, cards)
- Padding: Consistent 12-20px
- Gap (SizedBox): 8-24px untuk spacing

---

## Validasi Data

### 1. Login Form
```dart
- Username tidak boleh kosong
- Password minimal 6 karakter
- Error message ditampilkan in-app
```

### 2. Sign Up Form
```dart
- Username tidak boleh kosong
- Email format valid (regex pattern)
- Password minimal 6 karakter
- Konfirmasi password harus cocok
- Duplikasi username/email ditolak server
```

### 3. Equipment Form (Admin)
```dart
- Semua field wajib diisi (nama, type, deskripsi, stok, URL, harga)
- Stok dan harga harus angka positif
- URL image harus valid format
- Server validasi ulang sebelum insert/update
```

---

## Otentikasi & Token Bearer

### JWT Token
- **Algoritma:** HS256
- **Secret:** `wuthering_wares_secret_2026`
- **Payload:**
  ```json
  {
    "id": 1,
    "username": "admin",
    "email": "admin@wuthering.com",
    "role": "admin"
  }
  ```
- **Durasi:** 12 jam
- **Panjang:** 200+ karakter (JWT alphanumeric)

### Middleware Verifikasi
```javascript
// jwtAuth.js - verifyToken middleware
- Cek Authorization header
- Parse Bearer token
- Verify signature & expiry
- Attach user ke request
- Reject jika invalid/expired
```

### Flow Otentikasi

**Login/Register:**
1. User masukkan credentials
2. Frontend kirim ke `/api/auth/login` atau `/api/auth/register`
3. Backend hash password (bcryptjs), verify, generate JWT
4. Frontend store token di variable global
5. Token attach ke setiap request authenticated

**Google OAuth:**
1. Frontend ambil idToken dari Google Sign-In
2. Kirim ke `/api/auth/google`
3. Backend verify token dengan Google library
4. Auto-create user jika baru, generate JWT
5. Same flow seperti login

---

## Perubahan Struktur

### Frontend

**File yang Ditambahkan:**
- ✅ `lib/data_models/order.dart` - Model Order baru
- ✅ `lib/apis/profile.dart` - API service lengkap (rewritten)

**File yang Dimodifikasi:**
- ✅ `lib/main.dart` - Tambah tema dark, routing setup
- ✅ `lib/login_form.dart` - Tambah validasi, API integration
- ✅ `lib/signup_form.dart` - Tambah validasi, API integration
- ✅ `lib/pages/market_page.dart` - Integrase API, loading UI
- ✅ `lib/pages/equipment_detail_page.dart` - Tambah buy feature
- ✅ `lib/pages/admin_page.dart` - Integrase API equipment
- ✅ `lib/pages/admin_equipment_page.dart` - Form create/update
- ✅ `lib/pages/order_list_page.dart` - Implementasi order history
- ✅ `lib/pages/checkout_page.dart` - Placeholder halaman
- ✅ `lib/data_models/equipment.dart` - Tambah fromJson/toJson

**Dependencies yang Ditambahkan (pubspec.yaml):**
- Sudah ada: `http: ^1.6.0` (untuk API calls)

### Backend

**File yang Ditambahkan:**
- ✅ `express/middleware/jwtAuth.js` - JWT auth handler
- ✅ `express/routes/auth.js` - Authentication endpoints
- ✅ `express/routes/equipment.js` - CRUD equipment
- ✅ `express/routes/orders.js` - Order management

**File yang Dimodifikasi:**
- ✅ `express/app.js` - Tambah routes & CORS
- ✅ `express/database/database.js` - Rewrite dengan pool, schema init, bcrypt
- ✅ `express/package.json` - Tambah dependencies

**Dependencies yang Ditambahkan (package.json):**
```json
{
  "bcryptjs": "^2.4.3",
  "cors": "^2.8.5",
  "jsonwebtoken": "^9.0.0",
  "google-auth-library": "^11.0.0"
}
```

### Database

**Schema yang Dibuat:**
- ✅ `users` table - untuk autentikasi
- ✅ `equipment` table - untuk inventory
- ✅ `orders` table - untuk order history
- ✅ Default admin user di-seed saat startup

---

## Checklist Persyaratan

### Database (MySQL) ✅
- [x] CREATE - POST `/api/equipment` (Admin)
- [x] READ - GET `/api/equipment`, GET `/api/equipment/:id`
- [x] UPDATE - PUT `/api/equipment/:id` (Admin)
- [x] DELETE - DELETE `/api/equipment/:id` (Admin)

### Frontend (Flutter Mobile) ✅
- [x] 5+ Halaman (Login, Signup, Market, Equipment Detail, Orders, Admin, Admin Equipment)
- [x] 5+ UI Components (TextField, Card, ListView, ElevatedButton, Image, AppBar, Container, AlertDialog, SnackBar, Progress)
- [x] 3+ Validasi (Login validation, Signup validation, Equipment validation)
- [x] Error messages tertampil di UI

### Backend (Node.js + Express) ✅
- [x] 2+ GET requests (`/api/equipment`, `/api/equipment/:id`, `/api/orders`)
- [x] 1+ POST/PUT/DELETE requests (`/api/equipment`, `/api/orders`, delete, update)
- [x] Token verification di endpoints authenticated

### Otentikasi ✅
- [x] Login dengan database (username + password)
- [x] Register user baru
- [x] Google OAuth integration
- [x] JWT Bearer Token (20+ chars, alphanumeric)
- [x] Token verification di middleware

### Desain UI ✅
- [x] Tema dark konsisten (background #0C1325, primary #6C63FF)
- [x] 2+ Property changes (background, primary color, font weight, border radius)
- [x] Kontras warna cukup (white text on dark bg)
- [x] UI tidak menghambat usability
- [x] Documented dalam README

---

## Catatan Tambahan

- **Emulator/Device:** Pastikan backend URL sesuai (10.0.2.2 untuk Android emulator, localhost untuk iOS/Web)
- **Debugging:** Enable logging di Flutter & Node.js untuk troubleshoot
- **Production:** Ganti JWT_SECRET dengan yang lebih aman, setup proper CORS
- **Database Backup:** Recommend backup reguler untuk production

---

**Last Updated:** 7 Juni 2026
**Status:** ✅ Semua persyaratan terpenuhi
