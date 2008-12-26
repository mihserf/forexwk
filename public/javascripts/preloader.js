

    function own_preloader(event){

        if (event==true) {
            if (!($("#own_preloader").attr("id"))){
                preloader='<div id="own_preloader" style="z-index:1000; width:32px; height:32px;"><img src="/images/loading.gif"/></div>';
                $("body").append(preloader);
            }
            preloader = $("#own_preloader");
            preloader.show();
            
            changeCss();
            $(window).bind("resize", function(){
                changeCss();
            });
            $(window).bind("scroll", function(){
                changeCss();
            });
        }
        else{
            $(window).unbind("resize");
            $(window).unbind("scroll");
            preloader.hide();
        }
        
        function changeCss(){
            var imageHeight = preloader.height(); 
            var imageWidth = preloader.width();
            var windowWidth = $(window).width();
            var windowHeight = $(window).height();
            preloader.css({
                "position" : "absolute",
                "left" : windowWidth / 2 - imageWidth / 2,
                "top" : getPageScroll()[1] + (getPageHeight() / 2)
            });
        };


        // getPageScroll() by quirksmode.com
  function getPageScroll() {
    var xScroll, yScroll;
    if (self.pageYOffset) {
      yScroll = self.pageYOffset;
      xScroll = self.pageXOffset;
    } else if (document.documentElement && document.documentElement.scrollTop) {	 // Explorer 6 Strict
      yScroll = document.documentElement.scrollTop;
      xScroll = document.documentElement.scrollLeft;
    } else if (document.body) {// all other Explorers
      yScroll = document.body.scrollTop;
      xScroll = document.body.scrollLeft;
    }
    return new Array(xScroll,yScroll)
  }

  // Adapted from getPageSize() by quirksmode.com
  function getPageHeight() {
    var windowHeight
    if (self.innerHeight) {	// all except Explorer
      windowHeight = self.innerHeight;
    } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
      windowHeight = document.documentElement.clientHeight;
    } else if (document.body) { // other Explorers
      windowHeight = document.body.clientHeight;
    }
    return windowHeight
  }
 }
 


