class CurrencyPair < ActiveRecord::Base
  has_many :currency_datas, :dependent => :destroy
  has_many :currency_pair_currency_view_rules, :dependent => :destroy
  has_many :currency_view_rules, :through => :currency_pair_currency_view_rules, :order => :number

  attr_accessor :denied
  attr_accessor :color
  attr_accessor :message
  attr_accessor :view_rule_number

  def denied_for_sort
    self.denied ? 1 : 0
  end
  def name=(name)
    self[:name] = name.upcase
  end

  def title
    [name[0..2],name[3..5]].join("/")
    #self[:name].include?("/") ? self[:name] : self[:name].insert(3,"/")
  end

  def self.all_for_user(current_user, *args)
    options = args.extract_options!
    
    currency_pairs = nil
    CurrencyViewRule.all(:order => :number).each do |rule|

      #merging external options
      def_options = {:include => [:currency_view_rules], :conditions => ["currency_view_rules.id=:rule_id",{:rule_id => rule.id}]}
      options[:include] =  options[:include] ? options[:include]+=def_options[:include] : def_options[:include]
      if options[:conditions]
        options[:conditions][0]+=" AND ("+def_options[:conditions][0]+")"
        options[:conditions][1].merge! def_options[:conditions][1]
      else
        options[:conditions] = def_options[:conditions]
      end

      #currency_pairs = self.all(:include => [:currency_view_rules], :conditions => ["currency_view_rules.id=?",rule.id]) if eval(rule.rule)
      currency_pairs = self.all(options) #if ((eval(rule.rule)) || (current_user && current_user.admin?) || (current_user && current_user.moderator))
    end
    return currency_pairs
  end

  def self.all_with_rules_for_user(current_user, *args)
    options = args.extract_options!
    user_currency_pairs = CurrencyPair.all_for_user(current_user)

    #merging external options
      def_options = {:include => [{:currency_view_rules => :currency_pair_currency_view_rules}], :order => "currency_pairs.name"}
      options[:include] =  options[:include] ? options[:include]+=def_options[:include] : def_options[:include]
      options[:order] = options[:order] ? [options[:order],def_options[:order]].join(",") : def_options[:order]

    all_currency_pairs = CurrencyPair.all(options).map do|i|
      if user_currency_pairs.include?(i)
        i.denied = false
        i.view_rule_number = 0
      else
        i.denied = true
        currency_view_rule = i.currency_view_rules.sort_by{|x| x.number}.first

        unless currency_view_rule.nil?
          i.color = currency_view_rule.color
          i.view_rule_number = currency_view_rule.number
          i.message = currency_view_rule.message
        else
          i.color = "#ccc"
          i.view_rule_number = 100
        end
      end
      i
    end

    return all_currency_pairs
  end

end
