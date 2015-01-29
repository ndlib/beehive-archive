json.id showcase.id
json.title showcase.title
json.description showcase.description
json.set! :links do
  json.set! :sections do
    json.array! showcase.sections do | section |
      json.partial! 'sections/section', section: section
    end
  end
end
