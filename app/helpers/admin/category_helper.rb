module Admin::CategoryHelper
  def admin_breadcrumb category
    ((category.parent.nil? ? "" : admin_breadcrumb(category.parent) + " \\ ") + (content_tag :a, category.title, href: admin_category_path(category))).html_safe
  end
  
  def admin_link_to_siblings_of category
    if category.parent_id.nil?
      admin_link_to_index_of "category"
    else  
      link_to "Back to Child Category List", admin_child_categories_path({parent_id: category.parent_id}), class: "btn btn-default"
    end
  end
end