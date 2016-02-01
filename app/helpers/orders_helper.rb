module OrdersHelper
  def checkout_field form, field_name, label=nil
    label = field_name.to_s.gsub("_", " ").capitalize if label.nil?
    (content_tag :div, class: "form-group" do
      content_tag(:label, label + ":", class:"col-md-4 control-label") +
      content_tag(:div, class:"col-md-6") do
        form.text_field field_name, class: "form-control"
      end
    end).html_safe
  end
end
