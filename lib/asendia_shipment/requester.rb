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
      begin
        encoded_shipment = encode_shipment(shipment)
        resp = client.call(:add_and_print_shipment, xml: encoded_shipment.to_xml)
        track_code = resp.body[:add_and_print_shipment_response][:shipments][:sequence_number]
        base_64_pdf = resp.body[:add_and_print_shipment_response][:parcel_documents][:parcel_document][:content]
        { success: true, track_code: track_code, pdf_encoded: base_64_pdf }
      rescue Savon::Error => e
        { success: false, errors: e }
      end
    end

  end
end