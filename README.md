# EndpointActivityFramework

## Installation
You can set up the application with `bin/setup`

## Usage

You may run the program with `ruby lib/endpoint_activity_framework.rb` and append any required arguments as such:

`ruby lib/endpoint_activity_framework.rb new_file ./test_file.txt`

The Framework uses the Thor gem to set up a cli for interacting with the endpoint.

You can list documented commands and their arguments with `ruby lib/endpoint_activity_framework.rb --help`

This framework is currently compatible with linux and macos systems. All activity is logged in the project root as JSON in 'activity_log.log'

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
