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
      return_str = " " * leading_indent
      input_str = string
      current_breakpoint = @linebreak - leading_indent

      # byebug
      while input_str.size > current_breakpoint
        return_str += input_str[0..(current_breakpoint-1)]
        return_str += "\n"
        input_str = input_str[current_breakpoint..-1]
      end
      return_str += input_str[0..-1]

      return_str
    end
  end
end
