module ProductsHelper
  def breadcrumb category
    ((category.parent.nil? ? "" : breadcrumb(category.parent) + " \\ ") + (content_tag :a, category.title, href: friendly_path_to(category))).html_safe
  end
end