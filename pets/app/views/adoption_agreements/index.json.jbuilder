json.array!(@adoption_agreements) do |adoption_agreement|
  json.extract! adoption_agreement, :id
  json.url adoption_agreement_url(adoption_agreement, format: :json)
end
