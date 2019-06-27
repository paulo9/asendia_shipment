require "savon"
require "byebug"

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
        case e
        when e.http.code == 401
          error = 'Login failed, check username and/or password.'
        else
          error = e
        end

        { success: false, errors: error, token: nil }
      end
    end

    def request_label(shipment)
      client = Client.get_client('auth')
      encoded_shipment = encode_shipment(shipment)
    end

  end
end