module NoticesHelper
	def notice_count(user)
		content_tag(:span, Notice.unread(user).count, :class => "badge badge-warning")
	end
end
