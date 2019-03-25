%w[spring-commands-cucumber spring-commands-rspec].each do |lib|
  begin
    require lib
  rescue LoadError
    warn "#{__FILE__}: #{$!.message}"
  end
end
