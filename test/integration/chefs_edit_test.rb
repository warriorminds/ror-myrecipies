require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Rodrigo", email: "rodrigo@example.com", password: "password", password_confirmation: "password")
  end
  
  test "reject invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "", email: "rodrigo@example.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid signup" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Rodrigo Guerrero", email: "rodrigoguerrero@example.com" } }
    assert_redirected_to @chef # show recipe path.
    assert_not flash.empty?
    @chef.reload
    assert_match "Rodrigo Guerrero", @chef.chefname
    assert_match "rodrigoguerrero@example.com", @chef.email
  end
end
