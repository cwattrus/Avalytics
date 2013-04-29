$(function(){
  $(".btn-flip").click(function(){
    $(this).closest('.flip-container').toggleClass('flipped');
  });
});