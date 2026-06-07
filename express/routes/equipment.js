const express = require('express');
const db = require('../database/database');
const { verifyToken } = require('../middleware/jwtAuth');

const router = express.Router();

router.get('/', async function (req, res) {
  try {
    const [rows] = await db.query('SELECT id, name, type, description, stock, image_url AS imageUrl, price FROM equipment ORDER BY id');
    return res.json({ success: true, data: rows });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: 'Gagal memuat daftar equipment.' });
  }
});

router.get('/:id', async function (req, res) {
  try {
    const equipmentId = Number(req.params.id);
    const [rows] = await db.query('SELECT id, name, type, description, stock, image_url AS imageUrl, price FROM equipment WHERE id = ?', [equipmentId]);
    if (rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Equipment tidak ditemukan.' });
    }
    return res.json({ success: true, data: rows[0] });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: 'Gagal memuat detail equipment.' });
  }
});

router.post('/', verifyToken, async function (req, res) {
  try {
    if (req.user.role !== 'admin') {
      return res.status(403).json({ success: false, message: 'Akses terlarang: hanya admin yang boleh membuat equipment.' });
    }

    const { name, type, description, stock, imageUrl, price } = req.body;
    if (!name || !type || !description || !imageUrl || stock == null || price == null) {
      return res.status(400).json({ success: false, message: 'Semua field equipment harus diisi.' });
    }
    await db.query(
      'INSERT INTO equipment (name, type, description, stock, image_url, price) VALUES (?, ?, ?, ?, ?, ?)',
      [name, type, description, Number(stock), imageUrl, Number(price)]
    );
    return res.status(201).json({ success: true, message: 'Equipment berhasil ditambahkan.' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: 'Gagal membuat equipment.' });
  }
});

router.put('/:id', verifyToken, async function (req, res) {
  try {
    if (req.user.role !== 'admin') {
      return res.status(403).json({ success: false, message: 'Akses terlarang: hanya admin yang boleh memperbarui equipment.' });
    }
    const equipmentId = Number(req.params.id);
    const { name, type, description, stock, imageUrl, price } = req.body;
    const [result] = await db.query(
      'UPDATE equipment SET name = ?, type = ?, description = ?, stock = ?, image_url = ?, price = ? WHERE id = ?',
      [name, type, description, Number(stock), imageUrl, Number(price), equipmentId]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Equipment tidak ditemukan.' });
    }
    return res.json({ success: true, message: 'Equipment berhasil diperbarui.' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: 'Gagal memperbarui equipment.' });
  }
});

router.delete('/:id', verifyToken, async function (req, res) {
  try {
    if (req.user.role !== 'admin') {
      return res.status(403).json({ success: false, message: 'Akses terlarang: hanya admin yang boleh menghapus equipment.' });
    }
    const equipmentId = Number(req.params.id);
    const [result] = await db.query('DELETE FROM equipment WHERE id = ?', [equipmentId]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Equipment tidak ditemukan.' });
    }
    return res.json({ success: true, message: 'Equipment berhasil dihapus.' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: 'Gagal menghapus equipment.' });
  }
});

module.exports = router;
