require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#markdown' do
    it 'strips <script> tags from post body' do
      output = helper.markdown('<script>alert("xss")</script>Hello')
      expect(output).not_to include('<script>')
      expect(output).not_to include('alert("xss")')
    end

    it 'strips inline event handlers from allowed tags' do
      output = helper.markdown('<p onmouseover="alert(1)">text</p>')
      expect(output).not_to include('onmouseover')
    end

    it 'strips javascript: hrefs' do
      output = helper.markdown('[click](javascript:alert(1))')
      expect(output).not_to include('javascript:')
    end

    it 'strips <iframe> tags' do
      output = helper.markdown('<iframe src="https://evil.com"></iframe>')
      expect(output).not_to include('<iframe>')
    end

    it 'preserves standard markdown headings' do
      output = helper.markdown('## Hello')
      expect(output).to include('<h2>')
      expect(output).to include('Hello')
    end

    it 'preserves links with safe hrefs' do
      output = helper.markdown('[Ruby](https://ruby-lang.org)')
      expect(output).to include('<a href="https://ruby-lang.org"')
      expect(output).to include('Ruby')
    end

    it 'preserves code blocks' do
      output = helper.markdown("```\nputs 'hi'\n```")
      expect(output).to include('<code>')
    end

    it 'returns an html_safe string' do
      output = helper.markdown('hello')
      expect(output).to be_html_safe
    end
  end
end
