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
    path = File.join(File.dirname(File.dirname(File.absolute_path(__FILE__))),'assets/print_request.xml')
    encoded_xml = Nokogiri::XML(File.read(path))

    encoded_xml.xpath('//ns3:AuthenticationTicket')[0].content = shipment[:ticket]
    encoded_xml.xpath('//ns2:Parcel//ns2:ParcelIdentifier')[0].content = shipment[:parcel_identifier]
    encoded_xml.xpath('//ns2:Parcel//ns2:TypeOfGoods')[0].content = shipment[:type_of_goods]
    encoded_xml.xpath('//ns2:Parcel//ns2:TypeOfPackage')[0].content = shipment[:type_of_package]
    encoded_xml.xpath('//ns1:Shipment//ns2:Parcel//ns2:Value')[0].content = 110
    encoded_xml.xpath('//ns1:Shipment//ns2:Parcel//ns2:Weight')[0].content = 1.1
    encoded_xml.xpath('//ns2:Parcel//ns2:Width')[0].content = 0

    set_address(encoded_xml, shipment[:shipping_address])
    set_attributes(encoded_xml, shipment[:attributes])
    set_order_lines(encoded_xml, shipment[:parcel][:items])
    set_shipment_attributes(encoded_xml, shipment)
    encoded_xml
  end

  def set_address(xml, address)
    shipment_address = "<ns2:Address>
                          <ns2:Address1>#{address[:address_1]}</ns2:Address1>
                          <ns2:Address2>#{address[:address_2]}</ns2:Address2>
                          <ns2:Address3>#{address[:address_3]}</ns2:Address3>
                          <ns2:AddressType>#{address[:address_type]}</ns2:AddressType>
                          <ns2:CellPhone>#{address[:cell_phone]}</ns2:CellPhone>
                          <ns2:City>#{address[:city]}</ns2:City>
                          <ns2:Contact>#{address[:contact]}</ns2:Contact>
                          <ns2:Email>#{address[:email]}</ns2:Email>
                          <ns2:ISOCountry>#{address[:iso_country]}</ns2:ISOCountry>
                          <ns2:Name>#{address[:name]}</ns2:Name>
                          <ns2:Phone>#{address[:phone]}</ns2:Phone>
                          <ns2:ZipCode>#{address[:zip_code]}</ns2:ZipCode>
                        </ns2:Address>"

    xml.at('//ns1:AddAndPrintShipmentRequest').at('//ns1:Shipment').at('//ns2:Addresses').add_child(shipment_address)

    xml
  end

  def set_attributes(xml, attributes)
    attributes.each do |attribute|
      attribute_children =  "<ns2:Attribute>
                              <ns2:Code>#{attribute[:code]}</ns2:Code>
                              <ns2:Value>#{attribute[:value]}</ns2:Value>
                            </ns2:Attribute>"

      xml.at('//ns1:AddAndPrintShipmentRequest').at('//ns2:Attributes').add_child(attribute_children)
    end

    xml
  end

  def set_order_lines(xml, items)
    items.each_with_index do |item, i|
      line = "<ns2:OrderLine>
                <ns2:CountryOfOrigin>#{item[:country_of_origin]}</ns2:CountryOfOrigin>
                <ns2:Currency>#{item[:currency]}</ns2:Currency>
                <ns2:Description1>#{item[:description]}</ns2:Description1>
                <ns2:HarmonizationCode>#{item[:harmonization_code]}</ns2:HarmonizationCode>
                <ns2:OrderLineNumber>#{ i + 1 }</ns2:OrderLineNumber>
                <ns2:ProductNumber>#{item[:product_number]}</ns2:ProductNumber>
                <ns2:QuantityShipped>#{item[:quantity_shipped]}</ns2:QuantityShipped>
                <ns2:UnitOfMeasure>#{item[:unit_of_measure]}</ns2:UnitOfMeasure>
                <ns2:UnitPrice>#{item[:unit_price]}</ns2:UnitPrice>
                <ns2:UnitWeight>#{item[:unit_weight]}</ns2:UnitWeight>
                <ns2:Volume>#{item[:volume]}</ns2:Volume>
                <ns2:Weight>#{item[:weight]}</ns2:Weight>
              </ns2:OrderLine>"

      xml.at('//ns2:OrderLines').add_child(line)
    end

    xml
  end

  def set_shipment_attributes(xml, shipment)
    xml.xpath('//ns1:Shipment//ns2:Currency')[0].content = shipment[:currency]
    xml.xpath('//ns1:Shipment//ns2:ModeOfTransport')[0].content = shipment[:mode_of_transport]
    xml.xpath('//ns1:Shipment//ns2:OrderNumber')[0].content = shipment[:order_number]
    xml.xpath('//ns1:Shipment//ns2:SenderCode')[0].content = shipment[:sender_code]
    xml.xpath('//ns1:Shipment//ns2:ShipDate')[0].content = shipment[:ship_date]
    xml.xpath('//ns1:Shipment//ns2:ShipmentIdentifier')[0].content = shipment[:shipment_identifier]
    xml.xpath('//ns1:Shipment//ns2:ShipmentType')[0].content = shipment[:shipment_type]
    xml.xpath('//ns1:Shipment//ns2:TermsOfDelivery')[0].content = shipment[:terms_of_delivery]
    xml.xpath('//ns1:Shipment//ns2:Value')[0].content = shipment[:value]
    xml.xpath('//ns1:Shipment//ns2:Weight')[0].content = shipment[:weight]

    xml.at('//ns1:Shipment').add_child("<ns2:Value>#{shipment[:value]}</ns2:Value><ns2:Weight>#{shipment[:weight]}</ns2:Weight>")

    xml
  end

end
