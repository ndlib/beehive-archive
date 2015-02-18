json.set! '@context', 'http://schema.org'
json.set! '@type', 'CreativeWork'
json.set! '@id', section.id
json.name section.name
json.description section.description
json.set! 'hasPart/item', section.item
json.set! 'isPartOf/showcase', section.showcase
