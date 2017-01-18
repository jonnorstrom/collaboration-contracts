$(document).on('turbolinks:load', function() {
  var sPath = window.location.pathname;
  var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

  if(sPage == "dashboard") {
    setUpMasonryGrid()
  };

});


function setUpMasonryGrid(){
  window.addEventListener("resize", columnWidthFinder);

  columnWidthFinder();
  $('.dashboard-grid').masonry({
    itemSelector: '.grid-item',
    fitWidth: true,
    transitionDuration: '0.5s',
    columnWidth: columnWidthFinder(),
    gutter: 0
  });

  function columnWidthFinder(){
    var width = document.getElementById('userDashboardContainer').offsetWidth;
    var width = width <= 738 ? (width / 1.1 ) : (353);
    $('.grid-item').css({"width": width});
    $('.dashboard-grid').masonry({
      columnWidth: width
    });
  };
}
