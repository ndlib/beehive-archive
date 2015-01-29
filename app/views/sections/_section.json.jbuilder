json.id section.id
json.title section.title
json.description section.description
json.image section.image
json.caption section.caption
json.order section.order
json.display_type SectionType.new(section).type
json.set! :links do
  json.items section.item_id ? section.item_id.to_s : nil
end
