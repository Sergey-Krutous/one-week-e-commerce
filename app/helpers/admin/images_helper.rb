module Admin::ImagesHelper
  def admin_link_to_images_of product
    link_to "Image List", admin_images_path(product), class: "btn btn-default"
  end
  
  def admin_link_back_to_images_of product
    link_to "Back to Image List", admin_images_path(product), class: "btn btn-default"
  end
  
  def admin_link_to_new_image_of product
    link_to 'New Image', admin_new_image_path(product), class: "btn btn-default"
  end
  
  def admin_link_to_details_of product
    link_to 'Back to Product', admin_product_path(product), class: "btn btn-default"
  end
end