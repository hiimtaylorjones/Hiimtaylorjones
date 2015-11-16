(function() {
  $(document).on('ready page:load', function() {
    var color, ind, navbar;
    navbar = document.getElementsByClassName("navbar navbar-inverse");
    color = ["black", "#607D8B", "#4CAF50", "#03A9F4", "#9C27B0"];
    ind = Math.floor(Math.random() * color.length);
    navbar[0].style['background-color'] = color[ind];
    $('pre code').each(function(i, block) {
      hljs.highlightBlock(block);
    });
  });

}).call(this);
