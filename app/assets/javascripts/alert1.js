var $j = jQuery.noConflict();
$j(document).ready(function() {
  $j('.popup-wrap').fadeIn(500);
  $j('.popup-box').removeClass('transform-out').addClass('transform-in');
});

function showPopupBox() {
  var $j = jQuery.noConflict();
  $j('.popup-wrap').fadeIn(500);
  $j('.popup-box').removeClass('transform-out').addClass('transform-in');
  $j('.popup-close').click(function(e) {
    $j('.popup-wrap').fadeOut(500);
    $j('.popup-box').removeClass('transform-in').addClass('transform-out');
    e.preventDefault();
  });
}


showPopupBox();




