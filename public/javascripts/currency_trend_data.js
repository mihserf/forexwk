
$(document).ready(function(){
   
   $("#ajax_currency_pair").change(function(){
        //currency_pair = $("#ajax_currency_pair option:selected").text();
        currency_pair=$(this).val();
        $("#currency_pair_archive").attr("href","/currency_pairs/"+currency_pair+"/archive");
        own_preloader(true);
        url=  "/currency_pairs/"+currency_pair+"/trend_datas/"+$(this).attr("trend_data_id");
        $.get(url,{}, function(data){
          trends=data;
          $("#ajax_trends").html(trends);
          own_preloader(false);
          //make_ajax_trens_tooltip();
        });
        
  });

  $("#ajax_currency_pair").trigger("change");

});