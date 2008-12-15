$(document).ready(function(){
  // --------------- SORTABLE -------------------
  $("#sortable").sortable({
	hoverClass: "dragStyle",
	start: function(ev, ui) {

	},
	stop: function(ev, ui) {
          sorted_array = $("#sortable").sortable('toArray');
          $('#sortable_ids').val(sorted_array);
	}
  });
  // --------------- SORTABLE -------------------
});