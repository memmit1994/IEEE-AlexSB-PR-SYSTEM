json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :number, :position, :field_company, :email
  json.url contact_url(contact, format: :json)
end
