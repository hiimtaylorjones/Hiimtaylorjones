module Handlers
  class MarkdownHandler
    def call(template, source)
      content = Commonmarker.to_html(source)
      "#{content.inspect}.html_safe"
    end
  end
end