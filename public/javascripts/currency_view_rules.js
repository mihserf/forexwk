
$(document).ready(function(){
   $(".currency_view_rules_numbers :checkbox").change(function(){
       if (typeof(AUTH_TOKEN) == "undefined") return;
       
       currency_view_rule_id = $(this).attr('name');
       currency_pair_id = $(this).attr('value');

       if ($(this).is(':checked')) {
           method = "post";
           url = '/admin/currency_pair_currency_view_rules';
       }
       else{
           method = "delete";
           url = '/admin/currency_pair_currency_view_rules/0';
       }

       //url = '/'+this.href.replace(/http:\/\/.+?\//,'');
        
        own_preloader(true);
        $.post(url,{authenticity_token:AUTH_TOKEN, _method:method, currency_view_rule_id:currency_view_rule_id, currency_pair_id:currency_pair_id}, function(data){
            own_preloader(false);
        });
   });
});