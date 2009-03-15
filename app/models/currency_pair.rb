class CurrencyPair < ActiveRecord::Base
  has_many :currency_datas, :dependent => :destroy
  has_many :currency_pair_currency_view_rules, :dependent => :destroy
  has_many :currency_view_rules, :through => :currency_pair_currency_view_rules, :order => :number

  attr_accessor :denied
  attr_accessor :color
  attr_accessor :view_rule_number

  def name=(name)
    self[:name] = name.upcase
  end

  def title
    self[:name].include?("/") ? self[:name] : self[:name].insert(3,"/")
  end

  def self.all_for_user(current_user)
    currency_pairs = nil
    CurrencyViewRule.all(:order => :number).each do |rule|
      currency_pairs = self.all(:include => [:currency_view_rules], :conditions => ["currency_view_rules.id=?",rule.id]) if eval(rule.rule)
    end
    return currency_pairs
  end

end
