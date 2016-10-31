#
# Cookbook Name:: aws-cloudwatchlogs
# Recipe:: install
#
# Copyright 2016, Alexandre Malucelli, All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# create base directory of agent even if it isn't installed yet
directory "#{node['aws-cwlogs']['path']}/etc" do
  recursive true
end

template "#{node['aws-cwlogs']['path']}/etc/aws.conf" do
   source 'aws.conf.erb'
   owner 'root'
   group 'root'
   mode 0600
   variables ({
      :awsRegion => node['aws-cwlogs']['region'],
      :awsAccessKey => node['aws-cwlogs']['aws_access_key_id'],
      :awsSecretKey => node['aws-cwlogs']['aws_secret_access_key']
   })
end

template '/tmp/awslogs.cfg' do
   source 'awslogs.conf.erb'
   owner 'root'
   group 'root'
   mode 0644
   variables ({
      :logFiles => node['aws-cwlogs']['log_files']
   })
end

# download setup script that will install aws cloudwatch logs agent
remote_file "#{node['aws-cwlogs']['path']}/awslogs-agent-setup.py" do
   source 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py'
   owner 'root'
   group 'root'
   mode 0755
end

# install aws cloudwatch logs agent
execute 'Install CloudWatch Logs Agent' do
   command "#{node['aws-cwlogs']['path']}/awslogs-agent-setup.py -n -r #{node['aws-cwlogs']['region']} -c /tmp/awslogs.cfg"
   not_if { system 'pgrep -f awslogs' }
end

# restart the agent service in the end to ensure that
# the agent will run with the custom configurations
service 'awslogs' do
   action [:enable, :restart]
end
