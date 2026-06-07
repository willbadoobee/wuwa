const express = require('express');
const bcrypt = require('bcryptjs');
const { OAuth2Client } = require('google-auth-library');
const db = require('../database/database');
const { createToken } = require('../middleware/jwtAuth');

const router = express.Router();
const GOOGLE_CLIENT_ID = process.env.GOOGLE_CLIENT_ID || 'YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com';
const googleClient = new OAuth2Client(GOOGLE_CLIENT_ID);

async function getUserCount() {
  const [rows] = await db.query('SELECT COUNT(*) AS count FROM users');
  return rows[0]?.count || 0;
}

router.post('/register', async function (req, res) {
  try {
    const { username, email, password } = req.body;
    if (!username || !email || !password) {
      return res.status(400).json({ success: false, message: 'Username, email, and password are required.' });
    }
    const emailPattern = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
    if (!emailPattern.test(email)) {
      return res.status(400).json({ success: false, message: 'Email tidak valid.' });
    }
    if (password.length < 6) {
      return res.status(400).json({ success: false, message: 'Password minimal 6 karakter.' });
    }

    const [existingUsers] = await db.query('SELECT id FROM users WHERE username = ? OR email = ?', [username, email]);
    if (existingUsers.length > 0) {
      return res.status(409).json({ success: false, message: 'Username atau email sudah digunakan.' });
    }

    const role = (await getUserCount()) === 0 ? 'admin' : 'user';
    const passwordHash = await bcrypt.hash(password, 10);
    const [result] = await db.query(
      'INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)',
      [username, email, passwordHash, role]
    );

    const token = createToken({ id: result.insertId, username, email, role });
    return res.status(201).json({ success: true, message: 'Registrasi berhasil.', token, user: { id: result.insertId, username, email, role } });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: 'Terjadi kesalahan pada server saat mendaftar.' });
  }
});

router.post('/login', async function (req, res) {
  try {
    const { username, password } = req.body;
    if (!username || !password) {
      return res.status(400).json({ success: false, message: 'Username dan password harus diisi.' });
    }

    const [rows] = await db.query(
      'SELECT id, username, email, password, role FROM users WHERE username = ? OR email = ?',
      [username, username]
    );
    if (rows.length === 0) {
      return res.status(401).json({ success: false, message: 'Username atau password salah.' });
    }

    const user = rows[0];
    const isValid = await bcrypt.compare(password, user.password);
    if (!isValid) {
      return res.status(401).json({ success: false, message: 'Username atau password salah.' });
    }

    const token = createToken(user);
    return res.json({ success: true, message: 'Login berhasil.', token, user: { id: user.id, username: user.username, email: user.email, role: user.role } });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: 'Terjadi kesalahan saat login.' });
  }
});

router.post('/google', async function (req, res) {
  try {
    const { idToken } = req.body;
    if (!idToken) {
      return res.status(400).json({ success: false, message: 'Google idToken diperlukan.' });
    }
    const ticket = await googleClient.verifyIdToken({ idToken, audience: GOOGLE_CLIENT_ID });
    const payload = ticket.getPayload();
    if (!payload || !payload.email || !payload.name) {
      return res.status(400).json({ success: false, message: 'Token Google tidak valid.' });
    }
    const username = payload.email.split('@')[0];
    const email = payload.email;
    const [rows] = await db.query('SELECT id, username, email, role FROM users WHERE email = ?', [email]);
    let user = rows[0];
    if (!user) {
      const generatedHash = await bcrypt.hash(Math.random().toString(36).substring(2, 15), 10);
      const [insertResult] = await db.query(
        'INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)',
        [username, email, generatedHash, 'user']
      );
      user = { id: insertResult.insertId, username, email, role: 'user' };
    }
    const token = createToken(user);
    return res.json({ success: true, message: 'Login Google berhasil.', token, user });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: 'Gagal memverifikasi login Google.' });
  }
});

module.exports = router;
