note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	EIS : "name:HMAC-SHA1 test", "src=http://tools.ietf.org/html/rfc2202", "protocol=uri"

class
	TEST_HMAC_SHA1_SET

inherit
	EQA_TEST_SET

feature -- Test routines


	test_rfc2202_1
		local
			hmac: HMAC_SHA1
			expected: INTEGER_X
		do
			create hmac.make (create {INTEGER_X}.make_from_hex_string ("0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b"))
			hmac.sink_string ("Hi There")
			hmac.finish
			create expected.make_from_hex_string ("b617318655057264e28bc0b6fb378c8ef146be00")
			assert ("test_rfc2202_1", hmac.hmac.is_equal (expected))
		end

	test_rfc2202_prag_imp
		local
			hmac: SHA1_UTIL
			res : STRING
		do
			create hmac
			res := hmac.hmac_sha1("key","The quick brown fox jumps over the lazy dog")
			assert ("Expected", res.is_equal("de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9"))

		end


end


