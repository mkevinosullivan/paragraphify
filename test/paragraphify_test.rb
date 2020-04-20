# frozen_string_literal: true

require "test_helper"
require 'yaml'
require 'byebug'

class ParagraphifyTest < Minitest::Test
  def store_test_data(test:)
    hash = {}

    # DEBUG puts "######### TEST = "
    # DEBUG p test

    hash[:input] = test["input"]
    hash[:lb80_li0_hi0] = test["expected"]["lb80_li0_hi0"].reduce("") { |res, v| res == "" ? v[1] : res << "\n" + v[1] }
    hash[:lb80_li4_hi0] = test["expected"]["lb80_li4_hi0"].reduce("") { |res, v| res == "" ? v[1] : res << "\n" + v[1] }
    hash[:lb80_li0_hi8] = test["expected"]["lb80_li0_hi8"].reduce("") { |res, v| res == "" ? v[1] : res << "\n" + v[1] }
    hash[:lb80_li4_hi8] = test["expected"]["lb80_li4_hi8"].reduce("") { |res, v| res == "" ? v[1] : res << "\n" + v[1] }

    hash
  end

  def setup
    # DEBUG puts "I am here: ", File.basename(Dir.getwd)
    @contents ||= File.read("test/test_strings.yml")
    @test_data ||= YAML.load(@contents)

    @len50 = store_test_data(test: @test_data["len50"])
    @len79 = store_test_data(test: @test_data["len79"])
    @len80_ends_with_space = store_test_data(test: @test_data["len80_ends_with_space"])
    @len100 = store_test_data(test: @test_data["len100"])
    @len159 = store_test_data(test: @test_data["len159"])
    @len159_ends_with_space = store_test_data(test: @test_data["len159_ends_with_space"])
    @len159_strategic_spacing = store_test_data(test: @test_data["len159_strategic_spacing"])
    @len235 = store_test_data(test: @test_data["len235"])
    @len320 = store_test_data(test: @test_data["len320"])
  end

  def test_that_it_has_a_version_number
    refute_nil(::Paragraphify::VERSION)
  end

  #
  # test new() with defaults
  #
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

  #
  # test setters
  #
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

  #
  # test new() with args - various combos of one arg, two args, three args
  #
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

  #
  # test paragraphify()
  #
  def test_paragraphify_returns_a_string
    p = Paragraphify::Paragraph.new

    assert_kind_of(String, p.paragraphify(string: ""))
  end

  def test_paragraphify_returns_a_string_with_leading_indent
    p = Paragraphify::Paragraph.new(leading_indent: 4)

    input_string = "This is a test string."
    expected_string = format("    %s", input_string)
    assert_equal(expected_string, p.paragraphify(string: input_string))
  end

  #
  # test paragraphify() with defaults - linebreak = 80, leading_indent = 0, hanging_indent = 0
  #
  def test_paragraphify_len50_lb80_li0_hi0
    p = Paragraphify::Paragraph.new

    # DEBUG puts "\n", @len50[:input], "\n"
    # DEBUG puts "\n", @len50[:lb80_li0_hi0], "\n"

    assert_equal(@len50[:lb80_li0_hi0], p.paragraphify(string: @len50[:input]))
  end

  def test_paragraphify_len79_lb80_li0_hi0
    p = Paragraphify::Paragraph.new

    # DEBUG puts "\n", @len79[:input], "\n"
    # DEBUG puts "\n", @len79[:lb80_li0_hi0], "\n"

    assert_equal(@len79[:lb80_li0_hi0], p.paragraphify(string: @len79[:input]))
  end

  def test_paragraphify_len80_ends_with_space_lb80_li0_hi0
    p = Paragraphify::Paragraph.new

    # DEBUG puts "\n", @len80_ends_with_space[:input], "\n"
    # DEBUG puts "\n", @len80_ends_with_space[:lb80_li0_hi0], "\n"

    assert_equal(@len80_ends_with_space[:lb80_li0_hi0], p.paragraphify(string: @len80_ends_with_space[:input]))
  end

  def test_paragraphify_len100_lb80_li0_hi0
    p = Paragraphify::Paragraph.new

    # DEBUG puts "\n", @len100[:input], "\n"
    # DEBUG puts "\n", @len100[:lb80_li0_hi0], "\n"

    assert_equal(@len100[:lb80_li0_hi0], p.paragraphify(string: @len100[:input]))
  end

  def test_paragraphify_len159_lb80_li0_hi0
    p = Paragraphify::Paragraph.new

    # DEBUG puts "\n", @len159[:input], "\n"
    # DEBUG puts "\n", @len159[:lb80_li0_hi0], "\n"

    assert_equal(@len159[:lb80_li0_hi0], p.paragraphify(string: @len159[:input]))
  end

  def test_paragraphify_len159_ends_with_space_lb80_li0_hi0
    p = Paragraphify::Paragraph.new

    # DEBUG puts "\n", @len159_ends_with_space[:input], "\n"
    # DEBUG puts "\n", @len159_ends_with_space[:lb80_li0_hi0], "\n"

    assert_equal(@len159_ends_with_space[:lb80_li0_hi0], p.paragraphify(string: @len159_ends_with_space[:input]))
  end

  def test_paragraphify_len159_strategic_spacing_lb80_li0_hi0
    p = Paragraphify::Paragraph.new

    # DEBUG puts "\n", @len159_strategic_spacing[:input], "\n"
    # DEBUG puts "\n", @len159_strategic_spacing[:lb80_li0_hi0], "\n"

    assert_equal(@len159_strategic_spacing[:lb80_li0_hi0], p.paragraphify(string: @len159_strategic_spacing[:input]))
  end

  def test_paragraphify_len235_lb80_li0_hi0
    p = Paragraphify::Paragraph.new

    # DEBUG puts "\n", @len235[:input], "\n"
    # DEBUG puts "\n", @len235[:lb80_li0_hi0], "\n"

    assert_equal(@len235[:lb80_li0_hi0], p.paragraphify(string: @len235[:input]))
  end

  def test_paragraphify_len320_lb80_li0_hi0
    p = Paragraphify::Paragraph.new

    # DEBUG puts "\n", @len320[:input], "\n"
    # DEBUG puts "\n", @len320[:lb80_li0_hi0], "\n"

    assert_equal(@len320[:lb80_li0_hi0], p.paragraphify(string: @len320[:input]))
  end

  #
  # test paragraphify() with linebreak = 80, leading_indent = 4, hanging_indent = 0
  #
  def test_paragraphify_len50_lb80_li4_hi0
    p = Paragraphify::Paragraph.new(leading_indent: 4)

    # DEBUG puts "\n", @len50[:input], "\n"
    # DEBUG puts "\n", @len50[:lb80_li4_hi0], "\n"

    assert_equal(@len50[:lb80_li4_hi0], p.paragraphify(string: @len50[:input]))
  end

  def test_paragraphify_len79_lb80_li4_hi0
    p = Paragraphify::Paragraph.new(leading_indent: 4)

    # DEBUG puts "\n", @len79[:input], "\n"
    # DEBUG puts "\n", @len79[:lb80_li4_hi0], "\n"

    assert_equal(@len79[:lb80_li4_hi0], p.paragraphify(string: @len79[:input]))
  end

  def test_paragraphify_len80_ends_with_space_lb80_li4_hi0
    p = Paragraphify::Paragraph.new(leading_indent: 4)

    # DEBUG puts "\n", @len80_ends_with_space[:input], "\n"
    # DEBUG puts "\n", @len80_ends_with_space[:lb80_li4_hi0], "\n"

    assert_equal(@len80_ends_with_space[:lb80_li4_hi0], p.paragraphify(string: @len80_ends_with_space[:input]))
  end

  def test_paragraphify_len100_lb80_li4_hi0
    p = Paragraphify::Paragraph.new(leading_indent: 4)

    # DEBUG puts "\n", @len100[:input], "\n"
    # DEBUG puts "\n", @len100[:lb80_li4_hi0], "\n"

    assert_equal(@len100[:lb80_li4_hi0], p.paragraphify(string: @len100[:input]))
  end

  def test_paragraphify_len159_lb80_li4_hi0
    p = Paragraphify::Paragraph.new(leading_indent: 4)

    # DEBUG puts "\n", @len159[:input], "\n"
    # DEBUG puts "\n", @len159[:lb80_li4_hi0], "\n"

    assert_equal(@len159[:lb80_li4_hi0], p.paragraphify(string: @len159[:input]))
  end

  def test_paragraphify_len159_strategic_spacing_lb80_li4_hi0
    p = Paragraphify::Paragraph.new(leading_indent: 4)

    # DEBUG puts "\n", @len159_strategic_spacing[:input], "\n"
    # DEBUG puts "\n", @len159_strategic_spacing[:lb80_li4_hi0], "\n"

    assert_equal(@len159_strategic_spacing[:lb80_li4_hi0], p.paragraphify(string: @len159_strategic_spacing[:input]))
  end

  def test_paragraphify_len235_lb80_li4_hi0
    p = Paragraphify::Paragraph.new(leading_indent: 4)

    # DEBUG puts "\n", @len235[:input], "\n"
    # DEBUG puts "\n", @len235[:lb80_li4_hi0], "\n"

    assert_equal(@len235[:lb80_li4_hi0], p.paragraphify(string: @len235[:input]))
  end

  def test_paragraphify_len320_lb80_li4_hi0
    p = Paragraphify::Paragraph.new(leading_indent: 4)

    # DEBUG puts "\n", @len320[:input], "\n"
    # DEBUG puts "\n", @len320[:lb80_li4_hi0], "\n"

    assert_equal(@len320[:lb80_li4_hi0], p.paragraphify(string: @len320[:input]))
  end

  # #
  # # test paragraphify() with linebreak = 80, leading_indent = 0, hanging_indent = 8
  # #
  def test_paragraphify_len50_lb80_li0_hi8
    p = Paragraphify::Paragraph.new(hanging_indent: 8)

    # DEBUG puts "\n", @len50[:input], "\n"
    # DEBUG puts "\n", @len50[:lb80_li0_hi8], "\n"

    assert_equal(@len50[:lb80_li0_hi8], p.paragraphify(string: @len50[:input]))
  end

  def test_paragraphify_len79_lb80_li0_hi8
    p = Paragraphify::Paragraph.new(hanging_indent: 8)

    # DEBUG puts "\n", @len79[:input], "\n"
    # DEBUG puts "\n", @len79[:lb80_li0_hi8], "\n"

    assert_equal(@len79[:lb80_li0_hi8], p.paragraphify(string: @len79[:input]))
  end

  def test_paragraphify_len80_ends_with_space_lb80_li0_hi8
    p = Paragraphify::Paragraph.new(hanging_indent: 8)

    # DEBUG puts "\n", @len80_ends_with_space[:input], "\n"
    # DEBUG puts "\n", @len80_ends_with_space[:lb80_li0_hi8], "\n"

    assert_equal(@len80_ends_with_space[:lb80_li0_hi8], p.paragraphify(string: @len80_ends_with_space[:input]))
  end

  def test_paragraphify_len100_lb80_li0_hi8
    p = Paragraphify::Paragraph.new(hanging_indent: 8)

    # DEBUG puts "\n", @len100[:input], "\n"
    # DEBUG puts "\n", @len100[:lb80_li0_hi8], "\n"

    assert_equal(@len100[:lb80_li0_hi8], p.paragraphify(string: @len100[:input]))
  end

  def test_paragraphify_len159_lb80_li0_hi8
    p = Paragraphify::Paragraph.new(hanging_indent: 8)

    # DEBUG puts "\n", @len159[:input], "\n"
    # DEBUG puts "\n", @len159[:lb80_li0_hi8], "\n"

    assert_equal(@len159[:lb80_li0_hi8], p.paragraphify(string: @len159[:input]))
  end

  def test_paragraphify_len159_ends_with_space_lb80_li0_hi8
    p = Paragraphify::Paragraph.new(hanging_indent: 8)

    # DEBUG
    # puts "#*#*#*#*#*#*#*#*#\n[", @len159_ends_with_space[:input], "]\n"
    # DEBUG
    # puts "\n[", @len159_ends_with_space[:lb80_li0_hi8], "]\n#*#*#*#*#*#*#*#*#\n"

    assert_equal(@len159_ends_with_space[:lb80_li0_hi8], p.paragraphify(string: @len159_ends_with_space[:input]))
  end

  def test_paragraphify_len159_strategic_spacing_lb80_li0_hi8
    p = Paragraphify::Paragraph.new(hanging_indent: 8)

    # DEBUG puts "\n", @len159_strategic_spacing[:input], "\n"
    # DEBUG puts "\n", @len159_strategic_spacing[:lb80_li0_hi8], "\n"

    assert_equal(@len159_strategic_spacing[:lb80_li0_hi8], p.paragraphify(string: @len159_strategic_spacing[:input]))
  end

  def test_paragraphify_len235_lb80_li0_hi8
    p = Paragraphify::Paragraph.new(hanging_indent: 8)

    # DEBUG puts "\n", @len235[:input], "\n"
    # DEBUG puts "\n", @len235[:lb80_li0_hi8], "\n"

    assert_equal(@len235[:lb80_li0_hi8], p.paragraphify(string: @len235[:input]))
  end

  def test_paragraphify_len320_lb80_li0_hi8
    p = Paragraphify::Paragraph.new(hanging_indent: 8)

    # DEBUG puts "\n", @len320[:input], "\n"
    # DEBUG puts "\n", @len320[:lb80_li0_hi8], "\n"

    assert_equal(@len320[:lb80_li0_hi8], p.paragraphify(string: @len320[:input]))
  end

  # #
  # # test paragraphify() with linebreak = 80, leading_indent = 4, hanging_indent = 8
  # #
  def test_paragraphify_len50_lb80_li4_hi8
    p = Paragraphify::Paragraph.new(leading_indent: 4, hanging_indent: 8)

    # DEBUG puts "\n", @len50[:input], "\n"
    # DEBUG puts "\n", @len50[:lb80_li4_hi8], "\n"

    assert_equal(@len50[:lb80_li4_hi8], p.paragraphify(string: @len50[:input]))
  end

  def test_paragraphify_len79_lb80_li4_hi8
    p = Paragraphify::Paragraph.new(leading_indent: 4, hanging_indent: 8)

    # DEBUG puts "\n", @len79[:input], "\n"
    # DEBUG puts "\n", @len79[:lb80_li4_hi8], "\n"

    assert_equal(@len79[:lb80_li4_hi8], p.paragraphify(string: @len79[:input]))
  end

  def test_paragraphify_len80_ends_with_space_lb80_li4_hi8
    p = Paragraphify::Paragraph.new(leading_indent: 4, hanging_indent: 8)

    # DEBUG puts "\n", @len80_ends_with_space[:input], "\n"
    # DEBUG puts "\n", @len80_ends_with_space[:lb80_li4_hi8], "\n"

    assert_equal(@len80_ends_with_space[:lb80_li4_hi8], p.paragraphify(string: @len80_ends_with_space[:input]))
  end

  def test_paragraphify_len100_lb80_li4_hi8
    p = Paragraphify::Paragraph.new(leading_indent: 4, hanging_indent: 8)

    # DEBUG puts "\n", @len100[:input], "\n"
    # DEBUG puts "\n", @len100[:lb80_li4_hi8], "\n"

    assert_equal(@len100[:lb80_li4_hi8], p.paragraphify(string: @len100[:input]))
  end

  def test_paragraphify_len159_lb80_li4_hi8
    p = Paragraphify::Paragraph.new(leading_indent: 4, hanging_indent: 8)

    # DEBUG puts "\n", @len159[:input], "\n"
    # DEBUG puts "\n", @len159[:lb80_li4_hi8], "\n"

    assert_equal(@len159[:lb80_li4_hi8], p.paragraphify(string: @len159[:input]))
  end

  def test_paragraphify_len159_ends_with_space_lb80_li4_hi8
    p = Paragraphify::Paragraph.new(leading_indent: 4, hanging_indent: 8)

    # DEBUG puts "\n", @len159_ends_with_space[:input], "\n"
    # DEBUG puts "\n", @len159_ends_with_space[:lb80_li4_hi8], "\n"

    assert_equal(@len159_ends_with_space[:lb80_li4_hi8], p.paragraphify(string: @len159_ends_with_space[:input]))
  end

  def test_paragraphify_len159_strategic_spacing_lb80_li4_hi8
    p = Paragraphify::Paragraph.new(leading_indent: 4, hanging_indent: 8)

    # DEBUG puts "\n", @len159_strategic_spacing[:input], "\n"
    # DEBUG puts "\n", @len159_strategic_spacing[:lb80_li4_hi8], "\n"

    assert_equal(@len159_strategic_spacing[:lb80_li4_hi8], p.paragraphify(string: @len159_strategic_spacing[:input]))
  end

  def test_paragraphify_len235_lb80_li4_hi8
    p = Paragraphify::Paragraph.new(leading_indent: 4, hanging_indent: 8)

    # DEBUG puts "\n", @len235[:input], "\n"
    # DEBUG puts "\n", @len235[:lb80_li4_hi8], "\n"

    assert_equal(@len235[:lb80_li4_hi8], p.paragraphify(string: @len235[:input]))
  end

  def test_paragraphify_len320_lb80_li4_hi8
    p = Paragraphify::Paragraph.new(leading_indent: 4, hanging_indent: 8)

    # DEBUG puts "\n", @len320[:input], "\n"
    # DEBUG puts "\n", @len320[:lb80_li4_hi8], "\n"

    assert_equal(@len320[:lb80_li4_hi8], p.paragraphify(string: @len320[:input]))
  end
end
