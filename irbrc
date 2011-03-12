require 'rubygems'
require 'irb/completion'

load_failures = []
load_libs = {
  'wirble' => Proc.new { Wirble.init ; Wirble.colorize },
  'hirb' => Proc.new { Hirb::View.enable }
}

load_libs.each do |lib, config|
  begin
    require lib
    config.call unless config.nil?
  rescue LoadError
    load_failures << lib
  end
end

warn "irbrc warning: failed to load " + load_failures.join(', ') unless load_failures.empty?

