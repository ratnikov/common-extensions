require 'test_helper'

class TagMetadataExtensionTest < ActiveSupport::TestCase
  def content_tag *args
    @content_tag_args = args
    :conten_tag
  end
  include TagMetadataExtension

  should("pass truthitest") { assert true }

  context "#content_tag_with_metadata" do

    context "with no block" do
      setup do
        @name = :foo
        @content = "Foo bar stuff"
        @options = { :foo => 'bar', :metadata => { :alpha => 'a' } }
      end

      evaluate { @content_tag = content_tag_with_metadata @name, @content, @options }

      should("append metadata to 'data' attribute") { assert_equal({ :foo => 'bar', :data => "{'alpha':'a'}" }, @content_tag_args[2]) }

      context "with existing 'data' contents" do
        setup { @options.merge!(:data => 'zeta') }
        should("keep the original data values as well") { assert_equal({ :foo => 'bar', :data => "zeta {'alpha':'a'}" }, @content_tag_args[2]) }
      end
    end

    context "with block" do
      setup do
        @name = :foo
        @options = { :metadata => { :foo => 'bar' } }
      end

      evaluate { @content_tag = content_tag_with_metadata(@name, @options) { "foo " } }
      should("append metadata as json to 'data' attribute") { assert_equal({:data => { :foo => 'bar' }.to_json.gsub('"', "'") }, @content_tag_args[1]) }
    end
  end
end
