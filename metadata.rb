name 'aws-cloudwatchlogs'
maintainer 'Alexandre Guimarães Malucelli'
maintainer_email 'alexandre@malucelli.net'
license 'Apache-2.0'
description 'Install and Configure AWS CloudWatch Logs Agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.6'
source_url 'https://github.com/amalucelli/chef-cloudwatchlogs' if respond_to? :source_url
issues_url 'https://github.com/amalucelli/chef-cloudwatchlogs/issues' if respond_to? :issues_url

%w(
   ubuntu
).each do |os|
  supports os
end

chef_version '>= 12.1'
