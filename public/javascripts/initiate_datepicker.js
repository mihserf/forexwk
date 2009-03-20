$(document).ready(function(){
  // ---- Календарь -----
  
  $('.dateRange').datepicker({dateFormat: 'yy-mm-dd'}, $.datepicker.regional['ru']);
  //$.datepicker.setDefaults($.datepicker.regional['']);
  $('#order_date_end').datepicker($.extend({showStatus: true}, $.datepicker.regional['ru'])); 
  $('#order_date_begin').datepicker($.extend({showStatus: true}, $.datepicker.regional['ru']));
   
  // ---- Календарь -----
});