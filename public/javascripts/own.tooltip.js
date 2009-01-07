 $(document).ready(function(){
   make_tooltip();
 });

 
function make_tooltip(){
	$('.short_info').tooltip({
		 track: true,
		 delay: 0,
		 showURL: false,
		 bodyHandler: function() {
				return $("#"+$(this).attr("rel")).html();
	 		}
	 });
}