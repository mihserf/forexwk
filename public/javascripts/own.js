$.postJSON = function(url, data, callback) {
	$.post(url, data, callback, "json");
};

$(document).ready(function(){
    $('input.example_value').each(function() {
        this.exampleValue = this.value;
    });
    $('input.example_value').focus(function() {
        if ($(this).hasClass('example_value')) {
            this.value = '';
            $(this).removeClass('example_value');
        }
    });
  $('a[rel*=facebox]').facebox();
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
            own_preloader(true);
            $.postJSON(url,{},
                function(data){
                    rate_box.fadeOut("slow",function(){rate_box.html(data.msg); rate_box.fadeIn("slow")})
                    if (data.rating_avg!=null){
                        rating_avg.fadeOut("slow",function(){rating_avg.html(data.rating_avg); rating_avg.fadeIn("slow")})
                    }
                    if (data.rating_total!=null){
                        rating_total.fadeOut("slow",function(){rating_total.html(data.rating_total); rating_total.fadeIn("slow")})
                    }
                    own_preloader(false);

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
            own_preloader(true);
            $.get(url,{},
                function(data){
                    comments=data;
                    addition=link.parents("div[class^='addition']");
                    addition.find(".comments").html(comments);
                    addition.find(".show_comments").toggle("slow");
                    addition.find(".hide_comments").toggle("slow");
                    ajax_delete();
                    own_preloader(false);
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
            own_preloader(true);
            $.get(url,{value:value},
                function(data){
                    $("."+link.attr("rel")).html(data);
                    own_preloader(false);
                });
         });

   $("a.show_field").click( function(e) {
      e.preventDefault();
      $(this).parent().next(".hidden_field").fadeIn("slow");
      $(this).parent().fadeOut("slow");
   });

   $("a.toggle_hidden").click( function(e) {
      e.preventDefault();
      $(this).parent().next(".hidden").toggle("slow");
   });

   $(".hidden").hide();
   $(".hidden_field").hide();
   
 ajax_delete();
});

function page_link(pages_number,current_page){
            $("#search_results").show();
            $(".page_link").click(function(e){
            e.preventDefault();
            list_archive($(this).attr("rel"));
            pages_number=pages_number-0;
            if (($(this).attr("rel")-0)<pages_number)
            { $("#next_page").attr("rel",$(this).html()-0+1); }
            else
            { $("#next_page").attr("rel",$(this).html()-0); }
            });

            $("#next_page").click(function(e){
            e.preventDefault();
            list_archive($(this).attr("rel"));
            });
            $("#next_page").attr("rel",current_page-0+1);
    }
function pagination(){
    $(".pagination a").click(function(e){
            e.preventDefault();
            url=$(this).attr("href");
            get_archive(false,url);
    });
  }
function get_archive(page,url){
    own_preloader(true);
    url= page!=false ? "/contests/archive?page="+page : url

    $.get(url,{}, function(data){
              archive_table=data;
              $("#archive").html(archive_table);
              own_preloader(false);
              pagination();
              make_tooltip();
              /*make_tooltip();
              links="";
              for (i=1; i<=data.pages_number; i++)
              {
                    link = i==data.current_page-0 ? i+" " : "<a href='#' class='page_link' rel="+i+">"+i+"</a> ";
                    links+=link;
              }
              $("#pages span").html(links);
              page_link(data.pages_number,data.current_page);*/
            });

    return false;
}


function ajax_delete(){
   $("a.ajax_delete").click( function(e){
        e.preventDefault();
        if (typeof(AUTH_TOKEN) == "undefined") return;
        if (confirm('подтвердите удаление')) {
            target = $("."+$(this).attr("rel"));
            url = '/'+this.href.replace(/http:\/\/.+?\//,'');
            own_preloader(true);
            $.post(url,{authenticity_token:AUTH_TOKEN,_method:"delete"}, function(data){
                target.fadeOut("slow", function(){target.html(data); target.fadeIn("slow", function(){target.fadeOut(3000, function(){target.remove()})})});
                own_preloader(false);
            });
        }
   });

}