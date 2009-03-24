require 'csv'
require 'iconv'

class TrendData < ActiveRecord::Base
  has_attached_file :excel_data,
                    #:url => "/attachments/:class/:id/:basename.:extension",
                    :path => ":rails_root/excel_data/:id/:basename.:extension"
  has_many :currency_datas, :dependent => :destroy

  after_save :process_data

  attr_accessor :creating

  def process_data
    if self.creating

      begin
      contents = File.open(self.excel_data.path).read
      output = Iconv.conv('utf-8', 'cp1251', contents)
      file = File.open(self.excel_data.path, 'w')
      file.write(output)
      rescue Iconv::IllegalSequence
         puts "Could not be processed: #{filename}"
      ensure
        if defined? file
          if file
            file.close
            file = nil
          end
        end
      end

      i = 0
      CSV.open(self.excel_data.path,'r',";") do |row|
        i+=1
        next if i==1 # пропускаем заголовки
        currency_pair,currency_price,month_trend,month_trend_stage,month_trend_prob_cont,week_trend,week_trend_stage,week_trend_prob_cont,day_trend,day_trend_stage,day_trend_prob_cont = row

        currency_pair = CurrencyPair.find_or_create_by_name(currency_pair)

        currency_data = CurrencyData.create(:trend_data_id => self.id, :currency_pair => currency_pair, :currency_price => (currency_price.sub(/,/,".").to_f unless currency_price.nil?))

        Trend.create(:currency_data => currency_data, :trend_type => Trend::MONTH_T, :character => Trend::CHARACTERS.invert[month_trend], :stage => Trend::STAGES.invert[month_trend_stage], :prob_cont => (month_trend_prob_cont.sub(/,/,".").to_f unless month_trend_prob_cont.nil?) )
        Trend.create(:currency_data => currency_data, :trend_type => Trend::WEEK_T, :character => Trend::CHARACTERS.invert[week_trend], :stage => Trend::STAGES.invert[week_trend_stage], :prob_cont => (week_trend_prob_cont.sub(/,/,".").to_f unless week_trend_prob_cont.nil?) )
        Trend.create(:currency_data => currency_data, :trend_type => Trend::DAY_T, :character => Trend::CHARACTERS.invert[day_trend], :stage => Trend::STAGES.invert[day_trend_stage], :prob_cont => (day_trend_prob_cont.sub(/,/,".").to_f unless day_trend_prob_cont.nil?) )
      end
    end
  end

end
