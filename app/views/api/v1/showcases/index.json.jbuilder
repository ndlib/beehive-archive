json.array! @showcases do |showcase|
  json.partial! 'showcase', showcase: showcase
end
