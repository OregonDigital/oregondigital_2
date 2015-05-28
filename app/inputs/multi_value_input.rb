class MultiValueInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    @rendered_first_element = false
    input_html_classes.unshift("string")
    input_html_options[:name] ||= "#{object_name}[#{attribute_name}][]"

    template.content_tag("ul", :class => "listing") do
      collection_inputs
    end
  end

  protected
    def collection_inputs
      tags = []
      collection.each_with_index do |value, index|
        tags << template.content_tag("li", :class => "field-wrapper") do
          build_field(value, index)
        end
      end
      tags.reduce(:<<)
    end

    # Although the 'index' parameter is not used in this implementation it is useful in an
    # an overridden version of this method, especially when the field is a complex object and
    # the override defines nested fields.
    def build_field_options(value, index)
      options = input_html_options.dup

      options[:value] = value
      if @rendered_first_element
        options[:id] = nil
        options[:required] = nil
      else
        options[:id] ||= input_dom_id
      end
      options[:class] ||= []
      options[:class] += ["#{input_dom_id} form-control multi-text-field"]
      options[:'aria-labelledby'] = label_id
      @rendered_first_element = true

      options
    end

    def build_field(value, index)
      options = build_field_options(value, index)
      if options.delete(:type) == 'textarea'.freeze
        @builder.text_area(attribute_name, options)
      else
        @builder.text_field(attribute_name, options)
      end
    end

    def label_id
      input_dom_id + '_label'
    end

    def input_dom_id
      input_html_options[:id] || "#{object_name}_#{attribute_name}"
    end

    def collection
      @collection ||= Array.wrap(object[attribute_name]).reject { |value| value.to_s.strip.blank? } + ['']
    end
end
