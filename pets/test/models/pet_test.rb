require 'test_helper'

class PetTest < ActiveSupport::TestCase
  test "attributes may not be empty" do
    pet = Pet.new
    assert pet.invalid?
    assert pet.errors[:name].any?
    assert pet.errors[:breed].any?
    assert pet.errors[:description].any?
    assert pet.errors[:age].any?
    assert pet.errors[:image_url].any?
    
  end
  
  test "age must be greater than or equal to zero" do
    
    pet = Pet.new(name: "test", 
                  breed: "test",
                  description: 'test',
                  image_url: 'test.jpg')
    
    pet.age = -1
    assert pet.invalid?
    assert_equal ["must be greater than or equal to 0"], pet.errors[:age]
    
    pet.age = 0
    assert pet.valid?
    
    pet.age = 1
    assert pet.valid?
  end
  
  # Direct port of the test used in the depot app
  test "image url" do
    
    pet = Pet.new(name: "test", 
                  breed: "test",
                  description: 'test',
                  age: 1)
    
    ok = %w{ fred.gif fred.jpg fred.png FRED.gif FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
    bad = %w{ fred.doc fred.git/more fred.gif.more }
    ok.each do |name|
      pet.image_url = name
      assert pet.valid?
    end
    bad.each do |name|
      pet.image_url = name
      assert pet.invalid?
    end
  end
  
end
