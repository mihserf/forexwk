$(document).ready(function(){
	$(".toggle_div").hide();
	$(".toggle_link").click(function(){$(this).parent().next(".toggle_div").toggle("fast"); if ($(this).text()=="Читать полностью") {$(this).text("скрыть");} else if($(this).text()=="скрыть")  {$(this).text("Читать полностью")}  return false});
});