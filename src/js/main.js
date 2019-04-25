$(function () {

    $('.cpf').mask('000.000.000-00', {reverse: true});
    $('.cnpj').mask('00.000.000/0000-00', {reverse: true});
    $('.money').mask('000.000.000.000.000,00', {reverse: true});
    
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

function numberToShow(number) {
    var number = number.split('.');
    number[0] = number[0].split(/(?=(?:...)*$)/).join('.');
    return number.join(',');
}

function numberToReal(number) {
    var number = number.split('.');
    number[0] = "R$ " + number[0].split(/(?=(?:...)*$)/).join('.');
    return number.join(',');
}

function showDateTime(datetime) {

    var date = new Date(datetime);
    return ("0" + date.getDate()).slice(-2) + '/' + 
           ("0" + (date.getMonth()+1)).slice(-2) + '/' +  
           date.getFullYear() + ' ' + 
           ("0" + date.getHours()).slice(-2) + ':' + 
           ("0" + date.getMinutes()).slice(-2) + ':' + 
           ("0" + date.getSeconds()).slice(-2);

}