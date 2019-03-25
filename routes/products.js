var express = require('express');
var conn = require('./../inc/db');
var router = express.Router();

/* GET home page. */
router.get('/criar', function (req, res, next) {
  res.render('criarProdutos', { title: 'Whollie FooD - Produtos' });
}); 

router.get('/', function (req, res, next) {
  res.render('visualizarProdutos', { title: 'Whollie FooD - Produtos' });
}); 

router.get('/categorias/criar', function (req, res, next) {
  res.render('criarCategorias', { title: 'Whollie FooD - Produtos' });
}); 

router.get('/categorias/', function (req, res, next) {
  res.render('/', { title: 'Whollie FooD - Produtos' });
}); 


module.exports = router;
