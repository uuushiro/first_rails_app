module UsersHelper

  def image_for(user)
    if user.image
      image_tag "/user_images/#{user.image}", class: "profile_img"
    else
      image_tag "default.png", class: "profile_img"
    end
  end

end
