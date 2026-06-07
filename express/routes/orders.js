const express = require('express');
const db = require('../database/database');
const { verifyToken } = require('../middleware/jwtAuth');

const router = express.Router();

router.post('/', verifyToken, async function (req, res) {
  try {
    const userId = req.user.id;
    const { equipmentId, quantity } = req.body;
    if (!equipmentId || !quantity || Number(quantity) <= 0) {
      return res.status(400).json({ success: false, message: 'Equipment dan jumlah pembelian diperlukan.' });
    }

    const [rows] = await db.query('SELECT id, name, stock, price FROM equipment WHERE id = ?', [Number(equipmentId)]);
    if (rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Equipment tidak ditemukan.' });
    }
    const equipment = rows[0];
    if (equipment.stock < Number(quantity)) {
      return res.status(400).json({ success: false, message: 'Stok tidak cukup untuk pesanan ini.' });
    }

    const total = equipment.price * Number(quantity);
    await db.query('INSERT INTO orders (user_id, equipment_id, quantity, total) VALUES (?, ?, ?, ?)', [userId, equipmentId, Number(quantity), total]);
    await db.query('UPDATE equipment SET stock = stock - ? WHERE id = ?', [Number(quantity), equipmentId]);
    return res.status(201).json({ success: true, message: 'Pembelian berhasil. Terima kasih telah membeli.' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: 'Gagal membuat pesanan.' });
  }
});

router.get('/', verifyToken, async function (req, res) {
  try {
    const userId = req.user.id;
    const [rows] = await db.query(
      'SELECT o.id, o.quantity, o.total, o.created_at AS purchasedAt, e.name AS equipmentName FROM orders o JOIN equipment e ON o.equipment_id = e.id WHERE o.user_id = ? ORDER BY o.created_at DESC',
      [userId]
    );
    return res.json({ success: true, data: rows });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ success: false, message: 'Gagal memuat daftar pesanan.' });
  }
});

module.exports = router;
