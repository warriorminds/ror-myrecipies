require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Rodrigo", email: "rodrigo@example.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "Rodrigo", email: "rodrigo2@example.com", password: "password", password_confirmation: "password")
    @admin = Chef.create!(chefname: "Rodrigo", email: "adimn@example.com", password: "password", password_confirmation: "password", admin: true)
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
  
  test "accept valid edit" do
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
  
  test "accept edit by admin user" do
    sign_in_as(@admin, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Rodrigo Guerrero 2", email: "rodrigoguerrero2@example.com" } }
    assert_redirected_to @chef # show recipe path.
    assert_not flash.empty?
    @chef.reload
    assert_match "Rodrigo Guerrero 2", @chef.chefname
    assert_match "rodrigoguerrero2@example.com", @chef.email
  end
  
  test "redirect edit by non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "fail"
    updated_email = "fail@example.com"
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "Rodrigo", @chef.chefname
    assert_match "rodrigo@example.com", @chef.email
  end
end
