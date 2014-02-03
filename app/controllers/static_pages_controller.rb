class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @top_tags = Tag.all.sort_by{|tag| tag.created_at}.take(10).sort_by{|tag| posts_with_tag(Micropost.all, tag.name).count}.reverse
      @users=User.all.sort_by{|user| user_rating(user.id)}.take(10).reverse
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

  def user_rating(userid)
    @user=User.find(userid)
    finalrating=0
    i=0
    @user.microposts.each do |mp|
      if mp.rating.nil?
        finalrating+=0
      else
        finalrating+=mp.rating
      end
      i+=1
    end
    if i==0
      i+=1
    end
    return ( (finalrating/i) + @user.microposts.count + (@user.comments.count/2) )
  end

  def posts_with_tag(mps,tagname)
    newarr=Array.new
    mps.each do |mp|
      if mp.tags.include?(tagname)
        newarr.push(mp)
      end
    end
    return newarr
  end

  def contact
    @view_its=arr0to3( narrow_array(Micropost.all, current_user.id) )
  end

  def view_counter(postid)
    @viewings=Viewing.where(micropost_id: postid)
    if @viewings.count==0
      return 0
    else
      return @viewings.count
    end
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
