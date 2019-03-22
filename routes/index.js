var express = require('express');
var conn = require('./../inc/db');
var router = express.Router();

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Whollie Services' });
}); 

module.exports = router;
