module ApplicationHelper
	require 'github/markup'

	def markdown(text)
		Commonmarker.to_html(text).html_safe
	end
end
