module ApplicationHelper
  MARKDOWN_ALLOWED_TAGS = %w[
    p br a ul ol li em strong b i h1 h2 h3 h4 h5 h6
    blockquote pre code img hr table thead tbody tr th td
  ].freeze
  MARKDOWN_ALLOWED_ATTRS = %w[href src alt class title id].freeze

  def markdown(text)
    sanitize(Commonmarker.to_html(text), tags: MARKDOWN_ALLOWED_TAGS, attributes: MARKDOWN_ALLOWED_ATTRS)
  end
end
