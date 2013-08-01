note
	description: "Summary description for {TEST_OAUTH_TOKEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_OAUTH_TOKEN
inherit
	EQA_TEST_SET

feature -- Tests

	test_tokens_equals
		local
			actual, expected : OAUTH_TOKEN
		do
			create actual.make_token_secret ("token", "secret")
			create expected.make_token_secret ("token", "secret")
			assert ("Expected Equals", expected.is_equal(actual))
		end

	test_tokens_not_equals
		local
			actual, expected : OAUTH_TOKEN
		do
			create actual.make_token_secret ("token", "secret")
			create expected.make_token_secret ("token", "not_secret")
			assert ("Expected Not Equals", not expected.is_equal(actual))
		end

	test_token_equals_not_depends_on_raw_string
		local
			actual, expected : OAUTH_TOKEN
		do
			create actual.make_token_secret ("token", "secret")
			create expected.make_token_secret_response ("token", "secret","response")
			assert ("Expected Not Equals",  expected.is_equal(actual))

			create actual.make_token_secret_response ("token", "secret","diff response")
			create expected.make_token_secret_response ("token", "secret","response")
			assert ("Expected Not Equals",  expected.is_equal(actual))
		end
end
