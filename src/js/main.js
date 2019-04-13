$(function () {
    
    $.getJSON('/api/currentEmployee', function (data) {
        $("#spanCompanyName").html(data[0].desName);
        $("#spanCompanyName").data("id", data[0].idEmployee);
        
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

function numberToReal(number) {
    var number = number.toFixed(2).split('.');
    number[0] = "R$ " + number[0].split(/(?=(?:...)*$)/).join('.');
    return number.join(',');
}