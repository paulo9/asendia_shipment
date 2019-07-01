require "test_helper"

class AsendiaShipmentTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::AsendiaShipment::VERSION
    # assert_equal "bla", ::AsendiaShipment::Asendia::Requester.new.request_label(1)
    # assert_equal 1, ::AsendiaShipment::Asendia::Requester.new.request_ticket_auth('wsGocaseIntBV@asendia.nll','GoCase2211!')
    shipment = {
      ticket: "ERjXNo89J7pamvMnnAk0eY64VnpwCBvwEVuu8p1kjg2ZJ7aL4vbpNiQGLS7Malv%2f2Pj6DeDcQWqbZFRrt6zwQ08mhii5fiIdXj%2fatzDzwxZ%2bHCAXQXnzP3f2wwDoluUQtxaoznlNsCc03eQgh7EJxtCf87g%2bhN8n",
      mode_of_transport: "ACSS",
      order_number: "ORD0000005",
      currency: "EUR",
      shipping_address: {
        address_1: "Zeughausgasse 9",
        address_type: "Receiver",
        cell_phone: "+41123456780",
        city: "Bern",
        contact: "Thomas Baer",
        email: "tbaer@yahoo.ch",
        ISO_country: "CH",
        name: "Baer Hotel",
        phone: "+41123456789",
        zip_code: "3011"
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
        sender_code: "NL16090001",
        ship_date: "2018-06-20T17:12:47",
        shipment_identigier: "SHIP005",
        shipment_type: "OUTB",
        terms_of_delivery: "DDP",
        value: "110",
        weight: "1.1",
        height: "0",
        lenght: "0",
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
    assert_equal "bla", AsendiaShipment::Requester.new.request_label(shipment)
  end

end