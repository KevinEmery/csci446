json.array!(@pets) do |pet|
  json.extract! pet, :id, :name, :description, :breed, :age, :image_url
  json.url pet_url(pet, format: :json)
end
