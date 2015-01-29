json.id exhibit.id
json.title exhibit.title
json.description exhibit.description
json.set! :links do
  json.set! :showcases do
    json.array! exhibit.showcases do | showcase |
      json.partial! 'showcases/showcase', showcase: showcase
    end
  end
  json.items ExhibitItemsJsonFormatter.new(exhibit).to_hash[:items]
end
