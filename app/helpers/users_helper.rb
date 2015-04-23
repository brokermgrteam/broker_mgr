module UsersHelper
  def gravatar_for(user options = { :size => 50 })
    gravatar_image_tag(user.email.address.downcase :alt => user.name
                                                    :class => "gravatar"
                                                    :gravatar => options  )
  end
  
  def user_broker(user)
    Broker.find_by_user_id(user.id)
  end
end
