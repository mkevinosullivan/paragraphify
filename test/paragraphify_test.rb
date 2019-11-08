require "test_helper"
require 'byebug'

class ParagraphifyTest < Minitest::Test
  def generate_string(len:)
    return_string = ""
    num_of_tens = len / 10
    num_of_tens += 1 unless len % 10 == 0

    num_of_tens.times do |i|
      return_string += "." * (10 - (i+1).to_s.size)
      return_string += (i+1).to_s
    end

    return_string = return_string[0..(len-1)]
  end

  def setup
    @string_40 ||= generate_string(len: 40)
    @string_79 ||= generate_string(len: 79)
    @string_81 ||= generate_string(len: 81)
    @string_100 ||= generate_string(len: 100)
    @string_159 ||= generate_string(len: 159)
    @string_160 ||= generate_string(len: 160)
    @string_161 ||= generate_string(len: 161)
    @string_235 ||= generate_string(len: 235)
    @string_310 ||= generate_string(len: 310)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Paragraphify::VERSION
  end

  # test new() with defaults
  def test_linebreak_default_is_80
    p = Paragraphify::Paragraph.new

    assert_equal(80, p.linebreak)
  end

  def test_leading_indent_default_is_0
    p = Paragraphify::Paragraph.new

    assert_equal(0, p.leading_indent)
  end

  def test_hanging_indent_default_is_0
    p = Paragraphify::Paragraph.new

    assert_equal(0, p.hanging_indent)
  end

  # test setters
  def test_linebreak_setter
    p = Paragraphify::Paragraph.new

    assert_equal(72, p.linebreak = 72)
  end

  def test_leading_indent_setter
    p = Paragraphify::Paragraph.new

    assert_equal(10, p.leading_indent = 10)
  end

  def test_hanging_indent_setter
    p = Paragraphify::Paragraph.new

    assert_equal(5, p.hanging_indent = 5)
  end

  # test new() with args
  def test_new_with_linebreak_arg
    p = Paragraphify::Paragraph.new(linebreak: 60)

    assert_equal(60, p.linebreak)
  end

  def test_new_with_leading_indent_arg
    p = Paragraphify::Paragraph.new(leading_indent: 6)

    assert_equal(6, p.leading_indent)
  end

  def test_new_with_hanging_indent_arg
    p = Paragraphify::Paragraph.new(hanging_indent: 26)

    assert_equal(26, p.hanging_indent)
  end

  def test_new_with_linebreak_and_leading_indent_args
    p = Paragraphify::Paragraph.new(linebreak: 40, leading_indent: 24)

    assert(p.linebreak == 40 && p.leading_indent == 24)
  end

  def test_new_with_linebreak_and_hanging_indent_args
    p = Paragraphify::Paragraph.new(linebreak: 56, hanging_indent: 15)

    assert(p.linebreak == 56 && p.hanging_indent == 15)
  end

  def test_new_with_leading_indent_and_hanging_indent_args
    p = Paragraphify::Paragraph.new(leading_indent: 8, hanging_indent: 4)

    assert(p.leading_indent == 8 && p.hanging_indent == 4)
  end

  def test_new_with_linebreak_and_leading_indent_and_hanging_indent_args
    p = Paragraphify::Paragraph.new(linebreak: 72, leading_indent: 10, hanging_indent: 5)

    assert(p.linebreak == 72 && p.leading_indent == 10 && p.hanging_indent == 5)
  end

  def test_paragraphify_returns_a_String
    p = Paragraphify::Paragraph.new

    assert_kind_of String, p.paragraphify(string: "")
  end

  def test_paragraphify_returns_a_String_with_leading_indent
    p = Paragraphify::Paragraph.new(leading_indent: 4)

    input_string = "This is a test string."
    expected_string = format("    %s", input_string)
    assert_equal(expected_string, p.paragraphify(string: input_string))
  end

  def test_paragraphify_100_split_at_80
    p = Paragraphify::Paragraph.new()

    #puts "\n", @string_100, "\n"

    expected_string = @string_100[0..79] + "\n" + @string_100[80..-1]
    #puts "\n", expected_string, "\n"

    assert_equal(expected_string, p.paragraphify(string: @string_100))
  end

  def test_paragraphify_79_split_at_80
    p = Paragraphify::Paragraph.new()

    #puts "\n", @string_79, "\n"

    expected_string = @string_79
    #puts "\n", expected_string, "\n"

    assert_equal(expected_string, p.paragraphify(string: @string_79))
  end

  def test_paragraphify_40_split_at_80
    p = Paragraphify::Paragraph.new()

    #puts "\n", @string_40, "\n"

    expected_string = @string_40
    #puts "\n", expected_string, "\n"

    assert_equal(expected_string, p.paragraphify(string: @string_40))
  end

  def test_paragraphify_81_split_at_80
    p = Paragraphify::Paragraph.new()

    #puts "\n", @string_81, "\n"

    expected_string = @string_81[0..79] + "\n" + @string_81[80..-1]
    #puts "\n", expected_string, "\n"

    assert_equal(expected_string, p.paragraphify(string: @string_81))
  end

  def test_paragraphify_159_split_at_80
    p = Paragraphify::Paragraph.new()

    #puts "\n", @string_159, "\n"

    expected_string = @string_159[0..79] + "\n" + @string_159[80..-1]
    #puts "\n", expected_string, "\n"

    assert_equal(expected_string, p.paragraphify(string: @string_159))
  end

  def test_paragraphify_160_split_at_80
    p = Paragraphify::Paragraph.new()

    #puts "\n", @string_160, "\n"

    expected_string = @string_160[0..79] + "\n" + @string_160[80..-1]
    #puts "\n", expected_string, "\n"

    assert_equal(expected_string, p.paragraphify(string: @string_160))
  end

  def test_paragraphify_161_split_at_80
    p = Paragraphify::Paragraph.new()

    #puts "\n", @string_161, "\n"

    expected_string = @string_161[0..79] + "\n" + @string_161[80..159] + "\n" + @string_161[160..-1]
    #puts "\n", expected_string, "\n"

    assert_equal(expected_string, p.paragraphify(string: @string_161))
  end

  def test_paragraphify_235_split_at_80
    p = Paragraphify::Paragraph.new()

    #puts "\n", @string_235, "\n"

    expected_string = @string_235[0..79] + "\n" + @string_235[80..159] + "\n" + @string_235[160..-1]
    #puts "\n", expected_string, "\n"

    assert_equal(expected_string, p.paragraphify(string: @string_235))
  end

  def test_paragraphify_310_split_at_80
    p = Paragraphify::Paragraph.new()

    #puts "\n", @string_310, "\n"

    expected_string = @string_310[0..79] + "\n" + @string_310[80..159] + "\n"
    expected_string += @string_310[160..239] + "\n" + @string_310[240..-1]
    #puts "\n", expected_string, "\n"

    assert_equal(expected_string, p.paragraphify(string: @string_310))
  end
end


# class Test
#   Expected_string =
#     "[CONDO] \"80 King St, Ottawa, ON\", $599000.00, 4 bed, 3 bath, 1950 sq.ft., floor 15, 4 elevators, has a security guard, monthly fee $950.00, parking not included, monthly parking $300.00\n" \
#     "[TOWNHOUSE] \"620 Wellington St, Halifax, NS\", $499000.00, 3 bed, 2 bath, 1560 sq.ft., entrance at level 3, does not have an elevator, has parking\n" \
#     "[HOUSE] \"420 Elgin St, London, ON\", $899000.00, 4 bed, 2 bath, 2650 sq.ft., 3 levels, does not have a finished basement, has a garage\n"

#   Output_string =
#   "[CONDO] \"80 King St, Ottawa, ON\", $599000.00, 4 bed, 3 bath, 1950 sq.ft.,\n    " \
#   "floor 15, 4 elevators, has a security guard, monthly fee $950.00, parking\n    " \
#   "not included, monthly parking $300.00\n" \
#   "[TOWNHOUSE] \"620 Wellington St, Halifax, NS\", $499000.00, 3 bed, 2\n    " \
#   "bath, 1560 sq.ft., entrance at level 3, does not have an elevator, has\n    " \
#   "parking\n" \
#   "[HOUSE] \"420 Elgin St, London, ON\", $899000.00, 4 bed, 2 bath, 2650\n    " \
#   "sq.ft., 3 levels, does not have a finished basement, has a garage\n"
# end
