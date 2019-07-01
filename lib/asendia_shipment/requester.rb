require 'byebug'
module AsendiaShipment
  class Requester
    include Encoder

    def request_ticket_auth(user, pass)
      xml = encode_auth_xml(user, pass)
      client = Client.get_client('auth')

      begin
        response = client.call(:authenticate, xml: xml)
        { success: true, errors: nil,token: response.body[:authenticate_response][:authentication_ticket] }
      rescue Savon::Error => e
        case e.http.code
        when 401
          error = 'Login failed, check username and/or password.'
        else
          error = e
        end

        return { success: false, errors: error, token: nil }
      end
    end

    def request_label(shipment)
      client = Client.get_client('operations')
      encoded_shipment = encode_shipment(shipment)
      byebug
      client.call(:add_and_print_shipment, message: encoded_shipment, soap_header: {'ns3:AuthenticationTicket': shipment[:ticket]})
    end

  end
end