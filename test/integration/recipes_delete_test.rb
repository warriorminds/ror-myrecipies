require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
     @chef = Chef.create!(chefname: "Rodrigo", email: "rodrigo@example.com", password: "password", password_confirmation: "password")
     @recipe = Recipe.create!(name: "Recipe test number 1", description: "this is the first test recipe", chef: @chef)
  end
  
  test "successfully delete a recipe" do 
    get recipe_path(@recipe) #show route
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
    assert_difference 'Recipe.count', -1 do 
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end
end
