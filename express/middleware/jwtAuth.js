const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'wuthering_wares_secret_2026';

function createToken(user) {
  return jwt.sign(
    {
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
    },
    JWT_SECRET,
    { expiresIn: '12h' }
  );
}

function verifyToken(req, res, next) {
  const authHeader = req.headers.authorization || req.headers.Authorization;
  if (!authHeader || typeof authHeader !== 'string') {
    return res.status(401).json({ success: false, message: 'Authorization header missing' });
  }

  const parts = authHeader.split(' ');
  if (parts.length !== 2 || parts[0] !== 'Bearer') {
    return res.status(401).json({ success: false, message: 'Bearer token required' });
  }

  const token = parts[1];
  jwt.verify(token, JWT_SECRET, (error, decoded) => {
    if (error) {
      return res.status(401).json({ success: false, message: 'Invalid or expired token' });
    }

    req.user = decoded;
    next();
  });
}

module.exports = {
  createToken,
  verifyToken,
};
