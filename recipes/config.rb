#
# Cookbook Name:: aws-cloudwatchlogs
# Recipe:: config
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

# always keep aws.conf updated
template "#{node['aws_cwlogs']['path']}/etc/aws.conf" do
   source 'aws.conf.erb'
   owner 'root'
   group 'root'
   mode 0600
   variables ({
      :awsRegion => node['aws_cwlogs']['region'],
      :awsAccessKey => node['aws_cwlogs']['aws_access_key_id'],
      :awsSecretKey => node['aws_cwlogs']['aws_secret_access_key']
   })
end

# always keep logging.conf updated
template "#{node['aws_cwlogs']['path']}/etc/logging.conf" do
   source 'logging.conf.erb'
   owner 'root'
   group 'root'
   mode 0600
end

# always generate awslogs.conf based on default
# attributes related to log files
template "#{node['aws_cwlogs']['path']}/etc/awslogs.conf" do
   source 'awslogs.conf.erb'
   owner 'root'
   group 'root'
   mode 0644
end

# always restart aws cloudwatch logs agent
# after the configuration files were updated
service 'awslogs' do
   action [:enable, :restart]
   supports :restart => true, :status => true, :start => true, :stop => true
   subscribes :restart, "template [#{node['aws_cwlogs']['path']}/etc/awslogs.conf]", :delayed
end
