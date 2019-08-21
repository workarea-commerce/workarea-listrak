json.results @events do |event|
  json.label event.name
  json.value event.id
end
