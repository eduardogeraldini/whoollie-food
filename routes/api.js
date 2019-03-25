var express = require('express');
var conn = require('./../inc/db');
var router = express.Router();

router.get("/empresas", function (req, res, next) {

    conn.query("SELECT * FROM tbEmpresas", (err, results) => {
  
      if (err) {
        res.send(err);
      } else {
        res.send(results);
      }
  
    });
  
});


router.get("/produtos", function (req, res, next) {

  conn.query("SELECT * FROM tbProdutos", (err, results) => {

    if (err) {
      res.send(err);
    } else {
      res.send(results);
    }

  });

});


module.exports = router;
