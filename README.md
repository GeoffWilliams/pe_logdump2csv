# PeLogdump2csv

Turn JSON dumps from PE into CSV!

Give a monster directory of files, eg:
```
$ ls
total 377M
   0 127.0.0.1-10_28_16_09:05.json
 68K 127.0.0.1-10_28_16_09:10.json
 68K 127.0.0.1-10_28_16_09:15.json
 68K 127.0.0.1-10_28_16_09:20.json
 68K 127.0.0.1-10_28_16_09:25.json
 76K 127.0.0.1-10_28_16_09:30.json
 68K 127.0.0.1-10_28_16_09:35.json
 68K 127.0.0.1-10_28_16_09:40.json

...
```

Scan each file for specific JSON values and output a cohesive set of values to STDOUT:
```csv
timestamp,pe-jruby-metrics.status.experimental.metrics.average-borrow-time,pe-jruby-metrics.status.experimental.metrics.num-free-jrubies,code-manager-service.status.file_sync
10_28_16_09:10,1518,1,enabled
10_28_16_09:15,1790,4,enabled
10_28_16_09:20,1422,0,enabled
10_28_16_09:25,1682,4,enabled
10_28_16_09:30,1464,0,enabled
```

This way, data can be loaded into Excel to draw graphs


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pe_logdump2csv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pe_logdump2csv



## Usage
1. `cd` into a directory of log files
2. `pe_logdump2csv csv --pick xxx,yyy,zzz`
  * This will output CSV on the commandline for each of the listed JSON keys
  * Redirect output to a file and it can then be opened in Excel
  * A header line will be printed, the timestamp is obtained from the filename
  * Files must be called `SOMETHING-date.json` - we throw away the `SOMETHING` and the `.json` to obtain the timestamp
  * You can pick as many fields as you like, just delimit them by commas with no spaces
  * See below for how to figure out field names

## Field names
Field names are computed buy combining JSON keys with periods, eg given the following JSON, if you were interested in the value of `file_sync`, you would pass `code-manager-service.status.file_sync` to `--pick`
```
{
    "code-manager-service": {
        "detail_level": "debug",
        "service_status_version": 1,
        "service_version": "1.4.2",
        "state": "running",
        "status": {
            "file_sync": "enabled",
            "services": {
                "file-sync-storage": "running"
```

## Example commands

```shell
pe_logdump2csv csv --pick pe-jruby-metrics.status.experimental.metrics.average-borrow-time,pe-jruby-metrics.status.experimental.metrics.num-free-jrubies,code-manager-service.status.file_sync
```

Collect:

* average-borrow-time
* num-free-jrubies
* file sync status


Output:
```csv
timestamp,pe-jruby-metrics.status.experimental.metrics.average-borrow-time,pe-jruby-metrics.status.experimental.metrics.num-free-jrubies,code-manager-service.status.file_sync
10_28_16_09:10,1518,1,enabled
10_28_16_09:15,1790,4,enabled
10_28_16_09:20,1422,0,enabled
10_28_16_09:25,1682,4,enabled
10_28_16_09:30,1464,0,enabled
10_28_16_09:35,1253,2,enabled
10_28_16_09:40,1259,2,enabled
```



## Obtaining logs
TODO: PR gratefully accepted :)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/GeoffWilliams/pe_logdump2csv.


## License

The gem is available as open source under the terms of the [Apache 2](https://www.apache.org/licenses/LICENSE-2.0).
