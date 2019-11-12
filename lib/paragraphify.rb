require "paragraphify/version"

module Paragraphify
  class Error < StandardError; end

  class Paragraph
    attr_accessor :linebreak, :leading_indent, :hanging_indent
    
    def initialize(linebreak: 80, leading_indent: 0, hanging_indent: 0)
      @linebreak = linebreak
      @leading_indent = leading_indent
      @hanging_indent = hanging_indent
    end

    def paragraphify(string:)
      return_str = " " * @leading_indent
      input_str = string
      current_breakpoint = @linebreak - @leading_indent

      # DEBUG byebug if "test_paragraphify_len50_lb80_li4_hi0" == caller_locations.first.label
      while input_str.size > current_breakpoint
        # need to find a whitespace character before the breakpoint
        current_breakpoint = input_str[0..(current_breakpoint-1)].rindex(/\s/)
        return_str += input_str[0..(current_breakpoint-1)].strip + "\n" + " " * @hanging_indent
        input_str = input_str[current_breakpoint..-1].lstrip

        # reset breakpoint for while() test
        current_breakpoint = @linebreak - @hanging_indent
      end
      return_str += input_str[0..-1].lstrip

      return_str
    end
  end
end
