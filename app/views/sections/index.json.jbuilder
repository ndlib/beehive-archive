json.set! :sections do
  json.array! @sections.sections do | section |
    json.partial! 'section', section: section
  end
end
