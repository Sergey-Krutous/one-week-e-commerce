module ApplicationHelper
  def menu_link link_name, url
    content_tag :li do
      content_tag :a, link_name, href: url
    end
  end
  
  def menu_category_link category
    content_tag :li, category.depth == 0 || category.children.count == 0 ? {} : {class: "dropdown-submenu"} do
      if category.children.count == 0 then
        content_tag :a, category.title, href: friendly_path_to(category)
      else
        content = content_tag :a, href: "#", class: "dropdown-toggle", "data-toggle" => "dropdown" do
          (category.title + (category.depth > 0 ? "" : (" " + (content_tag :b, nil, class: "caret")))).html_safe
        end
        content += content_tag :ul, nil, class: category.depth == 0 ? "dropdown-menu multi-level" : "dropdown-menu" do
          child_content = content_tag :li do
            content_tag :a, "All", href: friendly_path_to(category)
          end
          category.children.each { |subcategory| child_content = (child_content + menu_category_link(subcategory)).html_safe }
          child_content
        end
        content.html_safe
      end
    end
  end
  
  def friendly_path_to sluggable
    return sluggable.slug unless sluggable.slug.blank?
    return product_path sluggable if sluggable.is_a?(Product)
    return products_path({category_id: sluggable.id}) if sluggable.is_a?(Category)
  end
end
