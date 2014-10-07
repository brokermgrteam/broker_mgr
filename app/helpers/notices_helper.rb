module NoticesHelper
	def notice_count(user)
		@count = Notice.unread(user).count
		if @count == 0
			content_tag(:span, @count , :class => "badge")
		else
			content_tag(:span, @count , :class => "badge badge-warning")
		end
	end
end
