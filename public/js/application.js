$(function() {

  $('form#tweetas').on('submit', function(e) {
    e.preventDefault();
    var tweetData = $('form#tweetas').serialize();
    $.ajax ({
      url: '/new/tweet',
      type: 'post',
      data: tweetData,
      beforeSend: function() {
        $('div.response').empty();
        $("form#tweetas :input").attr("disabled", true);
        $("<img id='wait' src='wait.gif' alt='waiting'>").appendTo('div.response');
      },
      success: function() {
        $('#wait').remove();
        $('<h2></h2>').html('Success!').appendTo('div.response');
        $("form#tweetas :input").attr("disabled", false);
      },
      error: function() {
        $('#wait').remove();
        $('<h2></h2>').html('Failure!').appendTo('div.response');
        $("form#tweetas :input").attr("disabled", false);
      }
    });
  });

});

