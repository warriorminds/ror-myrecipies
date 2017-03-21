require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
     @chef = Chef.create!(chefname: "Rodrigo", email: "rodrigo@example.com")
     @recipe = Recipe.create!(name: "Recipe test number 1", description: "this is the first test recipe", chef: @chef)
     @recipe2 = @chef.recipes.build(name: "Recipe test number 2", description: "this is the second test recipe")
     @recipe2.save
  end
  
  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
end
