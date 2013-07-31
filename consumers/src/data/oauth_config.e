note
	description: "Summary description for {OAUTH_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_CONFIG

create
	make_default,
	make
feature {NONE} -- Initializaton
	make ( a_key : like api_key; a_secret : like api_secret; a_callback : like callback;  a_signature : like signature_type; a_scope : like scope; a_stream : like debug_stream)
		do
			api_key := a_key
			api_secret := a_secret
			callback := a_callback
			signature_type := a_signature
			scope := a_scope
			debug_stream := a_stream
		ensure
			key_set : api_key = a_key
			secret_Set : api_secret = a_secret
			callback_set : attached callback as l_callback implies l_callback = a_callback
			signature_type_set : attached signature_type as l_signature implies l_signature = a_signature
			scope_set : attached scope implies has_scope
			debug_stream_set : attached debug_stream as l_debug_stream implies l_debug_stream = a_stream
		end

	make_default ( a_key : like api_key; a_secret : like api_secret)
		do
			make (a_key, a_secret, Void, Void, Void, Void)
		ensure
			key_set : api_key = a_key
			secret_Set : api_secret = a_secret
		end

feature -- Access
	api_key : READABLE_STRING_GENERAL
	api_secret : READABLE_STRING_GENERAL
	callback : detachable READABLE_STRING_GENERAL
	signature_type : detachable OAUTH_SIGNATURE_TYPE
	scope : detachable READABLE_STRING_GENERAL
	debug_stream : detachable STRING

feature -- Status Report
	has_scope : BOOLEAN
		do
			Result := attached scope
		end

--  public void log(String message)
--  {
--    if (debugStream != null)
--    {
--      message = message + "\n";
--      try
--      {
--        debugStream.write(message.getBytes("UTF8"));
--      }
--      catch (Exception e)
--      {
--        throw new RuntimeException("there were problems while writting to the debug stream", e);
--      }
--    }
--  }
end
