# ActsAsRateable
module Juixe
  module Acts #:nodoc:
    module Rateable #:nodoc:

      def self.included(base)
        base.extend ClassMethods  
      end

      module ClassMethods
        def acts_as_rateable
          has_many :ratings, :as => :rateable, :dependent => :destroy
          has_one  :stat_rating, :as => :stat_rateable, :dependent => :destroy
          include Juixe::Acts::Rateable::InstanceMethods
          extend Juixe::Acts::Rateable::SingletonMethods
        end
      end
      
      # This module contains class methods
      module SingletonMethods
        # Helper method to lookup for ratings for a given object.
        # This method is equivalent to obj.ratings
        def find_ratings_for(obj)
          rateable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
         
          Rating.find(:all,
            :conditions => ["rateable_id = ? and rateable_type = ?", obj.id, rateable],
            :order => "created_at DESC"
          )
        end
        
        # Helper class method to lookup ratings for
        # the mixin rateable type written by a given user.  
        # This method is NOT equivalent to Rating.find_ratings_for_user
        def find_ratings_by_user(user) 
          rateable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
          
          Rating.find(:all,
            :conditions => ["user_id = ? and rateable_type = ?", user.id, rateable],
            :order => "created_at DESC"
          )
        end
        
        # Helper class method to lookup rateable instances
        # with a given rating.
        def find_by_rating(rating)
          rateable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
          ratings = Rating.find(:all,
            :conditions => ["rating = ? and rateable_type = ?", rating, rateable],
            :order => "created_at DESC"
          )
          rateables = []
          ratings.each { |r|
            rateables << r.rateable
          }
          rateables.uniq!
        end
      end
      
      # This module contains instance methods
      module InstanceMethods
        # Helper method that defaults the current time to the submitted field.
        def add_rating(rating_val, current_user,reason=nil)
          rate_section = 5
          if rating_val.abs > rate_section
            ((rating_val.abs/rate_section)>1 ? rating_val.abs/rate_section : 1).times do
              Rating.create(:user_id => current_user.id, :reason => reason, :rating => (rating_val>0 ? rate_section : (rate_section-rate_section*2)), :rateable_type => self.class.to_s, :rateable_id => self.id)
            end
          else
              Rating.create(:user_id => current_user.id, :reason => reason, :rating => rating_val, :rateable_type => self.class.to_s, :rateable_id => self.id)
          end
          build_stat_rating(:stat_rateable_type => self.class, :stat_rateable_id => self.id) if stat_rating.nil?
          stat_rating.rating_total = rating_total
          stat_rating.rating_avg = rating
          stat_rating.save
          #ratings << rating
        end
        
        # Helper method that returns ratings colletction in the given date interval
        def ratings_in_dates(start_date=nil,end_date=nil)
          ratings.find(:all, :conditions => ["created_at >= :start_date AND created_at <= :end_date",{:start_date => start_date, :end_date => end_date}]) unless (start_date==nil || end_date==nil)
        end

        # Helper method that returns the average rating
        # 
        def rating
          average = 0.0
          average = rating_total/rating_amount unless rating_amount==0
          average
        end

        # Helper method that returns total rating
        #
        def rating_total
          Rating.sum(:rating,:conditions => "rateable_id=#{self.id} AND rateable_type='#{self.class}'")
        end

        # Helper method that returns rating amount
        #
        def rating_amount
          Rating.count(:conditions => "rateable_id=#{self.id} AND rateable_type='#{self.class}'")
        end

        # Check to see if a user already rated this rateable
        def rated_by_user?(user)
          if user
            !self.ratings.find(:all,:select => "user_id",:conditions => {:user_id=>user.id}).empty?
          end
        end
        
      end
    end
  end
end
