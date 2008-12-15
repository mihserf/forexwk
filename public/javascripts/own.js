
$(document).ready(function(){
  /* $.getJSON("/differences",{accommodation_type_id:accommodation_type_id},get_differences);
      function get_differences(differences) {
            differences_options="";
            $.each(differences,function(i,val){
                differences_options+="<option value="+val.id+">"+val.name+"</option>";
                })
            $(".differences_selection").html(differences_options);
            set_price();
          }
    */
  $("a.rjs").click(  function() {
            $.ajax({
                //type: "POST",
                //url: this.getAttribute("href"),
                url: '/'+this.href.replace(/http:\/\/.+?\//,''),
                //url: this.href,
                dataType: "script",
                beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");}
            });

            return false;
         });
   $("a.rate").click(  function() {
            if (typeof(AUTH_TOKEN) == "undefined") return;
            $.ajax({
                type: "POST",
                //url: this.getAttribute("href"),
                url: '/'+this.href.replace(/http:\/\/.+?\//,'')+ "&authenticity_token=" + encodeURIComponent(AUTH_TOKEN),
                //url: this.href,
                dataType: "script",
                success: function(msg){ alert(msg);},
                beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");}
            });

            return false;
         });
            
});