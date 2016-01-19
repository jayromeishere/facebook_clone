class Comment < ActiveRecord::Base
  # add validations 
  
  has_many :passive_notifications,
    as: :source, 
    class_name: "Notifications"
    
end
