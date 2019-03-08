var express = require('express');
//var conn = require('./../inc/db');
var router = express.Router();

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Whollie Services' });
});

/* router.get("/db", function (req, res, next) {

  conn.query("SELECT * FROM tb_clientes", (err, results) => {

    if (err) {
      res.send(err);
    } else {
      res.send(results);
    }

  });

}); */ 



module.exports = router;
