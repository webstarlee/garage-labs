setTimeout(function() {
    $('.datepicker').datetimepicker({
        format: 'Y-M-D'
    });
}, 500);

$(window).bind('routeChanged', function() {
    setTimeout(function() {
        $('.datepicker').datetimepicker({
            format: 'Y-M-D'
        });
    }, 200);
});