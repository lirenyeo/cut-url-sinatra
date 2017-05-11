$(document).ready(function() {
  function create_td(str) {
    return '<td>' + str + '</td>';
  }

  function create_link(str) {
    return '<a href="' + str + '">' + str + '</a>';
  }

  $('form').submit(function(e) {
    e.preventDefault();
    $.ajax({
      url: '/url',
      method: 'POST',
      data: $(this).serialize(),
      dataType: 'html',
      beforeSend: function() {
        $('#submit-btn').val('Loading');
        $('#submit-txt').val(''); //.attr('placeholder', 'aaa');
        $('#load-icon').css('visibility', 'visible');

      },
      success: function(data) {
        console.log(data)
        $("#table").html(data);
        // var base_url = $("#submit-txt").data('url');
        // $('#submit-btn').val('DONE');
        // $('.info').append('<p>Your short url is:' + create_link(data.short_url) + '</p>');
        // // setTimeout(function(){ $('#submit-btn').val('LONGER!'); }, 1000);
        // str = '';

        // long_url_link = create_link(data.long_url);
        // str += create_td(long_url_link);

        // short_url_link = create_link(data.short_url);
        // str += create_td(base_url + '/' + short_url_link);

        // str += create_td(data.click_count);

        // $('tr:first-child').after('<tr>' + str + '</tr>');
        $('#success').text('Your URL has been cut');

      },
      error: function(data) {
        $('#error').text(data.responseText);
      },

      complete: function() {
        $('#load-icon').css('visibility', 'hidden');
        $('#submit-btn').val('CUT!');
        setTimeout(function() {
          $('#error, #success').text('');
        }, 2000);
      }
    });
  });
});