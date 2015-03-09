(function() {
  $(document).on('ready page:load', function() {
    $('code').each(function(i, block) {
      hljs.highlightBlock(block);
    });
  });

}).call(this);
