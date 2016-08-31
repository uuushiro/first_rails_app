module UsersHelper
#プロフィール画像登録してなければデフォルト画像を表示
  def image_for(user)
    if user.image
      image_tag "/user_images/#{user.image}", class: "profile_img"
    else
      image_tag "default.png", class: "profile_img"
    end
  end

end
