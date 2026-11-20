require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#markdown' do
    # Commonmarker's safe mode already drops raw HTML and javascript: links, so
    # feeding these through it would pass even without sanitize. Stubbing it to
    # return hostile HTML proves sanitize holds on its own.
    describe 'sanitizing rendered HTML' do
      def sanitized(html)
        allow(Commonmarker).to receive(:to_html).and_return(html)
        helper.markdown('ignored')
      end

      it 'strips <script> tags' do
        output = sanitized('<script>alert("xss")</script><p>Hello</p>')
        expect(output).not_to include('<script')
        expect(output).to include('<p>Hello</p>')
      end

      it 'strips inline event handlers from allowed tags' do
        output = sanitized('<p onmouseover="alert(1)">text</p><img src="a.png" onerror="alert(1)">')
        expect(output).not_to include('onmouseover')
        expect(output).not_to include('onerror')
        expect(output).to include('<img src="a.png">')
      end

      it 'strips javascript: hrefs' do
        output = sanitized('<a href="javascript:alert(1)">click</a>')
        expect(output).not_to include('javascript:')
        expect(output).to include('click')
      end

      it 'strips <iframe> tags' do
        output = sanitized('<iframe src="https://evil.example"></iframe>')
        expect(output).not_to include('<iframe')
      end
    end

    it 'preserves standard markdown headings' do
      output = helper.markdown('## Hello')
      expect(output).to include('<h2')
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
