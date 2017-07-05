module ApplicationHelper
	require 'github/markup'

	def markdown(text)
		GitHub::Markup.render_s(GitHub::Markups::MARKUP_MARKDOWN, text)
	end
end
