require 'httparty'

module UsersHelper
  def avatar_for(user, size: 80)
    url = "https://api.dicebear.com/8.x/identicon/svg?seed=#{user.username}&radius=30&size=#{size}"
    response = HTTParty.get(url).body
    # image_tag(response, alt: user.username, class: "avatar", width: size, height: size)
    response.html_safe
  end
end
