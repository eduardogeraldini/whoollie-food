<?php

    const PATHVIEWS = "views";

    function renderPage($module, $page, $singularPage = false) {

        if (!$singularPage) {
            require_once("views/inc/header.html");
        }

        if ($module != "")
            $module .= "/";
        
        require_once(PATHVIEWS . "/" . $module . $page . ".html");

        if (!$singularPage) {
            require_once("views/inc/footer.html");
        }
    }

?>