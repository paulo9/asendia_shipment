module AsendiaShipment::Client
  def self.get_client(type)
    wsdl = type == "auth" ? "asendia.wsdl" : "asendia_operations.wsdl"

    @client = Savon.client(
      wsdl: wsdl,
      log: true,
      log_level: :debug,
      pretty_print_xml: true,
      convert_request_keys_to: :none
    )
  end
end