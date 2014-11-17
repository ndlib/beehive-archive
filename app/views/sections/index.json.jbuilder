json.set! :sections do
  json.array! @sections do | section |

    json.title section.title
    json.image section.image

  end
end
