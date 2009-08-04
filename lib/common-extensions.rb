
Dir.glob(File.join(File.dirname(__FILE__), 'common-extensions', '**', '*')).each do |file|
  require file
end
