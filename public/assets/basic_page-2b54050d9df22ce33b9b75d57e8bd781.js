(function() {
  $(document).on('ready page:load', function() {
    $('pre code').each(function(i, block) {
      hljs.highlightBlock(block);
    });
  });

}).call(this);
