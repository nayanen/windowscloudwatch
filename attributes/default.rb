default['cwlogs']['region'] = 'us-east-1'
default['cwlogs']['state_file_dir'] = '/var/awslogs/state'
default['cwlogs']['state_file_name'] = 'agent-state'
default['cwlogs']['attempt_upgrade'] = true
default['cwlogs']['python_bin'] = ''
default['cwlogs']['ca_bundle'] = ''
default['cwlogs']['installation_file_source'] = 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py'
default['cwlogs']['flows'] = ''

# -- Installs python3.x
default['poise-python']['install_python2'] = false
default['poise-python']['install_python3'] = true
