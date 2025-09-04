class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :latest]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def latest
    @microposts = Micropost.latest(current_user)
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  def fix
    micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url, alert: "Micropost not found" unless micropost
    #他の固定を解除
    current_user.microposts.where.not(id: micropost.id).where(pinned_by_id: current_user.id).update_all(pinned_by_id: nil)
    #新たに固定
    micropost.update(pinned_by_id: current_user.id)
    redirect_to request.referrer || root_url, notice: "Micropost fixed"
  end

  def unfix
    micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url, alert: "Micropost not found" unless micropost

    micropost.update(pinned_by_id: nil)

    redirect_to request.referrer || root_url, notice: "Micropost removed "
end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @micropost.nil?
    end
end
