$(document).on('turbolinks:load', function() {
    $('input#exampleInputEmail1').autocomplete({
      source: '/servicerequest/autocomplete_primary_technician',
      minLength: 2
    });
  
    $('input[name="servicehandler[subhandler][]"]').autocomplete({
      source: '/servicerequest/autocomplete_secondary_technician',
      minLength: 2
    });
  });