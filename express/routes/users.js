var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.post('/register', function(req, res, next) {
  const data = req.body
  db.query(
    `INSERT INTO users (username, email, password) VALUES ("")`
  )
})

module.exports = router;
