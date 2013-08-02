note
	description: "Summary description for {OAUTH_20_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_20_SERVICE
inherit
	OAUTH_SERVICE_I
		export {NONE}
			request_token
		end
create
	make
feature {NONE}-- Initialization
	make ( an_api : like api; a_config : like config)
		do
			api := an_api
			config := a_config
			version := INTERNAL_VERSION
		ensure
			api_set : api = an_api
			config_set : config = a_config
			version_set : version = INTERNAL_VERSION
		end

feature -- Access

		access_token (da_request_token : detachable OAUTH_TOKEN; verifier : OAUTH_VERIFIER) : detachable OAUTH_TOKEN
				-- retrive an access token using a request token
				-- (obtained previously)
			local
				l_request : OAUTH_REQUEST
			do
				create l_request.make (api.access_token_verb, api.access_token_endpoint)
				l_request.add_query_string_parameter ({OAUTH_CONSTANTS}.client_id, config.api_key)
				l_request.add_query_string_parameter ({OAUTH_CONSTANTS}.client_secret, config.api_secret)

				l_request.add_query_string_parameter ({OAUTH_CONSTANTS}.code, verifier.value)

				if attached config.callback as l_callback then
					l_request.add_query_string_parameter ({OAUTH_CONSTANTS}.redirect_uri, l_callback)
				end

				if config.has_scope and then attached config.scope as l_scope then
					l_request.add_query_string_parameter ({OAUTH_CONSTANTS}.scope, l_scope)
				end
				if attached l_request.execute as l_response then
					if attached l_response.body as l_body then
						Result := api.access_token_extractor.extract (l_body)
					end
				end
			end

		sign_request (an_access_token : OAUTH_TOKEN; a_req : OAUTH_REQUEST)
				-- Signs an OAuth request using an access token (obtained previously)
			do
				a_req.add_query_string_parameter ({OAUTH_CONSTANTS}.access_token, an_access_token.token)
			end



		authorization_url (a_request_token : detachable OAUTH_TOKEN) : detachable READABLE_STRING_GENERAL
				-- URL where you should redirect your users to authenticate
   				-- your application.
   				-- a request token needed to authorize
			do
				Result := api.authorization_url (config)
			end

feature {NONE} -- Implementation
	INTERNAL_VERSION : STRING = "2.0"
	api : OAUTH_API_20
	config : OAUTH_CONFIG

	request_token : detachable OAUTH_TOKEN
				-- retrieve the request token
			do
				-- "Unsupported operation, please use 'getAuthorizationUrl' and redirect your users there"
			end
end
