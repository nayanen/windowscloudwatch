if node['ec2'].nil?
  log('Refusing to install CloudWatch Logs because this does not appear to be an EC2 instance.') { level :warn }
  return
end

if node['cwlogs']['logfiles'].nil?
  log("Refusing to install CloudWatch Logs because no logs have been configured. (node['cwlogs']['logfiles'] is nil)") { level :warn }
  return
end

case node['platform']
when 'debian', 'ubuntu', 'redhat', 'centos', 'fedora'
  include_recipe 'cloudwatch-logs::linux'
when 'amazon' && Gem::Version.new(node['platform_version']) >= Gem::Version.new('2014.09')
  include_recipe 'cloudwatch-logs::amazon'
when 'windows'
  include_recipe 'cloudwatch-logs::windows'
end
