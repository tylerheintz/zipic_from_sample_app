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

  def find_tags_in(content)
    tagsarr=Array.new
    content.split(" ").each do |word|
      holder=word[0]
      if holder=="#"
        tagsarr.push(word)
      end
    end
    return tagsarr
  end

  def find_users_in(content)
    usersarr=Array.new
    content.split(" ").each do |word|
      holder=word[0]
      if holder=="@"
        usersarr.push(word)
      end
    end
    return usersarr
  end


  def print_content_with_tags_and_users(content)
    html=""
    content.split(" ").each do |word|
      @uzer=User.find_by_name(word[1..(word.length-1)])
      @tag=Tag.find_by_name(word)
      if find_users_in(content).include?(word) && @uzer.present?
        html += link_to "#{word}", @uzer
        html += " "
      elsif find_tags_in(content).include?(word) && @tag.present?
        html += link_to "#{word}", @tag
        html+=" "
      else
        html += word
        html += " "
      end
    end
    return html.html_safe
  end

  def view_counter(postid)
    @viewings=Viewing.where(micropost_id: postid)
    if @viewings.count==0
      return 0
    else
      return @viewings.count
    end
  end

  # def half_array(array, first_or_last)
  #   i=0
  #   arr=Array.new
  #   array.each do |mp|
  #     if first_or_last  
  #       if i<(array.length/2)
  #         arr.push(mp)
  #       end
  #     else
  #       if i>=(array.length/2)
  #         arr.push(mp)
  #       end
  #     end
  #     i++
  #   end
  #   return arr
  # end


end
