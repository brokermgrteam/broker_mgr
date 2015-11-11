module NoticesHelper
	def notice_count(user)
		@count_notice = Notice.unread(user).count
		@count_massage = Massage.unread(user).count
		@count = @count_notice + @count_massage
		if @count == 0
			content_tag(:span, @count , :class => "badge")
		else
			content_tag(:span, @count , :class => "badge badge-warning")
		end
	end
end
