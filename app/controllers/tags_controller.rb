class TagsController < ApplicationController

def index
	@feed_items=Tag.paginate(:page => params[:page], :per_page => 10)
end

def show
	@tag=Tag.find(params[:id])
	@microposts=posts_with_tag(Micropost.all,@tag.name).paginate(:page => params[:page], :per_page => 10)
	@feed_items=posts_with_tag(Micropost.all,@tag.name).paginate(:page => params[:page], :per_page => 10)
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

end