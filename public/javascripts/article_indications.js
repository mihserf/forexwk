
$(document).ready(function(){
   $(".indications_numbers :checkbox").change(function(){
       if (typeof(AUTH_TOKEN) == "undefined") return;
       
       indication_id = $(this).attr('name');
       article_id = $(this).attr('value');

       if ($(this).is(':checked')) {
           method = "post";
           url = '/admin/article_indications';
       }
       else{
           method = "delete";
           url = '/admin/article_indications/0';
       }

       //url = '/'+this.href.replace(/http:\/\/.+?\//,'');
        
        own_preloader(true);
        $.post(url,{authenticity_token:AUTH_TOKEN, _method:method, indication_id:indication_id, article_id:article_id}, function(data){
            own_preloader(false);
        });
   });
});