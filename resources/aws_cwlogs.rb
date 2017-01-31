#
# Cookbook Name:: aws-cloudwatchlogs
# Resources:: aws_cwlogs
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

resource_name :aws_cwlogs if respond_to?(:resource_name)
provides :aws_cwlogs if respond_to?(:provides)

actions :add, :remove
default_action :add if defined?(default_action)

attribute :name, :kind_of => String, :name_attribute => true
attribute :cookbook, :kind_of => String, :default => 'aws-cloudwatchlogs'
attribute :log, :kind_of => Hash, :required => true, :default => {}
