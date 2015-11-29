(function() {
  $(document).on('ready page:load', function() {
    var color, ind, navbar;
    navbar = document.getElementsByClassName("navbar navbar-inverse");
    color = ["#4CAF50", "#03A9F4", "#f34d4d", "#27fdf5", "#f765b8", "#e1008a", "#ffab7f", "#35c390"];
    ind = Math.floor(Math.random() * color.length);
    navbar[0].style['background-color'] = color[ind];
    $('code').each(function(i, block) {
      hljs.highlightBlock(block);
    });
  });

}).call(this);
