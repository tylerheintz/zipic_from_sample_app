module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Zipic - The Social Network That's Changing the Game"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def mprate(mprating, upordown)
  	if upordown
  		return (mprating + 3)
  	else
  		return (mprating - 1)
  	end
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
    return finalrating/i
  end

  def firstname(userid)
  	@user=User.find(userid)
  	name_arr=@user.name.split(" ")
  	return name_arr[0]
  end

  def ratedbefore(userid, postid)
    @viewing= Viewing.find_by_user_id_and_micropost_id(userid, postid)
    return @viewing.present?
  end

  def present
    !nil?
  end

  def to_cool_array(arrstring)
    newstring=""
    for i in arrstring do
      if arrstring[i..i+1]!="[" && arrstring[i..i+1]!="]"
        newstring+=arrstring[i..i+1]
      end
    end
    return newstring.split(",").map(&:to_i)
  end
end
