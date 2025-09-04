class FavoritesController < ApplicationController
    def create
    favorite = current_user.favorites.build(micropost_id: params[:micropost_id])
    favorite.save
    redirect_to root_path
  end
  def destroy
    favorite = Favorite.find_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    favorite.destroy
    redirect_to root_path
  end
end
