$(function() {

  var $myTweet = $('form#tweet');

  var beforeAppend = function() {
    $('div.response').empty();
    $("input[type=submit]").attr("disabled", true);
    $("<h2 class='wait'>Tweet flying...</h2>").appendTo('div.response');
  }

  var successAppend = function() {
    $('.wait').remove();
    $('<h2>Tweet landed!</h2>').appendTo('div.response');
    $("input[type=submit]").attr("disabled", false);
  }

   var workingAppend = function() {
    $('.wait').remove();
    $('<h2 class="wait">Tweet struggling...</h2>').appendTo('div.response');
    $("input[type=submit]").attr("disabled", false);
  }

  var errorAppend = function () {
    $('.wait').remove();
    $('<h2>Tweet died!</h2>').appendTo('div.response');
    $("input[type=submit]").attr("disabled", false);
  }

  $myTweet.on('submit', function(e) {
    e.preventDefault();
    var tweetData = $myTweet.serialize();
    $.ajax({
      url: '/new/tweet',
      type: 'post',
      data: tweetData,
      beforeSend: function() { beforeAppend(); },
      success: function(jsobJobId) {
        var jobId = jsobJobId.job;
        var goAgain = 0;

        var checkSidekiq = function () {
          $.ajax({
            url: '/status/' + jobId,
            type: 'get',
            success: function(jobComplete) {
              console.log(jobComplete);
              if (jobComplete.finished === true) {
                clearTimeout(goAgain);
                successAppend();
                $('textarea').val('');
              }
              else {
                workingAppend();
                goAgain = setTimeout(checkSidekiq, 10);
              }
            }
          });
        };
        checkSidekiq();
      },
      error: function() { errorAppend(); }
    });

  });

});

// $.ajax(
//   url: '/status/' + job_id????,
//   type: 'GET',
//   data: ???? return of job_is_complete,
//   setTimeout(function to check job_is_complete, time),
//   success: 
//   );
