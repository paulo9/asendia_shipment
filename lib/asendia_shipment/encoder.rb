module Encoder
  def encode_auth_xml(user,pass)
    xml = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:dat='http://centiro.com/facade/shared/1/0/datacontract' xmlns:ser='http://centiro.com/facade/shared/1/0/servicecontract' xmlns:cen='http://schemas.datacontract.org/2004/07/Centiro.Facade.Common.Operations.Authenticate'>
             <soapenv:Header>
                <dat:MessageId>?</dat:MessageId>
             </soapenv:Header>
             <soapenv:Body>
                <ser:AuthenticateRequest>
                   <cen:Password>#{pass}</cen:Password>
                   <cen:UserName>#{user}</cen:UserName>
                </ser:AuthenticateRequest>
             </soapenv:Body>
          </soapenv:Envelope>"

    xml
  end

  def encode_shipment(shipment)
    encoded_hash = {
      AddAndPrintShipmentRequest:{
        LabelType: "PDF" ,
        Currency: shipment[:currency],
        ModeOfTransport: shipment[:mode_of_transport],
        OrderNumber: shipment[:order_number],
        Attributes: {
          Attribute: []
        },
        Parcels: {
          Parcel: {
            Height: shipment[:parcel][:height],
            Length: shipment[:parcel][:lenght],
            SenderCode: shipment[:parcel][:sender_code],
            ShipDate: shipment[:parcel][:ship_date],
            ShipmentIdentifier: shipment[:parcel][:shipment_identifier],
            ShipmentType: shipment[:parcel][:shipment_type],
            Value: shipment[:parcel][:value],
            TermsOfDelivery: shipment[:parcel][:terms_of_delivery],
            Weight: shipment[:parcel][:weight],
            OrderLines: {
              OrderLine: []
            }
          }
        }
      }
    }


    set_address(encoded_hash, shipment[:shipping_address])
    set_attributes(encoded_hash, shipment[:attributes])
    set_order_lines(encoded_hash, shipment[:parcel][:items])

    encoded_hash
  end

  def set_address(encoded_hash, address)
    shipment_address = {
      Shipment: {
        Addresses: {
          Address: {
            Address1: address[:address_1],
            AddressType: address[:address_type],
            CellPhone: address[:cell_phone],
            City: address[:city],
            Contact: address[:contact],
            Email: address[:email],
            ISOCountry: address[:iso_country],
            Name: address[:name],
            Phone: address[:phone],
            ZipCode: address[:zip_code]
          }
        }
      }
    }

    encoded_hash[:AddAndPrintShipmentRequest].merge!(shipment_address)

    encoded_hash
  end

  def set_attributes(encoded_hash, attributes)
    attributes.each do |attribute|
      encoded_hash[:AddAndPrintShipmentRequest][:Attributes][:Attribute] << {Code: attribute[:code], Value: attribute[:value]}
    end

    encoded_hash
  end

  def set_order_lines(encoded_hash, items)
    items.each do |item|
      line = {
        CountryOfOrigin: item[:country_of_origin],
        Currency: item[:currency],
        Description1: item[:description],
        HarmonizationCode: item[:harmonization_code],
        ProductNumber: item[:product_number],
        QuantityShipped: item[:quantity_shipped],
        UnitOfMeasure: item[:unit_of_measure],
        UnitPrice: item[:unit_price],
        UnitWeight: item[:unit_weight],
        Volume: item[:volume],
        Weight: item[:weight]
      }
      encoded_hash[:AddAndPrintShipmentRequest][:Parcels][:Parcel][:OrderLines][:OrderLine] << line
    end

    encoded_hash
  end

end
