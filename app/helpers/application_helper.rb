# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper

  def link_to_ajax_delete(path,obj)
    link_to(image_tag("/images/delete_ico.gif"),path, :rel=>obj.class.to_s.underscore+"_"+obj.id.to_s, :class => "ajax_delete")
  end
  def admin?
    current_user.admin? if current_user
  end

  def moderator?
    current_user.moderator? if current_user
  end

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
          result<<"<ul  class='sf-menu sf-vertical'>"
          items.each do |root|
            result += root.children.map do |i|
              if mover.nil? || mover.new_record? || mover.move_possible?(i)
               yield(i)
              end
            end.compact
          end
          result<<"</ul>"
          result
   end

  def search_in(model)
    render :partial => "shared/search_in", :locals => { :model => model }
  end
end
