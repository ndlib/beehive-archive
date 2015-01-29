json.set! :sections do
  json.array! @sections.sections do | section |
    json.partial! 'sections/section', section: section
  end
end
