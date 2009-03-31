# Methods added to this helper will be available to all templates in the application.
require 'md5'
module ApplicationHelper
  include TagsHelper

  def link_to_ajax_delete(path,obj)
    link_to(image_tag("/images/delete_ico.gif"),path, :rel=>obj.class.to_s.underscore+"_"+obj.id.to_s, :class => "ajax_delete")
  end
  #def admin?
  #  current_user.admin? if current_user
  #end

  #def moderator?
  #  current_user.moderator? if current_user
  #end

  def items_set(class_or_item, mover = nil)
          class_or_item = class_or_item.roots if class_or_item.is_a?(Class)
          items = Array(class_or_item)
          result = []
          items.each do |root|
            result += root.self_and_descendants.map do |i|
              if mover.nil? || mover.new_record? || mover.move_possible?(i)
               yield(i)
              end
            end.compact
          end
          result
   end

  def sub_items_menu(class_or_item, mover = nil)
          class_or_item = class_or_item.roots if class_or_item.is_a?(Class)
          items = Array(class_or_item)
          result = []
          result<< "<ul  class='sf-menu sf-vertical'>"
          items.each do |root|
            result += root.children.map do |i|
              if mover.nil? || mover.new_record? || mover.move_possible?(i)
               yield(i)
              end
            end.compact
          end
          result<< "</ul>"
          result
   end

  def search_in(model)
    case model.class_name
    when "Article"
      example_value = "поиск по статьям и дополнениям"
    when "DealingCenter"
      example_value = "поиск по диллинговым центрам"
    when "Therm"
      example_value = "поиск по терминам"
    when "Video"
      example_value = "поиск по видео"
    when "Addition"
      example_value = "поиск по дополнениям"
    when "Book"
      example_value = "поиск по книгам"
    when "Event"
      example_value = "поиск по новостям"
    else
      example_value = "поиск по разделу"
    end

    render :partial => "shared/search_in", :locals => { :model => model, :example_value => example_value }
  end

  def random_video
    videos_ids = Video.all(:select=>"id").map{|i| i.id}
    video = Video.find(:first, :conditions=>["id = ?",videos_ids[rand(videos_ids.size)]])
    render :partial => "videos/random_video", :locals => { :video => video }
  end

  def meta(obj=nil)
    render :partial => "shared/meta", :locals=> {:obj => obj}
  end


  def currency_pairs_select(*args)
    options = args.extract_options!
    
    all_currency_pairs = CurrencyPair.all_with_rules_for_user(current_user).sort_by {|i| [i.denied_for_sort, i.view_rule_number, i.name]}

    trend_data = TrendData.last

    render  :partial => 'shared/currency_pairs_select', :locals => {:all_currency_pairs => all_currency_pairs, :trend_data => trend_data, :multiple => options[:multiple], :id => options[:id], :name => options[:name], :size => options[:size], :class_name => options[:class]}
  end

 #FORUM helpers
  def head_extras
  end
	
  def submit_tag(value = "Save Changes"[], options={} )
    or_option = options.delete(:or)
    return super + "<span class='button_or'>"+"or"[]+" " + or_option + "</span>" if or_option
    super
  end

  def ajax_spinner_for(id, spinner="spinner.gif")
    "<img src='/plugin_assets/aep_beast/images/#{spinner}' style='display:none; vertical-align:middle;' id='#{id.to_s}_spinner'> "
  end

  def avatar_for(user, size=32)
    #image_tag "http://www.gravatar.com/avatar.php?gravatar_id=#{MD5.md5(user.email)}&rating=PG&size=#{size}", :size => "#{size}x#{size}", :class => 'photo'
    image_tag user.avatar.url(:thumb), :class => 'photo'
  end
	
	def beast_user_name
		(current_user ? current_user.display_name : "Гость" )
	end
	
	def beast_user_link
		user_link = (current_user ? user_path(current_user) : "#")
		link_to beast_user_name, user_link
	end

  def feed_icon_tag(title, url)
    (@feed_icons ||= []) << { :url => url, :title => title }
    link_to image_tag('feed-icon.png', :size => '14x14', :style => 'margin-right:5px'), url
  end

  def search_posts_title
    returning(params[:q].blank? ? 'Recent Posts'[] : "Searching for"[] + " '#{h params[:q]}'") do |title|
      title << " "+'by {user}'[:by_user,h(User.find(params[:user_id]).display_name)] if params[:user_id]
      title << " "+'in {forum}'[:in_forum,h(Forum.find(params[:forum_id]).name)] if params[:forum_id]
    end
  end

  def topic_title_link(topic, options)
    if topic.title =~ /^\[([^\]]{1,15})\]((\s+)\w+.*)/
      "<span class='flag'>#{$1}</span>" + 
      link_to(h($2.strip), forum_topic_path(@forum, topic), options)
    else
      link_to(h(topic.title), forum_topic_path(@forum, topic), options)
    end
  end

  def search_posts_path(rss = false)
    options = params[:q].blank? ? {} : {:q => params[:q]}
    prefix = rss ? 'formatted_' : ''
    options[:format] = 'rss' if rss
    [[:user, :user_id], [:forum, :forum_id]].each do |(route_key, param_key)|
      return send("#{prefix}#{route_key}_posts_path", options.update(param_key => params[param_key])) if params[param_key]
    end
    options[:q] ? search_all_posts_path(options) : send("#{prefix}all_posts_path", options)
  end

  # on windows and this isn't working like you expect?
  # check: http://beast.caboo.se/forums/1/topics/657
  # strftime on windows doesn't seem to support %e and you'll need to 
  # use the less cool %d in the strftime line below
  def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    distance_in_minutes = (((to_time - from_time).abs)/60).round
  
    case distance_in_minutes
      when 0..1           then (distance_in_minutes==0) ? 'a few seconds ago'[] : '1 minute ago'[]
      when 2..59          then "{minutes} minutes ago"[:minutes_ago, distance_in_minutes]
      when 60..90         then "1 hour ago"[]
      when 90..1440       then "{hours} hours ago"[:hours_ago, (distance_in_minutes.to_f / 60.0).round]
      when 1440..2160     then '1 day ago'[] # 1 day to 1.5 days
      when 2160..2880     then "{days} days ago"[:days_ago, (distance_in_minutes.to_f / 1440.0).round] # 1.5 days to 2 days
      else from_time.strftime("%b %e, %Y  %l:%M%p"[:datetime_format]).gsub(/([AP]M)/) { |x| x.downcase }
    end
  end
  
  def pagination collection
    if collection.total_pages > 1
      "<p class='pages'>" + 'Страницы' + ": <strong>" +
      will_paginate(collection, :inner_window => 10, :next_label => ">"[], :prev_label => "<") +
      "</strong></p>"
    end
  end
  
  def next_page collection
    unless collection.current_page == collection.total_pages or collection.total_pages == 0
      "<p style='float:right;'>" + link_to(">"[], { :page => collection.current_page.next }.merge(params.reject{|k,v| k=="page"})) + "</p>"
    end
  end

  def for_forum()
    forum_controllers = %w(forums posts topics moderators monitorships)
    if forum_controllers.include? params[:controller]
      result=stylesheet_link_tag('display') + javascript_include_tag('forum')
    end
    result || ""
  end

end
