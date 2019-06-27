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

  def encode_shipment
    shipment = {
      add_and_print_shipment_request:{
        label_type: "PDF" ,
        currency: "",
        mode_of_transport: "ACSS",
        order_number: "",
        parcels: {
          parcel: {
            height: "",
            lenght: "",
            order_lines: {
              order_line: {
                country_origin: "",
                currency: "",
                description_1: "",
                harmonization_code: "",
                product_number: "",
                quantity_shipped: "",
                unit_of_measure: "",
                unit_price: "",
                unit_weight: "",
                volume: "",
                weight: ""
              }
            },
            parcel_identifier: "",
            type_of_goods: "",
            type_of_package: "",
            value: "",
            weight: "",
            width: "",
          }
        },
        sender_code: "",
        ship_date: "",
        shipment_identifier: "",
        shipment_type: "",
        terms_of_delivery: "",
        value: "",
        weight: ""
      }
    }


    set_address(shipment)
    set_attributes(shipment)
    shipment
  end

  def set_address(shipment)
    shipment_address = {
      shipment: {
        addresses: {
          address: {
            address_1: "",
            address_type: "",
            cell_phone: "",
            city: "",
            contact: "",
            email: "",
            iso_country: "",
            phone: "",
            zip_code: ""
          }
        }
      }
    }

    shipment[:add_and_print_shipment_request].merge!(shipment_address)

    shipment
  end

  def set_attributes(shipment)
    shipment[:add_and_print_shipment_request].merge!({attributes: []})

    shipment[:add_and_print_shipment_request][:attributes] << { attribute: {code: "OriginSub", value: "NL"}}
    shipment[:add_and_print_shipment_request][:attributes] << { attribute: {code: "CRMIMD", value: ""}}
    shipment[:add_and_print_shipment_request][:attributes] << { attribute: {code: "Product", value: ""}}
    shipment[:add_and_print_shipment_request][:attributes] << { attribute: {code: "Service", value: ""}}
    shipment[:add_and_print_shipment_request][:attributes] << { attribute: {code: "AdditionalService", value: ""}}
    shipment[:add_and_print_shipment_request][:attributes] << { attribute: {code: "Format", value: ""}}

    shipment
  end

end
