module AsendiaShipment::Client
  def self.get_client(type)
    file = type == "auth" ? "../assets/asendia.wsdl" : "../assets/asendia_operations.wsdl"
    wsdl = File.join( File.dirname(__FILE__), file)

    namespaces = {
      "xmlns:SOAP-ENV" => "http://schemas.xmlsoap.org/soap/envelope/",
      "xmlns:ns1" => "http://centiro.com/facade/tmsBasic/1/0/servicecontract",
      "xmlns:ns2" => "http://schemas.datacontract.org/2004/07/Centiro.Facade.TMSBasic.Contract.c1.i1.TMSBasic.BaseTypes.DTO",
      "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
      "xmlns:ns3" => "http://centiro.com/facade/shared/1/0/datacontract"
    }

    @client = Savon.client(
      wsdl: wsdl,
      log: true,
      log_level: :debug,
      pretty_print_xml: true,
      namespaces: namespaces,
      convert_request_keys_to: :none
    )
  end


end