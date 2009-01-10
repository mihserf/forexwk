class ThermsController < ApplicationController
  def index
    per_page = 5
    
    alphabet=%w(А Б В Г Д Е Ё Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Э Ю Я A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
      l,k,p,pk="",0,1,per_page;
      letter_p=nil;
      uniq_therms_letters = []
      Therm.find(:all, :select => "name", :order => "ru DESC,name").each{|i| unless (l==i.name.first) then letter_p=p end; if (pk==k) then p+=1; pk+=per_page end; k+=1; nil; unless (l==i) then uniq_therms_letters << {:p=>letter_p,:l=>i.name.first} end; l=i.name.first;  }
      links = []
      links = alphabet.collect do |l|
        r="<span>#{l}</span>"
        uniq_therms_letters.each do |tl|
          tl[:l]=tl[:l].mb_chars.upcase.to_s
          current_page = (params[:page].nil? || tl[:p]==params[:page]) ? "" : "?page=#{params[:page]}"
          r = " <a href='/therms?page=#{tl[:p]}##{l}'>#{l}</a> " if l==tl[:l]
        end
        r
      end

    @ru_links = links[0..29]
    @en_links = (links-@ru_links)
    @ru_links=@ru_links.join(" ")
    @en_links=@en_links.join(" ")
    
    @therms=Therm.paginate(:page => params[:page], :per_page => per_page, :order => "ru DESC,name")
  end

  def show
    @therm = Therm.find_by_name(params[:id])
  end
end
