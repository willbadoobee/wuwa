<<<<<<< HEAD
const mysql2 = require('mysql2')
const database = mysql2.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "wuthering_wares"
})

database.connect()
module.exports = database
=======
const mysql2 = require('mysql2');
const bcrypt = require('bcryptjs');

const database = mysql2.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'wuthering_wares',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

const db = database.promise();

async function initializeSchema() {
  try {
    console.log('Starting database schema initialization...');

    // Verify connection
    const [pingResult] = await db.query('SELECT 1');
    console.log('✓ Database connection verified');

    // Create users table
    console.log('Creating users table...');
    await db.query(`
      CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(128) NOT NULL UNIQUE,
        email VARCHAR(255) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        role ENUM('user','admin') NOT NULL DEFAULT 'user',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    `);
    console.log('✓ users table ready');

    // Create equipment table
    console.log('Creating equipment table...');
    await db.query(`
      CREATE TABLE IF NOT EXISTS equipment (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        type VARCHAR(255) NOT NULL,
        description TEXT NOT NULL,
        stock INT NOT NULL DEFAULT 0,
        image_url TEXT NOT NULL,
        price INT NOT NULL DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    `);
    console.log('✓ equipment table ready');

    // Create orders table
    console.log('Creating orders table...');
    await db.query(`
      CREATE TABLE IF NOT EXISTS orders (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        equipment_id INT NOT NULL,
        quantity INT NOT NULL,
        total INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (equipment_id) REFERENCES equipment(id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    `);
    console.log('✓ orders table ready');

    // Seed default admin user if not exists
    console.log('Checking for default admin user...');
    const [adminRows] = await db.query('SELECT id FROM users WHERE username = ?', ['admin']);
    
    if (adminRows.length === 0) {
      console.log('Creating default admin user...');
      const passwordHash = await bcrypt.hash('admin123', 10);
      await db.query(
        'INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)',
        ['admin', 'admin@wuthering.com', passwordHash, 'admin']
      );
      console.log('✓ Default admin user created (username: admin, password: admin123)');
    } else {
      console.log('✓ Admin user already exists');
    }

    console.log('✓ Database initialization completed successfully!\n');
    return true;
  } catch (error) {
    console.error('✗ Database initialization error:', error.message);
    console.error('Error code:', error.code);
    console.error('Full error:', error);
    return false;
  }
}

// Export initialization function
db.initialize = initializeSchema;

module.exports = db;
>>>>>>> 7036f0e (backend + update frontend & database)
