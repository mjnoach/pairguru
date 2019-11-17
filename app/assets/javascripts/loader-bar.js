$(document).ready(function() {

  $(".loader-bar").hide();

  $(document).ajaxStart(
    () => $(".loader-bar").show());

  $(document).ajaxStop(
    () => $(".loader-bar").hide());
});