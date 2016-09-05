// $(document).ready(function() {
// 	$('.login a').hover(function() {
// 		$(this).fadeOut(100);
// 		$(this).fadeIn(500);
// 	})
// });

// $( "nav div.login a" ).hover(function() {
//   $( this ).fadeOut( 100 );
//   $( this ).fadeIn( 500 );
// });

$(document).ready(function(){
	$('img').hover(function() {
    	$(this).attr({
        src: $(this).attr('data-other-src') 
        , 'data-other-src': $(this).attr('src') 
    })
  })
});

$(document).ready(function(){
    function create_td(str){
        return '<td>' + str + '</td>';
    }

    function create_link(str){
        return '<a href="' + str + '">' + str + '</a>';
    }

    $('div.container').click(function() {
    	$(this).effect('shake')
    });

    $('form').submit(function(e){
        e.preventDefault();
        $.ajax({
            url: '/url',
            method: 'POST',
            data: $(this).serialize(),
            dataType: 'json',
            beforeSend: function(){
                $('#submit-btn').val('Loading');
                $('#submit-txt').val('')//.attr('placeholder', 'aaa');

            },
            success: function(data){
                $('#submit-btn').val('DONE');
                $('.info').append('<p>Your short url is:' + create_link(data.short_url) + '</p>');
                // setTimeout(function(){ $('#submit-btn').val('LONGER!'); }, 1000);
                str = '';
                
                long_url_link = create_link(data.long_url);
                str += create_td(long_url_link);

                short_url_link = create_link(data.short_url);
                str += create_td(short_url_link);

                str += create_td(data.click_count);

                $('tr:first-child').after('<tr>' + str + '</tr>');
                $('#success').text('Your URL has been cut');

            },
            error: function(data){
            	$('#error').text(data.responseText);
            	
            },

            complete: function(){
            	$('#submit-btn').val('CUT!');
            	setTimeout(function() { $('#error, #success').text(''); }, 2000);
            }
        });
    });
});
