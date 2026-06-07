const mysql2 = require('mysql2')
const database = mysql2.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "wuthering_wares"
})

database.connect()
module.exports = database