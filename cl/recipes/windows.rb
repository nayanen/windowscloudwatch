require 'open-uri'

# -- Installing python 3.x
python_runtime '3'

def get_instance_id
  instance_id = open('http://169.254.169.254/latest/meta-data/instance-id'){|f| f.gets}
  raise "Cannot find instance id!" unless instance_id
  Chef::Log.debug("Instance ID is #{instance_id}")
  instance_id
end

instance_id = get_instance_id

ssm_path = 'C:\Program Files\Amazon\SSM\Plugins\awsCloudWatch'

ssm_command = %Q[aws ssm send-command --document-name "AWS-ConfigureCloudWatch"  \
  --instance-ids #{instance_id} \
  --region #{node['cwlogs']['region']}]

python_path = 'C:\Python34'
pip_path    = "#{python_path}\\Scripts\\"

windows_path python_path do
  action :add
end

windows_path pip_path do
  action :add
end

execute 'awscli installation' do
  command 'pip install awscli'
end

template "#{ssm_path}\\AWS.EC2.Windows.CloudWatch.json" do
  source 'awscloudwatch.erb'
  variables ({
    logfiles: node['cwlogs']['logfiles'],
    flows:  node['cwlogs']['flows']
  })
end

execute 'ssm agent' do
  command ssm_command
  timeout 600
end

powershell_script 'ssm agent' do
  code 'Restart-Service AmazonSSMAgent'
  action :run
end
