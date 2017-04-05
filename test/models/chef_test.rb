require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "rodrigo", email: "rodrigo@example.com", password: "password", password_confirmation: "password")
  end
  
  test "should be valid" do
    assert @chef.valid?
  end
  
  test "Chefname should be present" do
    @chef.chefname = " ";
    assert_not @chef.valid?
  end
  
  test "Chefname should be less than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end
  
  test "Email should be present" do
    @chef.email = "";
    assert_not @chef.valid?
  end
  
  test "Email should not be too long" do
    @chef.email = "a" * 256
    assert_not @chef.valid?
  end
  
  test "Email should accept correct format" do
    valid_emails = %w[user@example.com rodrigo@gmail.com R.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |email|
      @chef.email = email
      assert @chef.valid?, "#{ email.inspect } should be valid"
    end
  end
  
  test "Should reject invalid email addresses" do
    invalid_emails = %w[rodrigo@example rodrigo@example,com rodrigo.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |email|
      @chef.email = email
      assert_not @chef.valid?, "#{ email.inspect } should be invalid"
    end
  end
  
  test "Email should be unique and cas insensitive" do
    duplicate_chef = @chef.dup # copy chef
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  
  test "emails should be lowercase before hitting database" do
    mixed_email = "JoHn@ExAmPle.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end
  
  test "password should be present" do
    @chef.password = @chef.password_confirmation = ""
    assert_not @chef.valid?
  end
  
  test "password should be at least 5 characters" do
    @chef.password = @chef.password_confirmation = "a" * 4
    assert_not @chef.valid?
  end
end