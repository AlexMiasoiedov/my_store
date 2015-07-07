class ItemsMailer < ActionMailer::Base
  default from: "info@mystore.localhost",
          template_path: "mailers/items"

  def item_destroyed(item)
    @item = item
    mail(to: 'alexmiasoiedow@outlook.com', subject: "Item Destroyed")
  end

end
