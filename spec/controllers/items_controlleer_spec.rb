require 'rails_helper'

describe ItemsController, type: :controller do

def self.it_renders_404_when_item_is_not_found(*actions)
  actions.each do |a|
    it "#{a} it_renders_404_when_item_is_not_found" do
      verb = if a == :update
        "PATCH"
      elsif a == :destroy
        "DELETE"
      else
        "GET"
      end
      process a, verb, id: 0
      expect(response.status).to eq(404)
    end
  end
end

it_renders_404_when_item_is_not_found(:show, :edit, :update, :destroy)

  describe "#show action" do
    it "renders show template if an item is found" do
      item = create(:item)
      get :show, { id: item.id }
      expect(response).to render_template("show")
    end
  end

  describe "#create action" do
    context "if validation is pass" do
      it "renders item page" do
        post :create, item: { name: 'Item 1', price: '10', description: 'nice item' }
        expect(response).to redirect_to(item_path(assigns(:item)))
      end
    end

    context "if validation is fail" do
      it "redirects to create page" do
        post :create, item: { name: 'Item 1', price: nil }
        expect(response).to render_template("new")
      end
    end
  end

  describe "#destroy action" do
    it "redirects to items page when an item is destroyed" do
      item1 = create(:item)
      item2 = create(:item, name: 'item 2')
      delete :destroy, id: item1.id
      expect(response).to redirect_to(items_path)
    end
  end

end