# AWS CloudWatch Logs Cookbook
[![Runtime][runtime-badge]][chef-cloudwatchlogs-runtime-url]
[![License][license-badge]][chef-cloudwatchlogs-license-url]

Unofficial Chef Cookbook that installs [AWS CloudWatch Logs][aws-cloudwatch-url]<sup>™</sup>
Agent and deploy it's configurations automatically.

## Usage

Add this cookbook to your base recipe:
```ruby
cookbook 'aws-cloudwatchlogs', '~> 1.1.3'
```

You need to configure the following node attributes via an `environment` or `role`:
```ruby
default_attributes(
   'aws-cwlogs' => {
      'region' => 'your_aws_region',
      'aws_access_key_id' => 'your_aws_access_key',
      'aws_secret_access_key' => 'your_aws_secret_key',
      'log_files' => {
         '/var/log/syslog' => {
            'datetime_format' => '%b %d %H:%M:%S',
            'file' => '/var/log/syslog',
            'buffer_duration' => '5000',
            'log_stream_name' => '{instance_id}',
            'initial_position' => 'start_of_file',
            'log_group_name' => '/var/log/syslog'
         }
      }
   }
)
```

Or you can also configure by declaring it in another cookbook at a higher precedence level:
```ruby
default['aws-cwlogs']['region'] = 'your_aws_region'
default['aws-cwlogs']['aws_access_key_id'] = 'your_aws_access_key'
default['aws-cwlogs']['aws_secret_access_key'] = 'your_aws_secret_key'
default['aws-cwlogs']['log_files']['/var/log/syslog'] = {
   'datetime_format' => '%b %d %H:%M:%S',
   'file' => '/var/log/syslog',
   'buffer_duration' => '5000',
   'log_stream_name' => '{instance_id}',
   'initial_position' => 'start_of_file',
   'log_group_name' => '/var/log/syslog'
}
```

**Remember**: You can configure as many logs as you need with `log_files` attribute.

**Note**: We are not making use of `data_bags` for AWS Credentials in this recipe at this time.

## Example

Those attributes used before will generate the AWS CloudWatch Logs configuration below:

```ini
[/var/log/syslog]
datetime_format = %b %d %H:%M:%S
file = /var/log/syslog
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/syslog
```

For more deployment details about AWS CloudWatch Logs, please visit the [AWS CloudWatch Logs Documentation](https://aws.amazon.com/documentation/cloudwatch).

## Requirements

### Platform

* Ubuntu 14.04

## Attributes

See `attributes/default.rb` for default values.

## Recipes

### default

This recipe will check if all necessary requirements being met, and after
that will call `configure` and `install` recipe.

### configure

This recipe will prepare and configure all files required by AWS CloudWatch Logs.

### install

This recipe will install AWS CloudWatch Logs Agent.

## Changes

See `CHANGELOG.md` for more details.

## License and Author

See `LICENSE` for more details.

## Trademark

Amazon Web Services and AWS are trademarks of Amazon.com, Inc. or
its affiliates in the United States and/or other countries.

   [aws-cloudwatch-url]: https://aws.amazon.com/cloudwatch/
   [chef-cloudwatchlogs-license-url]: https://github.com/amalucelli/chef-cloudwatchlogs/blob/markdown/LICENSE
   [chef-cloudwatchlogs-runtime-url]: https://github.com/amalucelli/chef-cloudwatchlogs
   [license-badge]: https://img.shields.io/badge/license-apache-757575.svg?style=flat-square
   [runtime-badge]: https://img.shields.io/badge/runtime-ruby-orange.svg?style=flat-square
