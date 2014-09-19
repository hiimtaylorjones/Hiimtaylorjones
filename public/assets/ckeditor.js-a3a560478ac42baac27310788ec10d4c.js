(function() {
  $(document).ready(function() {
    var data;
    if ($("textarea").length > 0) {
      data = $("textarea");
      $.each(data, function(i) {
        CKEDITOR.replace(data[i].id);
      });
    }
  });

}).call(this);
