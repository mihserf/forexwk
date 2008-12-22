$.postJSON = function(url, data, callback) {
	$.post(url, data, callback, "json");
};

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
            rate_box = $(this).parent();
            rating_avg = $(this).parent().parent().find(".rating_avg");
            rating_total = $(this).parent().parent().find(".rating_total");
            url = '/'+this.href.replace(/http:\/\/.+?\//,'')+ "&authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
            $.postJSON(url,{},
                function(data){
                    rate_box.fadeOut("slow",function(){rate_box.html(data.msg); rate_box.fadeIn("slow")})
                    if (data.rating_avg!=null){
                        rating_avg.fadeOut("slow",function(){rating_avg.html(data.rating_avg); rating_avg.fadeIn("slow")})
                    }
                    if (data.rating_total!=null){
                        rating_total.fadeOut("slow",function(){rating_total.html(data.rating_total); rating_total.fadeIn("slow")})
                    }

                });
            return false;
         });
   

   $("a.ajax_edit").click( function(e){
        e.preventDefault();
        from = $("."+$(this).attr("rel"));
        editable_source = from.html(); 
        form_action=$(this).attr("href");
        $("#new_addition").attr("action",form_action);
        $("#new_addition").append("<input name='_method' value='put' type='hidden'/>");
        $("#textarea").val(editable_source);
   });

   $(".add_comment").click( function(e){
        e.preventDefault();
        form_action=$(this).attr("rel");
        $(this).parent().parent().append("<div class='comment_form'><form action="+form_action+" method='post'><input type='hidden' name='authenticity_token' value='"+AUTH_TOKEN+"'/><textarea rows='2' cols='2' class='comment_textarea' name='comment[content]'></textarea><br><input type='image' src='/images/submit.gif'/></form></div>");
   });

   $("a.show_comments_link").click(  function(e) {
            e.preventDefault();
            url = '/'+this.href.replace(/http:\/\/.+?\//,'');
            link=$(this);
            $.getJSON(url,{},
                function(data){
                    comments="";
                    $.each(data,function(i,item){
                        comments+="<div class='comment comment_"+item.comment.id+"' style='margin-top:5px; '><div class='comm_title'>";
                        comments+="<div class='user_name'><a href='/users/"+item.comment.user.id+"'>"+item.comment.user.first_name+" "+item.comment.user.last_name+"</a></div>";
                        comments+="<div class='user_time'>"+item.comment.created_at+"<span>07:47</span></div>";
                        comments+="</div><div class='mfooter'></div>";
                        comments+="<p>"+item.comment.content+"</p>";
                        if (MODERATOR==true) { comments+="<a href='/comments/"+item.comment.id+"' rel='comment_"+item.comment.id+"' class='ajax_delete'><img src='/images/delete_ico.gif'/></a>"; }
                        comments+="</div>";
                        
                    });
                    addition=link.parents("div[class^='addition']");
                    addition.find(".comments").html(comments);
                    addition.find(".show_comments").toggle("slow");
                    addition.find(".hide_comments").toggle("slow");
                    ajax_delete();
                });
            
         });
         
   $("a.hide_comments_link").click(  function(e) {
            e.preventDefault();
            addition=link.parents("div[class^='addition']");
            addition.find(".comments").html("");
            addition.find(".show_comments").toggle("slow");
            addition.find(".hide_comments").toggle("slow");
         });

   $("a.check_unique").click(  function(e) {
            e.preventDefault();
            url = '/'+this.href.replace(/http:\/\/.+?\//,'');
            link=$(this);
            value=$("#"+link.attr("rel")).val();
            $.get(url,{value:value},
                function(data){
                    $("."+link.attr("rel")).html(data);
                });
         });

 ajax_delete();
});

function ajax_delete(){
   $("a.ajax_delete").click( function(e){
        e.preventDefault();
        if (typeof(AUTH_TOKEN) == "undefined") return;
        target = $("."+$(this).attr("rel"));
        url = '/'+this.href.replace(/http:\/\/.+?\//,'');
        $.post(url,{authenticity_token:AUTH_TOKEN,_method:"delete"}, function(data){
            target.fadeOut("slow", function(){target.html(data); target.fadeIn("slow", function(){target.fadeOut(3000, function(){target.remove()})})});
        });
   });

}