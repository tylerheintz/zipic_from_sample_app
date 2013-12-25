class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @user=User.new
    end
  end

  def top_rated
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items= Micropost.all.sort_by{|micropost| micropost.rating}.reverse
    end
  end

  def mixer
    #if signed_in?
     # @feed_items=Micropost.all.notyetrated
    #end
    @view_its=arr0to3( narrow_array(Micropost.all, current_user.id) )
  end

  def help
  end

  def about
  end

  def contact
  end

  def ratedbefore(userid, postid)
    @viewing= Viewing.find_by_user_id_and_micropost_id(userid, postid)
    return @viewing.present?
  end

  def narrow_array(arrayofposts, userid)
    newarr=Array.new
    arrayofposts.each do |post|
      if !ratedbefore(userid, post.id)
        newarr.push(post)
      end
    end
    return newarr
  end

  def arr0to3(array)
    if array.length<4
      return array
    end
    newarr=Array.new
    i=0
    4.times do
      newarr.push(array[i])
      i+=1
    end
    return newarr
  end
end
