json.array! @exhibits do |exhibit|
  json.partial! 'exhibit', exhibit: exhibit
end
