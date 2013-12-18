class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Post successfully created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  def update
    #@micropost= Micropost.find(params[:id])

    if ratedbefore(current_user.id, params[:id])
      redirect_to root_url, :notice => "You've already rated this post...it would be fair if you could rate something twice..."
    else
      wupwup=params[:micropost]
      to_cool_array(wupwup[:rate_ids]).each do |curr_id|
        @micropost= Micropost.find_by(id: curr_id)
        if curr_id==params[:id].to_i
          if @micropost.update_column(:rating, @micropost.rating + 3)
            Viewing.create(micropost_id: curr_id, user_id: current_user.id)
          else
            redirect_to root_url, :notice => "Something went wrong...sorry...we're working on it"
          end
        else
          if @micropost.update_column(:rating, @micropost.rating - 1)
            Viewing.create(micropost_id: curr_id, user_id: current_user.id)
          else
            redirect_to root_url, :notice => "Something went wrong...sorry...we're working on it"
          end
        end
      end
      redirect_to mixer_path, :notice => "Rated Successfully"
    end
  end

  def ratedbefore(userid, postid)
    @viewing= Viewing.find_by_user_id_and_micropost_id(userid, postid)
    return @viewing.present?
  end

  def to_cool_array(arrstring)
    newstring=""
    arrstring.split("").each do |i|
      if i!="[" && i!="]"
        newstring+=i
      end
    end
    return newstring.split(",").map(&:to_i)
  end

  def rateup
    @micropost= Micropost.find(params[:id])

    if @micropost.update_column(:rating, @micropost.rating+1)
      redirect_to root_url, :notice => "Rated Up +"
    else
      render "home"
    end
  end

  helper_method :rateup

  def ratedown
    @micropost.update_attribute(:rating, @micropost.rating - 1)
    redirect_to root_url
  end

  helper_method :ratedown

  private

    def micropost_params
      params.require(:micropost).permit(:content, :rating)
    end
  
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
