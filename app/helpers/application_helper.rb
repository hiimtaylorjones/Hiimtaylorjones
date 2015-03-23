module ApplicationHelper

	def markdown(text)
		options = {
			fenced_code_blocks: true,
			space_after_headers: true
		}

		extensions = {
			filter_html: true,
			hard_wrap: true,
			link_attributes: { rel: 'nofollow', target: "blank"},
		}

		renderer = Redcarpet::Render::HTML.new(extensions)
		markdown = Redcarpet::Markdown.new(renderer, options)

		markdown.render(text).html_safe
	end
end
