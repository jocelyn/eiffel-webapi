note
	description : "examples application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			foursquare : OAUTH_FOURSQUARE_API_20
			config : OAUTH_CONFIG
			api_service : OAUTH_SERVICE_I
			request : OAUTH_REQUEST
			access_token : detachable OAUTH_TOKEN
		do
			create config.make_default (api_key, api_secret)
			config.set_callback ("http://eiffelroom.com/")
			create foursquare
			api_service := foursquare.create_service (config)

			print ("%N=== Foursquare2's OAuth Workflow ===%N")

			-- Obtain the Authorization URL
    		print("%NFetching the Authorization URL...");
    		if attached api_service.authorization_url (empty_token) as lauthorization_url then
			    print("%NGot the Authorization URL!%N");
			    print("%NNow go and authorize here:%N");
			    print(lauthorization_url);
			    print("%NAnd paste the authorization code here%N");
			    io.read_line
			end

		   access_token := api_service.access_token (empty_token, create {OAUTH_VERIFIER}.make (io.last_string))
		   if attached access_token as l_access_token then
		   		print("%NGot the Access Token!%N");
    	   		print("%N(Token: " + l_access_token.debug_output + " )%N");


	      	  --Now let's go and ask for a protected resource!
	    	  print("%NNow we're going to access a protected resource...%N");
	    	  create request.make ("GET", protected_resource_url + l_access_token.token )
	 		  api_service.sign_request (l_access_token, request)
	    	  if attached {OAUTH_RESPONSE} request.execute as l_response then
					print ("%NOk, let see what we found...")
					print ("%NResponse: STATUS" + l_response.status.out)
					if attached l_response.body as l_body then
						print ("%NBody:"+l_body)
					end
	    	  end
		   end

 		end


feature {NONE} -- Implementation

	api_key : STRING ="HMXW41EXSOUQFFXCZWGLCYBNPCLCEDSQGWHTWI0WJKFRMV3A"
	api_secret :STRING ="XZ3Y1R5CBNUIQ0HTM4KOKWVXHXCJM35ET50VZ00YKZPFWKKQ"
	protected_resource_url : STRING = "https://api.foursquare.com/v2/users/self/friends?oauth_token=";
 	empty_token : detachable  OAUTH_TOKEN

end
