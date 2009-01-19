module UserPrivatMessagesExtension
  def self.included(base)

    base.class_eval do

				has_many :private_messages_sent, :foreign_key => 'sender_id',
        :class_name => 'PrivateMessage', :order => ::PrivateMessage.default_order
        has_many :private_messages_received, :foreign_key => 'recipient_id',
        :class_name => 'PrivateMessage', :order => ::PrivateMessage.default_order
    end

    base.extend(ClassMethods)
  end

  module ClassMethods
    def private_messages(options = {})
      ::PrivateMessage.find_associated_with(self, options)
    end

    def private_messages_count
      ::PrivateMessage.count_associated_with(self)
    end

    def private_messages_with_user(user, options = {})
      ::PrivateMessage.find_between(self, user, options)
    end

    def private_messages_with_user_count(user)
      ::PrivateMessage.count_between(self, user)
    end
  end

  
#  def self.included(base)
#    base.has_many :private_messages_sent, :foreign_key => 'sender_id',
#        :class_name => 'PrivateMessage', :order => ::PrivateMessage.default_order
#    base.has_many :private_messages_received, :foreign_key => 'recipient_id',
#        :class_name => 'PrivateMessage', :order => ::PrivateMessage.default_order
#  end
#
#  def private_messages(options = {})
#    ::PrivateMessage.find_associated_with(self, options)
#  end
#
#  def private_messages_count
#    ::PrivateMessage.count_associated_with(self)
#  end
#
#  def private_messages_with_user(user, options = {})
#    ::PrivateMessage.find_between(self, user, options)
#  end
#
#  def private_messages_with_user_count(user)
#    ::PrivateMessage.count_between(self, user)
#  end
end