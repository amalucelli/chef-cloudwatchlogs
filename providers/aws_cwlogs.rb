#
# Cookbook Name:: aws-cloudwatchlogs
# Providers:: aws_cwlogs
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

provides :aws_cwlogs if respond_to?(:provides)
use_inline_resources if defined?(use_inline_resources)

action :add do
   service 'awslogs' do
      action :nothing
   end
   Chef::Log.debug "Adding configuration for #{new_resource.name}"
   template ::File.join(node['aws_cwlogs']['path'], 'etc/config', "#{new_resource.name}.conf") do
      owner 'root'
      mode 00600
      source 'template.conf.erb'
      variables ({
         logName: new_resource.name,
         logConfig: new_resource.log
      })
      cookbook new_resource.cookbook
      notifies :restart, 'service[awslogs]', :delayed
   end
end

action :remove do
   service 'awslogs' do
      action :nothing
   end
   conf_path = ::File.join(node['aws_cwlogs']['path'], 'etc/config')
   Chef::Log.debug "Removing #{new_resource.name} from #{conf_path}"
   file ::File.join(node['aws_cwlogs']['path'], 'etc/config', "#{new_resource.name}.conf") do
      action :delete
      notifies :restart, 'service[awslogs]', :delayed
   end
end
