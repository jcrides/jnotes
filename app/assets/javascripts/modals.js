$(function(){
  $('.tagz')
    .mouseenter(function () {
      var tagBtn = this.lastElementChild.lastElementChild;
      $(tagBtn).removeClass("hidden").addClass("show");
    })
    .mouseleave(function () {
      var tagBtn = this.lastElementChild.lastElementChild;
      $(tagBtn).removeClass("show").addClass("hidden");
    });

  $('.modal').on('shown.bs.modal', function () {
    lastfocus = $(this);
    $(this).find("input:text:visible:first").focus();
  });
});
