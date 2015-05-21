
// var container = document.querySelector("#main-container");

// var msonry = new Masonry(container, {
//   columnWidth: 200,
//   itemSelector: '.gallery-item'
// });


$(document).on('page:change', function(){
  var $container = $('#main-container');
  // initialize
  $container.imagesLoaded(function(){
    $container.masonry({
      columnWidth: 25,
      itemSelector: '.gallery-item'
    });
  });
});
