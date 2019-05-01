$(function () {

    toastr.options = {
        "closeButton": false,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-bottom-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
    
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

    $(".btn-loading").click(function(e) {
        let html = $(this).html();

        $(this).attr("disabled", true);
        $(this).html("<img src='/res/admin/img/loader.gif' width='20px'/>");

        setTimeout(() => {
            $(this).html(html);
            $(this).attr("disabled", false);
        }, 1000);
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

    if (number == undefined) {
        return "0,00";
    }

    var number = number + ""; 
    number = number.split('.');
    number[0] = number[0].split(/(?=(?:...)*$)/).join('.');
    return number.join(',');
}

function numberToReal(number) {

    if (number == undefined) {
        return "R$ 00,00";
    }

    var number = number + ""; 
    number = number.split('.');
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

function getRandomColor() { 
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

function showDate(date, withHours = true){

    let dateFormated = new Date(date);

    let day = ('0' + dateFormated.getDate()).slice(-2);
    let month = ('0' + (dateFormated.getMonth()+1)).slice(-2);
    let year = dateFormated.getFullYear();
    let hour = ('0' + dateFormated.getHours()).slice(-2);
    let minutes = ('0' + dateFormated.getMinutes()).slice(-2);

    if(withHours){
        return day + "/" + month + "/" + year + " " + hour + ":" + minutes;
    } else {
        return day + "/" + month + "/" + year;
    }

}