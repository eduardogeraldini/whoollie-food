$(function () {
    
    $.getJSON('/api/currentEmployee', function (data) {
        $("#spanCompanyName").html(data[0].desName);
    }).fail(function () {
        console.log("Rota não encontrada!");
    });

    $("#btnLogout").click(function () {

        $.get('/api/logout', function () { }).then(() => {
            window.location.href = "/entrar";
        });

    });

    $("input").on("focus", function() {
        $(this).removeClass("border");
        $(this).removeClass("border-danger");
    });

});

function formValidate(idForm) {
    
    let error = false;

    $(`#${idForm} input`).each(function() {
        if ($(this).data("require") && $(this).val() == "") {
            $(this).addClass('border');
            $(this).addClass('border-danger');
            
            error = true;
        }
    });

    return !error;

}