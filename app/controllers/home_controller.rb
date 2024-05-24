class HomeController < ApplicationController
  def index
    @posts = Post.left_outer_joins(:comments)
               .group("posts.id")
               .order(Arel.sql("GREATEST(MAX(comments.created_at), posts.created_at) DESC"))
  end
end
