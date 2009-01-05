#ActsAsFerret::define_index('shared',
# :models => {
#   User  => {:fields => [:first_name, :last_name, :login]},
#   DealingCenter => {:fields => [:name, :description]},
#   Article    => {:fields => [:name, :content, :cached_tag_list]},
#   Addition  => {:fields => [:content]},
#   Comment => {:fields => [:content]},
# },
# :ferret   => {
#   :default_fields => [:first_name, :last_name, :name, :description, :content]
# }
#)
#
#ActsAsFerret::define_index('shared_article',
# :models => {
#   Article    => {:fields => [:name, :content, :cached_tag_list]},
#   Addition  => {:fields => [:content]},
#   Comment => {:fields => [:content]},
# },
# :ferret   => {
#   :default_fields => [:name, :description, :content, :cached_tag_list]
# }
#)

ActsAsFerret::define_index('shared',
 :models => {
   User  => {:fields => {:first_name=>{}, :last_name=>{}, :login=>{}}},
   DealingCenter => {:fields => {:name=>{}, :description=>{}}},
   Article    => {:fields => {:name=>{}, :content=>{}, :cached_tag_list=>{}}},
   Addition  => {:fields => {:content=>{}}},
   Comment => {:fields => {:content=>{}}},
 },
 :ferret   => {
   :default_field => %w(first_name last_name name description content)
 }
)

ActsAsFerret::define_index('shared_article',
 :models => {
   Article    => {:fields => {:name=>{}, :content=>{}, :cached_tag_list=>{}}},
   Addition  => {:fields => {:content=>{}}},
   Comment => {:fields => {:content=>{}}},
 },
 :ferret   => {
   :default_field => %w(name description content cached_tag_list)
 }
)