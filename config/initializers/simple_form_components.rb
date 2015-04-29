# encoding: utf-8
module SimpleForm
  module Components
    module Typeahead
      def typeahead(wrapper_options = nil)
        unless typeahead_source.empty?
          input_html_options['data-provide'] ||= 'typeahead'
          input_html_options['data-items'] ||= 5
          input_html_options['data-source'] ||= typeahead_source.inspect.to_s
          nil
        end
      end

      def typeahead_source
        tdata = options[:typeahead]
        return Array(tdata)
      end
    end
  end

  module Inputs
      class FileInput < Base
        def input
          idf = "#{lookup_model_names.join("_")}_#{reflection_or_attribute_name}"
          input_html_options[:style] ||= 'display:none;'

          button = template.content_tag(:div, class: 'input-append') do
            template.tag(:input, id: "pbox_#{idf}", class: 'string input-medium', type: 'text') +
            template.content_tag(:a, "选择", class: 'btn', onclick: "$('input[id=#{idf}]').click();")
          end

          script = template.content_tag(:script, type: 'text/javascript') do
            "$('input[id=#{idf}]').change(function() { s = $(this).val(); $('#pbox_#{idf}').val(s.slice(s.lastIndexOf('\\\\\\\\')+1)); });".html_safe
          end

          @builder.file_field(attribute_name, input_html_options) + button + script
        end
      end
    end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Typeahead)
