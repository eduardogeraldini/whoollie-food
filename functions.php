<?php

    const PATHVIEWS = "views";

    function renderPage($module, $page, $singularPage = false, $script = "") {

        if (!$singularPage) {
            require_once("views/inc/header.html");
        }

        if ($module != "")
            $module .= "/";
        
        require_once(PATHVIEWS . "/" . $module . $page . ".html");

        if (!$singularPage) {
            require_once("views/inc/footer.html");
        }

        if ($script != "") {
            require_once("src/js/" . $script . ".html");
        }

    }

    function initialize($path) {
        
        require_once("vendor/autoload.php");

        $app = new \Slim\App([
            'debug'=> true
        ]);
        
        foreach($path as $key) {

            $key = "routes/".$key."/";
            $directory = dir($key);
            
            while($arquivo = $directory -> read()){
                if(is_file($key.$arquivo))
                    include($key.$arquivo);
            }
            
            $directory -> close();
        
        }

        $app->run();

    }

    function deleteFile($filename) {
        if (file_exists(substr($filename, 1, strlen($filename) - 1))) {
            unlink(substr($filename, 1, strlen($filename) - 1));
        }
    }

?>