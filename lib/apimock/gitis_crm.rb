module Apimock
  class GitisCrm
    def stub_contact_request(uuid, params = {})
      stub_request(:get, "#{service_url}#{endpoint}/contacts(#{uuid})").
        with(headers: get_headers).
        to_return(
          status: 200,
          headers: {
            'Content-Type' => 'application/json; odata.metadata=minimal',
          },
          body: contact_data.merge(
            '@odata.context' => "#{service_url}#{endpoint}/$metadata#contacts/$entity",
            'contactid' => uuid
          ).merge(params.stringify_keys).to_json
        )
    end

    def stub_contact_listing_request(uuid = SecureRandom.uuid)
      stub_request(:get, "#{service_url}#{endpoint}/contacts?$top=1").
        with(headers: get_headers).
        to_return(
          status: 200,
          headers: {
            'Content-Type' => 'application/json; odata.metadata=minimal',
          },
          body: {
            "@odata.context" => "#{service_url}#{endpoint}/$metadata#contacts",
            "value" => [contact_data.merge('contactid' => uuid)]
          }.to_json
        )
    end

    def stub_access_token
      stub_request(:post, "#{auth_url}/#{auth_tenant_id}/oauth2/token").
        with(
          headers: { 'Accept' => 'application/json' },
          body: {
            "grant_type" => "client_credentials",
            "scope" => "",
            "client_id" => client_id,
            "client_secret" => client_secret,
            "resource" => service_url,
          }.to_query
        ).
        to_return(
          status: 200,
          headers: { 'Content-Type' => 'application/json' },
          body: {
            'token_type' => 'Bearer',
            'expires_in' => 3600,
            'resource' => service_url,
            'access_token' => "MY.STUB.TOKEN"
          }.to_json
        )
    end

    def stub_create_contact_request(params)
      stub_request(:post, "#{service_url}#{endpoint}/contacts").
        with(headers: post_headers, body: params.to_json).
        to_return(
          status: 204,
          headers: {
            'content-type' => 'application/json',
            'odata-entityid' => "#{service_url}#{endpoint}/contacts(#{SecureRandom.uuid})"
          },
          body: ''
        )
    end

    def stub_update_contact_request(uuid, params)
      stub_request(:patch, "#{service_url}#{endpoint}/contacts(#{uuid})").
        with(headers: post_headers, body: params.to_json).
        to_return(
          status: 204,
          headers: { 'content-type' => 'application/json' },
          body: ''
        )
    end

    def stub_create_school_experience_request(params)
      stub_request(:post, "#{service_url}#{endpoint}/dfe_candidateschoolexperiences").
        with(headers: post_headers, body: params.to_json).
        to_return(
          status: 204,
          headers: {
            'content-type' => 'application/json',
            'odata-entityid' => "#{service_url}#{endpoint}/dfe_candidateschoolexperiences(#{SecureRandom.uuid})"
          },
          body: ''
        )
    end

    def stub_school_experience_request(uuid, params = {})
      stub_request(:get, "#{service_url}#{endpoint}/dfe_candidateschoolexperiences(#{uuid})").
        with(headers: get_headers).
        to_return(
          status: 200,
          headers: {
            'Content-Type' => 'application/json; odata.metadata=minimal',
          },
          body: {
            '@odata.context' => "#{service_url}#{endpoint}/$metadata#contacts/$entity",
            'dfe_candidateschoolexperienceid' => uuid,
            'dfe_notes' => 'test suite'
          }.merge(params.stringify_keys).to_json
        )
    end

    def stub_update_school_experience_request(uuid, params)
      stub_request(:patch, "#{service_url}#{endpoint}/dfe_candidateschoolexperiences(#{uuid})").
        with(headers: post_headers, body: params.to_json).
        to_return(
          status: 204,
          headers: { 'content-type' => 'application/json' },
          body: ''
        )
    end

    def stub_attach_school_experience_request(contact_id, experience_id)
      stub_request(:post, "#{service_url}#{endpoint}/contacts(#{contact_id})/dfe_contact_dfe_candidateschoolexperience_ContactId/$ref").
        with(headers: post_headers, body: {
          "@odata.id" => "#{service_url}#{endpoint}/dfe_candidateschoolexperiences(#{experience_id})"
        }.to_json).
        to_return(
          status: 204,
          headers: { 'content-type' => 'application/json' },
          body: ''
        )
    end

    def stub_expanded_contact_request(contact_id, experience_id, contact_params = {}, experience_params = {})
      stub_request(:get, "#{service_url}#{endpoint}/contacts(#{contact_id})?$expand=dfe_contact_dfe_candidateschoolexperience_ContactId").
        with(headers: get_headers).
        to_return(
          status: 200,
          headers: {
            'Content-Type' => 'application/json; odata.metadata=minimal',
          },
          body: {
            '@odata.context' => "#{service_url}#{endpoint}/$metadata#contacts/$entity",
            'contactid' => contact_id,
            'firstname' => 'first name',
            'lastname' => 'last name',
            'dfe_contact_dfe_candidateschoolexperience_ContactId' => [
              {
                'dfe_candidateschoolexperienceid' => experience_id,
                'dfe_notes' => 'Some notes'
              }.merge(experience_params.stringify_keys)
            ]
          }.merge(contact_params.stringify_keys).to_json
        )
    end

  private

    def stub_request(method, uri)
      WebMock::StubRegistry.instance.
        register_request_stub(WebMock::RequestStub.new(method, uri))
    end

    def auth_url
      "https://login.microsoftonline.com"
    end

    def service_url
      ENV.fetch('CRM_SERVICE_URL')
    end

    def client_id
      ENV.fetch('CRM_CLIENT_ID')
    end

    def client_secret
      ENV.fetch('CRM_CLIENT_SECRET')
    end

    def auth_tenant_id
      ENV.fetch('CRM_AUTH_TENANT_ID')
    end

    def endpoint
      "/api/data/v9.1"
    end

    def get_headers
      {
        'Accept' => 'application/json',
        'Authorization' => /Bearer \w+\.\w+\.\w/,
        "OData-MaxVersion" => "4.0",
        "OData-Version" => "4.0",
      }
    end

    def post_headers
      {
        'Accept' => 'application/json',
        'Authorization' => /Bearer \w+\.\w+\.\w/,
        "OData-MaxVersion" => "4.0",
        "OData-Version" => "4.0",
        "Content-Type" => "application/json"
      }
    end

    def contact_data
      {
        'firstname' => "Test User",
        'lastname' => "TestUser",
        'emailaddress1' => "school-experience-testuser@education.gov.uk",
        'mobilephone' => "07123456789",
        'telephone1' => "01234567890",
        'address1_line1' => "First Address Line",
        'address1_line2' => "Second Address Line",
        'address1_line3' => "Third Address Line",
        'address1_city' => "Manchester",
        'address1_stateorprovince' => "",
        'address1_postalcode' => "MA1 1AM",
        'statecode' => 0,
        'dfe_channelcreation' => 222750021
      }
    end
  end
end
