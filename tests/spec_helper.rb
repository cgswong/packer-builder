require 'net/ssh'
require 'serverspec'

set :backend, :ssh

set :path, '/usr/local/sbin:/usr/sbin:/sbin:$PATH'

options = {}
ssh_config = `vagrant ssh-config #{ENV['HOST']}`
ssh_config.each_line do |line|
  if match = /HostName (.*)/.match(line)
    options[:host_name] = match[1]
  elsif match = /User (.*)/.match(line)
    options[:user] = match[1]
  elsif match = /IdentityFile (.*)/.match(line)
    options[:keys] = [match[1].gsub(/"/, '')]
  elsif match = /Port (.*)/.match(line)
    options[:port] = match[1]
  end
end

set :host, options[:host_name]
set :ssh_options, options
