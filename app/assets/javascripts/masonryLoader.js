$(document).on('page:change', function(){
  console.log("the page has loaded");
});


$(document).on('page:update', function(){
  var $container = $('#main-container');
  // initialize
  $container.imagesLoaded(function(){
    $container.masonry({
      columnWidth: 25,
      itemSelector: '.gallery-item'
    });
  });
})
