module Admin::AdminHelper
  def admin_menu_internal_link link_name, active, fa_symbol=nil
    fa_symbol ||= link_name
    content_tag :li do
      content_tag :a, (content_tag :i, "", class:"fa fa-#{fa_symbol} fa-fw") + " " + link_name.capitalize,
        { href: eval("admin_" + link_name + "_path")}.merge(active ? {class: "active"} : {})
    end
  end
  
  def admin_menu_external_link link_name, link_path, fa_symbol
    content_tag :li do
      content_tag :a, (content_tag :i, "", class:"fa fa-#{fa_symbol} fa-fw") + " " + link_name.capitalize, { href: link_path}
    end
  end
  
  def admin_link_to_new object_name, parameters=nil
    link_to 'New ' + object_name.capitalize, eval("new_admin_" + object_name.downcase + "_path(parameters)"), class: "btn btn-default"
  end
  
  def admin_link_to_index_of object_name, parameters=nil
    link_to "Back to #{object_name.capitalize} List", eval("admin_" + object_name.pluralize.downcase + "_path(parameters)"), class: "btn btn-default"
  end

  def admin_link_to_show object, parameters=nil
    link_to 'Show', eval("admin_" + object.class.to_s.downcase + "_path(object, parameters)"), class: "btn btn-default"
  end
  
  def admin_link_to_edit object, parameters=nil
    link_to 'Edit', eval("edit_admin_" + object.class.to_s.downcase + "_path(object, parameters)"), class: "btn btn-default"
  end
  
  def admin_link_to_delete object, parameters=nil
    link_to 'Delete', eval("admin_" + object.class.to_s.downcase + "_path(object, parameters)"), method: :delete, data: { confirm: 'Are you sure?' }, class: "btn btn-default"
  end
  
  def admin_empty_list_check_of list
    content_tag :h4, "The list is empty." if list.count == 0
  end
end