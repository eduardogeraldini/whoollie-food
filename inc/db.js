const mysql = require('mysql2');

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'dbwhoolliefood',
    password: ''
  });

module.exports = connection;