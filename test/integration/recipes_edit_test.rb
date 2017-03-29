require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
     @chef = Chef.create!(chefname: "Rodrigo", email: "rodrigo@example.com")
     @recipe = Recipe.create!(name: "Recipe test number 1", description: "this is the first test recipe", chef: @chef)
  end
  
  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: "", description: "some description" }} # update recipe
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "successfully edit a recipe" do
    
  end
end
