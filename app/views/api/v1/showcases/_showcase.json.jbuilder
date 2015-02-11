json.set! '@context', 'http://schema.org'
json.set! '@type', 'CreativeWork'
json.set! '@id', showcase.id
json.name showcase.name
json.description showcase.description
json.set! 'hasPart/item', showcase.item
json.set! 'hasPart/sections', showcase.sections
json.set! 'isPartOf/exhibit', showcase.exhibit
