%w(tmp/restart.txt).each do |path|
  Spring.watch path
end
