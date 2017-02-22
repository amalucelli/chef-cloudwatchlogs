Changes
=======

# 1.1.6 / 2017-02-22
* Removed the requirement for `aws_access_key_id` and `aws_secret_access_key` attributes values.

# 1.1.5 / 2017-01-31
* Implementing a better way to handle AWS CloudWatch Logs configurations,
  now each log has a configuration file that is provisioned via Chef Resources.

# 1.1.4 / 2016-11-07
* Implementing `logging_config_file` configuration, that overrides the default
  logging configuration to a WARNING value.

# 1.1.3 / 2016-10-31
* Fixing `aws_access_key_id` and `aws_secret_access_key` attributes values.

# 1.1.2 / 2016-10-31

* Removing the `log_files` attribute.
* Implementing a better logic to handle if the agent is already installed.

# 1.1.1 / 2016-10-24

* Initial version of `aws-cloudwatchlogs` cookbook.
