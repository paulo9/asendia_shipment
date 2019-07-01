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
    # encoded_xml = Nokogiri::XML(File.read('print_request.xml'))
    # # Add Auth Ticket
    # encoded_xml.xpath('//ns3:AuthenticationTicket')[0].content = shipment[:ticket]
    # xml.xpath('ns2:Parcel//ns2:ParcelIdentifier')[0].content = attributes[:]
    # xml.xpath('ns2:Parcel//ns2:TypeOfGoods')[0].content = attributes[:]
    # xml.xpath('ns2:Parcel//ns2:TypeOfPackage')[0].content = attributes[:]
    # xml.xpath('ns2:Parcel//ns2:Value')[0].content = attributes[:]
    # xml.xpath('ns2:Parcel//ns2:Weight')[0].content = attributes[:]
    # xml.xpath('ns2:Parcel//ns2:Width')[0].content = attributes[:]
    # # # encoded_hash = {
    # # #   "ns1:AddAndPrintShipmentRequest":{
    # # #     "ns1:LabelType": "PDF" ,
    # # #     "ns2:Currency": shipment[:currency],
    # # #     "ns2:ModeOfTransport": shipment[:mode_of_transport],
    # # #     "ns2:OrderNumber": shipment[:order_number],
    # #   #     "ns2:Parcels": {
    # # #       "ns2:Parcel": {
    # # #         "ns2:Height": shipment[:parcel][:height],
    # # #         "ns2:Length": shipment[:parcel][:lenght],
    # # #         "ns2:SenderCode": shipment[:parcel][:sender_code],
    # # #         "ns2:ShipDate": shipment[:parcel][:ship_date],
    # # #         "ns2:ShipmentIdentifier": shipment[:parcel][:shipment_identifier],
    # # #         "ns2:ShipmentType": shipment[:parcel][:shipment_type],
    # # #         "ns2:Value": shipment[:parcel][:value],
    # # #         "ns2:TermsOfDelivery": shipment[:parcel][:terms_of_delivery],
    # # #         "ns2:Weight": shipment[:parcel][:weight],
    # # #         "ns2:OrderLines": {
    # # #           "ns2:OrderLine": []
    # # #         }
    # # #       }
    # # #     }
    # # #   }
    # # # }

    # set_address(encoded_xml, shipment[:shipping_address])
    # set_attributes(encoded_xml, shipment[:attributes])
    # set_parcel_attributes(encoded_xml, shipment[:parcel])
    # set_order_lines(encoded_hash, shipment[:parcel][:items])

    # encoded_hash
  end

  def set_address(xml, address)
    shipment_address = "<ns2:Address>
                          <ns2:Address1>#{address[:address_1]}</ns2:Address1>
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

  def set_parcel_attributes(xml, attributes)
    # xml.xpath('ns2:Parcel//ns2:ParcelIdentifier')[0].content = attributes[:]
    # xml.xpath('ns2:Parcel//ns2:TypeOfGoods')[0].content = attributes[:]
    # xml.xpath('ns2:Parcel//ns2:TypeOfPackage')[0].content = attributes[:]
    # xml.xpath('ns2:Parcel//ns2:Value')[0].content = attributes[:]
    # xml.xpath('ns2:Parcel//ns2:Weight')[0].content = attributes[:]
    # xml.xpath('ns2:Parcel//ns2:Width')[0].content = attributes[:]
  end

  def set_order_lines(encoded_hash, items)
    items.each do |item|
      line = {
        "ns2:CountryOfOrigin": item[:country_of_origin],
        "ns2:Currency": item[:currency],
        "ns2:Description1": item[:description],
        "ns2:HarmonizationCode": item[:harmonization_code],
        "ns2:ProductNumber": item[:product_number],
        "ns2:QuantityShipped": item[:quantity_shipped],
        "ns2:UnitOfMeasure": item[:unit_of_measure],
        "ns2:UnitPrice": item[:unit_price],
        "ns2:UnitWeight": item[:unit_weight],
        "ns2:Volume": item[:volume],
        "ns2:Weight": item[:weight]
      }
      encoded_hash[:"ns1:AddAndPrintShipmentRequest"][:"ns2:Parcels"][:"ns2:Parcel"][:"ns2:OrderLines"][:"ns2:OrderLine"] << line
    end

    encoded_hash
  end

  def test_xml
    "<SOAP-ENV:Envelope
  xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/'
  xmlns:ns1='http://centiro.com/facade/tmsBasic/1/0/servicecontract'
  xmlns:ns2='http://schemas.datacontract.org/2004/07/Centiro.Facade.TMSBasic.Contract.c1.i1.TMSBasic.BaseTypes.DTO'
  xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'
  xmlns:ns3='http://centiro.com/facade/shared/1/0/datacontract'>
  <SOAP-ENV:Header>
    <ns3:AuthenticationTicket>ERjXNo89J7pamvMnnAk0eY64VnpwCBvwEVuu8p1kjg2ZJ7aL4vbpNiQGLS7Malv%2f2Pj6DeDcQWqbZFRrt6zwQ3Eyl3%2bVna%2fPYwLZMLE%2fR6Azi2plW3%2bjMfrFkVDbbS08SPO5%2fdQwMFnr%2fUp5ise4JL7eT4GSamrm</ns3:AuthenticationTicket>
  </SOAP-ENV:Header>
  <SOAP-ENV:Body>
    <ns1:AddAndPrintShipmentRequest>
      <ns1:LabelType>PDF</ns1:LabelType>
      <ns1:Shipment>
        <ns2:Addresses>
          <ns2:Address>
            <ns2:Address1>Zeughausgasse 9</ns2:Address1>
            <ns2:AddressType>Receiver</ns2:AddressType>
            <ns2:CellPhone>+41123456780</ns2:CellPhone>
            <ns2:City>Bern</ns2:City>
            <ns2:Contact>Thomas Baer</ns2:Contact>
            <ns2:Email>tbaer@yahoo.ch</ns2:Email>
            <ns2:ISOCountry>CH</ns2:ISOCountry>
            <ns2:Name>Baer Hotel</ns2:Name>
            <ns2:Phone>+41123456789</ns2:Phone>
            <ns2:ZipCode>3011</ns2:ZipCode>
          </ns2:Address>
        </ns2:Addresses>
        <ns2:Attributes>
          <ns2:Attribute>
            <ns2:Code>OriginSub</ns2:Code>
            <ns2:Value>NL</ns2:Value>
          </ns2:Attribute>
          <ns2:Attribute>
            <ns2:Code>CRMID</ns2:Code>
            <ns2:Value>NL20171011</ns2:Value>
          </ns2:Attribute>
          <ns2:Attribute>
            <ns2:Code>Product</ns2:Code>
            <ns2:Value>FTG</ns2:Value>
          </ns2:Attribute>
          <ns2:Attribute>
            <ns2:Code>Service</ns2:Code>
            <ns2:Value>MBD</ns2:Value>
          </ns2:Attribute>
          <ns2:Attribute>
            <ns2:Code>AdditionalService</ns2:Code>
            <ns2:Value></ns2:Value>
          </ns2:Attribute>
          <ns2:Attribute>
            <ns2:Code>Format</ns2:Code>
            <ns2:Value>B</ns2:Value>
          </ns2:Attribute>
        </ns2:Attributes>
        <ns2:Currency>EUR</ns2:Currency>
        <ns2:ModeOfTransport>ACSS</ns2:ModeOfTransport>
        <ns2:OrderNumber>ORD0000005</ns2:OrderNumber>
        <ns2:Parcels>
          <ns2:Parcel>
            <ns2:Height>0</ns2:Height>
            <ns2:Length>0</ns2:Length>
            <ns2:OrderLines>
              <ns2:OrderLine>
                <ns2:CountryOfOrigin>NL</ns2:CountryOfOrigin>
                <ns2:Currency>EUR</ns2:Currency>
                <ns2:Description1>Blue Watch</ns2:Description1>
                <ns2:HarmonizationCode>910310</ns2:HarmonizationCode>
                <ns2:OrderLineNumber>1</ns2:OrderLineNumber>
                <ns2:ProductNumber>WBLUE1234</ns2:ProductNumber>
                <ns2:QuantityShipped>2</ns2:QuantityShipped>
                <ns2:UnitOfMeasure>EA</ns2:UnitOfMeasure>
                <ns2:UnitPrice>10</ns2:UnitPrice>
                <ns2:UnitWeight>0.1</ns2:UnitWeight>
                <ns2:Volume>0</ns2:Volume>
                <ns2:Weight>0.2</ns2:Weight>
              </ns2:OrderLine>
              <ns2:OrderLine>
                <ns2:CountryOfOrigin>NL</ns2:CountryOfOrigin>
                <ns2:Currency>EUR</ns2:Currency>
                <ns2:Description1>RedWatch</ns2:Description1>
                <ns2:HarmonizationCode>910310</ns2:HarmonizationCode>
                <ns2:OrderLineNumber>2</ns2:OrderLineNumber>
                <ns2:ProductNumber>WRED1234</ns2:ProductNumber>
                <ns2:QuantityShipped>3</ns2:QuantityShipped>
                <ns2:UnitOfMeasure>EA</ns2:UnitOfMeasure>
                <ns2:UnitPrice>30</ns2:UnitPrice>
                <ns2:UnitWeight>0.3</ns2:UnitWeight>
                <ns2:Volume>0</ns2:Volume>
                <ns2:Weight>0.9</ns2:Weight>
              </ns2:OrderLine>
            </ns2:OrderLines>
            <ns2:ParcelIdentifier>PRCID005</ns2:ParcelIdentifier>
            <ns2:TypeOfGoods>Goods</ns2:TypeOfGoods>
            <ns2:TypeOfPackage>Small Packet</ns2:TypeOfPackage>
            <ns2:Value>110</ns2:Value>
            <ns2:Weight>1.1</ns2:Weight>
            <ns2:Width>0</ns2:Width>
          </ns2:Parcel>
        </ns2:Parcels>
        <ns2:SenderCode>NL16090001</ns2:SenderCode>
        <ns2:ShipDate>2018-06-20T17:12:47</ns2:ShipDate>
        <ns2:ShipmentIdentifier>SHIP00005</ns2:ShipmentIdentifier>
        <ns2:ShipmentType>OUTB</ns2:ShipmentType>
        <ns2:TermsOfDelivery>DDP</ns2:TermsOfDelivery>
        <ns2:Value>110</ns2:Value>
        <ns2:Weight>1.1</ns2:Weight>
      </ns1:Shipment>
    </ns1:AddAndPrintShipmentRequest>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>"
  end

  def test_xml_2
    "<env:Envelope xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:wsdl='http://tempuri.org/' xmlns:env='http://schemas.xmlsoap.org/soap/envelope/' xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ns1='http://centiro.com/facade/tmsBasic/1/0/servicecontract' xmlns:ns2='http://schemas.datacontract.org/2004/07/Centiro.Facade.TMSBasic.Contract.c1.i1.TMSBasic.BaseTypes.DTO' xmlns:ns3='http://centiro.com/facade/shared/1/0/datacontract'>
  <env:Header>
    <ns3:AuthenticationTicket>ERjXNo89J7pamvMnnAk0eY64VnpwCBvwEVuu8p1kjg2ZJ7aL4vbpNiQGLS7Malv%2f2Pj6DeDcQWqbZFRrt6zwQ08mhii5fiIdXj%2fatzDzwxZ%2bHCAXQXnzP3f2wwDoluUQtxaoznlNsCc03eQgh7EJxtCf87g%2bhN8n</ns3:AuthenticationTicket>
  </env:Header>
  <env:Body>
      <ns1:AddAndPrintShipmentRequest>
        <ns1:LabelType>PDF</ns1:LabelType>
        <ns1:Shipment>
             <ns2:Currency>EUR</ns2:Currency>
        <ns2:ModeOfTransport>ACSS</ns2:ModeOfTransport>
        <ns2:OrderNumber>ORD0000005</ns2:OrderNumber>
        <ns2:Attributes>
          <ns2:Attribute>
            <ns2:Code>OriginSub</ns2:Code>
            <ns2:Value>NL</ns2:Value>
          </ns2:Attribute>
          <ns2:Attribute>
            <ns2:Code>CRMID</ns2:Code>
            <ns2:Value>NL16090001</ns2:Value>
          </ns2:Attribute>
          <ns2:Attribute>
            <ns2:Code>Product</ns2:Code>
            <ns2:Value>FTG</ns2:Value>
          </ns2:Attribute>
          <ns2:Attribute>
            <ns2:Code>Service</ns2:Code>
            <ns2:Value>MBD</ns2:Value>
          </ns2:Attribute>
          <ns2:Attribute>
            <ns2:Code>AdditionalService</ns2:Code>
            <ns2:Value/>
          </ns2:Attribute>
          <ns2:Attribute>
            <ns2:Code>Format</ns2:Code>
            <ns2:Value>B</ns2:Value>
          </ns2:Attribute>
        </ns2:Attributes>
          <ns2:SenderCode>NL16090001</ns2:SenderCode>
          <ns2:ShipDate>2018-06-20T17:12:47</ns2:ShipDate>
          <ns2:ShipmentIdentifier xsi:nil='true'/>
          <ns2:ShipmentType>OUTB</ns2:ShipmentType>
          <ns2:Value>110</ns2:Value>
          <ns2:TermsOfDelivery>DDP</ns2:TermsOfDelivery>
          <ns2:Weight>1.1</ns2:Weight>
          <ns2:Addresses>
            <ns2:Address>
              <ns2:Address1>Zeughausgasse 9</ns2:Address1>
              <ns2:AddressType>Receiver</ns2:AddressType>
              <ns2:CellPhone>+41123456780</ns2:CellPhone>
              <ns2:City>Bern</ns2:City>
              <ns2:Contact>Thomas Baer</ns2:Contact>
              <ns2:Email>tbaer@yahoo.ch</ns2:Email>
              <ns2:ISOCountry xsi:nil='true'/>
              <ns2:Name>Baer Hotel</ns2:Name>
              <ns2:Phone>+41123456789</ns2:Phone>
              <ns2:ZipCode>3011</ns2:ZipCode>
            </ns2:Address>
          </ns2:Addresses>
          <ns2:Parcels>
          <ns2:Parcel>
            <ns2:Height>0</ns2:Height>
            <ns2:Length>0</ns2:Length>
            <ns2:OrderLines>
              <ns2:OrderLine>
                <ns2:CountryOfOrigin>NL</ns2:CountryOfOrigin>
                <ns2:Currency>EUR</ns2:Currency>
                <ns2:Description1>Blue Watch</ns2:Description1>
                <ns2:HarmonizationCode>910310</ns2:HarmonizationCode>
                <ns2:ProductNumber>WBLUE1234</ns2:ProductNumber>
                <ns2:QuantityShipped>2</ns2:QuantityShipped>
                <ns2:UnitOfMeasure>EA</ns2:UnitOfMeasure>
                <ns2:UnitPrice>10</ns2:UnitPrice>
                <ns2:UnitWeight>0.1</ns2:UnitWeight>
                <ns2:Volume>0</ns2:Volume>
                <ns2:Weight>0.2</ns2:Weight>
              </ns2:OrderLine>
              <ns2:OrderLine>
                <ns2:CountryOfOrigin>NL</ns2:CountryOfOrigin>
                <ns2:Currency>EUR</ns2:Currency>
                <ns2:Description1>Blue Watch</ns2:Description1>
                <ns2:HarmonizationCode>910310</ns2:HarmonizationCode>
                <ns2:ProductNumber>WBLUE1234</ns2:ProductNumber>
                <ns2:QuantityShipped>3</ns2:QuantityShipped>
                <ns2:UnitOfMeasure>EA</ns2:UnitOfMeasure>
                <ns2:UnitPrice>30</ns2:UnitPrice>
                <ns2:UnitWeight>0.3</ns2:UnitWeight>
                <ns2:Volume>0</ns2:Volume>
                <ns2:Weight>0.9</ns2:Weight>
              </ns2:OrderLine>
            </ns2:OrderLines>
          </ns2:Parcel>
        </ns2:Parcels>
        </ns1:Shipment>
      </ns1:AddAndPrintShipmentRequest>
  </env:Body>
</env:Envelope>"
end

end
