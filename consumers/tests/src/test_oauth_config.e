note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_OAUTH_CONFIG

inherit
	EQA_TEST_SET

feature -- Test routines

	test_basic_config
		local
			l_config :OAUTH_CONFIG
		do
			create l_config.make_default ("api","secret")
			assert ("Expected api",l_config.api_key.same_string("api"))
			assert ("Not scope",not l_config.has_scope)
		end

	test_config
		local
			l_config :OAUTH_CONFIG
		do
			create l_config.make ("api","test", Void, Void, Void, Void)
			assert ("Expected api",l_config.api_key.same_string("api"))
			assert ("Not scope",not l_config.has_scope)
		end

end


