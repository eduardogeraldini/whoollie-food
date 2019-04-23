<?php

namespace WHOOLLIEFOOD\MODEL;

use \WHOOLLIEFOOD\DB\Sql;
use \WHOOLLIEFOOD\MODEL\Product;

class Cart{

	private $products = [];
    
	public function __construct() {
        $this->idCompany = $_SESSION['User']['idCompany'];
        
        if (isset($_SESSION["Cart"]))
            $this->setProducts($_SESSION["Cart"]);
    }

    function __destruct() {
        $_SESSION["Cart"] = $this->products;
    }
    
    public function setProducts($products) {
        $this->products = $products;
    }

    public function getProducts() {

        $arr = [];

        foreach ($this->products as $key => $value) {
            
            $product = new Product();
            $product->setAllPropertiesById($key);

            array_push($arr, [
                "idProduct" => $key,
                "desName" => $product->getDesName(),
                "qtTotal" => $value,
                "vlUnity" => $product->getVlUnity(),

            ]);

           /* $arr[$key]["desName"] = $product->getDesName();
            $arr[$key]["qtTotal"] = $value;
            $arr[$key]["vlUnity"] = $product->getVlUnity(); */

        }

        return $arr;

    }

    public function addProductToCart($idProduct) {
        if (!isset($this->products[$idProduct])) {
            $this->products[$idProduct] = 1;
        } else {
            $this->products[$idProduct]++;
        }    
    }

    public function removeProductCart($idProduct) {
        if (isset($this->products[$idProduct])) {
            $this->products[$idProduct]--;

            if ($this->products[$idProduct] <= 0) {
                unset($this->products[$idProduct]);
            }
        } 
    }

    public function removeAllProductsCart($idProduct) {
        if (isset($this->products[$idProduct])) {
            unset($this->products[$idProduct]);
        } 
    }

    public function clearCart() {
        $this->products = [];
    }

}

?>