previous_ignore = Workarea::Cache::RackCacheKey.query_string_ignore

Workarea::Cache::RackCacheKey.query_string_ignore = proc do |key, value|
  if previous_ignore.blank?
    key =~ /\Atrk_/
  else
    previous_ignore.call(key, value) && key =~ /\Atrk_/
  end
end
