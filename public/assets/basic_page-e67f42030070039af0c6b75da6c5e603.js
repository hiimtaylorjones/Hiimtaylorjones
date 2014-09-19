(function() {
  $(document).ready(function() {
    $('#login-window').dialog({
      autoOpen: false,
      fluid: true,
      modal: true,
      maxWidth: '450',
      maxheight: '500',
      draggable: true,
      title: 'Sign In'
    });
    $('#signup-window').dialog({
      autoOpen: false,
      title: 'Sign Up'
    });
    $('#login-nav').click(function() {
      $('#login-window').dialog('open');
      return false;
    });
    $('#signup-nav').click(function() {
      return $('#signup-window').dialog('open');
    });
  });

}).call(this);
