require 'action_view/helpers/tag_helper'

module TagMetadataExtension
  def self.included base
    base.class_eval do
      alias_method_chain :content_tag, :metadata
    end
  end

  def content_tag_with_metadata name, options_with_block = nil, options_without_block = nil, escape = true, &block
    if block.blank?
      TagMetadataExtension.parse_metadata! options_without_block
    else
      TagMetadataExtension.parse_metadata! options_with_block
    end

    content_tag_without_metadata name, options_with_block, options_without_block, escape, &block
  end

  def parse_metadata! options
    return if options.nil?
    if (metadata = options.delete(:metadata))
      data = options.delete(:data)
      options.merge! :data => [ data, metadata.to_json.gsub('"', "'") ].compact.join(' ')
    end
    options
  end

  module_function :parse_metadata!
end

ActionView::Helpers::TagHelper.send(:include, TagMetadataExtension)
