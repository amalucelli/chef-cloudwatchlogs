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

remote_file "#{node['aws-cwlogs']['path']}/awslogs-agent-setup.py" do
   source 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py'
   owner 'root'
   group 'root'
   mode 0755
end

execute 'Install CloudWatch Logs Agent' do
   command "#{node['aws-cwlogs']['path']}/awslogs-agent-setup.py -n -r #{node['aws-cwlogs']['region']} -c /tmp/awslogs.cfg"
   not_if { system 'pgrep -f awslogs' }
end

service 'awslogs' do
   action [:enable, :restart]
end
