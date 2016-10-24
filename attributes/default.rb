#
# Cookbook Name:: aws-cloudwatchlogs
# Attributes:: default
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

# AWS Credentials
default['aws-cwlogs']['region'] = nil
default['aws-cwlogs']['aws_access_key_id'] = nil
default['aws-cwlogs']['aws_secret_access_key'] = nil

# AWS CloudWatch Logs
default['aws-cwlogs']['path'] = '/var/awslogs'
default['aws-cwlogs']['log_files'] = nil
