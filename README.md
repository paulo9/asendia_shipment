# AsendiaShipment

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/asendia_shipment`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'asendia_shipment'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install asendia_shipment

## Usage

First step for Asendia Shipment usage is get your ticket auth:

    AsendiaShipment::Requester.new.request_ticket_auth(user, pass)

Second ster is create your shipment
    create a shipment structure like this:

    shipment = {
      ticket: "#{TICKET_AUTH}",
      mode_of_transport: "ACSS",
      order_number: "ORD0000005",
      sender_code: "#{SENDER_CODE}",
      shipment_type: "OUTB",
      terms_of_delivery: "DDP",
      shipment_identifier: "SHIP005",
      ship_date: "2018-06-20T17:12:47",
      parcel_identifier: "PRCID005",
      type_of_goods: "Goods",
      type_of_package: "Small packet",
      currency: "EUR",
      value: "110",
      weight: "1.1",
      shipping_address: {
        address_1: "VIALE DI FOCENE 153",
        address_type: "Receiver",
        cell_phone: "+41123456780",
        city: " FIUMICINO",
        contact: "Thomas Baer",
        email: "tbaer@yahoo.ch",
        iso_country: "IT",
        name: "FEDERICO BERGO",
        phone: "+41123456789",
        zip_code: "00054"
      },
      attributes: [
        {
          code: "OriginSub",
          value: "NL"
        },
        {
          code: "CRMID",
          value: "NL16090001",
        },
        {
          code: "Product",
          value: "FTG",
        },
        {
          code: "Service",
          value: "MBD",
        },
        {
          code: "AdditionalService",
          value: "",
        },
        {
          code: "Format",
          value: "B",
        },
      ],
      parcel: {
        items: [
          {
            country_of_origin: "NL",
            currency: "EUR",
            description: "Blue Watch",
            harmonization_code: "910310",
            product_number: "WBLUE1234",
            quantity_shipped: "2",
            unit_of_measure: "EA",
            unit_price: "10",
            unit_weight: "0.1",
            volume: "0",
            weight: "0.2"
          },
          {
            country_of_origin: "NL",
            currency: "EUR",
            description: "Blue Watch",
            harmonization_code: "910310",
            product_number: "WBLUE1234",
            quantity_shipped: "3",
            unit_of_measure: "EA",
            unit_price: "30",
            unit_weight: "0.3",
            volume: "0",
            weight: "0.9"
          }
        ]
      }
    }

  Expected response
    {:success=>true, :track_code=>"LS928037019CH", :pdf_encoded=>"base64data"}

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/asendia_shipment. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AsendiaShipment project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/asendia_shipment/blob/master/CODE_OF_CONDUCT.md).
