$(function() {
    $("form").submit(function(e) {
            
        e.preventDefault();

        $.post('/api/login', $(this).serialize(), function(data) {
            alert(JSON.parse(data).message);
        });

    });
});