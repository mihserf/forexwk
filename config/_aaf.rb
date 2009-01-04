ActsAsFerret::define_index('shared',
 :models => {
   User  => {:fields => [:first_name, :last_name, :login]},
   DealingCenter => {:fields => [:name, :description]},
   Article    => {:fields => [:name, :content, :cached_tag_list]},
   Addition  => {:fields => [:content]},
   Comment => {:fields => [:content]},
 },
 :ferret   => {
   :default_fields => [:first_name, :last_name, :name, :description, :name, :content]
 }
)