note
	description: "Summary description for {OAUTH_SIGNATURE_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_SIGNATURE_TYPE

create
	make
feature --{NONE}
	make
		do
			mark_header
		end
feature -- Access
	signature_type : INTEGER_32

feature -- Status Report
	is_valid_signature (s : INTEGER) : BOOLEAN
		do
		inspect s
				when header then
					Result := True
				when query_string then
					Result := True
				else
				end
		end

	is_header : BOOLEAN
		do
			Result := signature_type = header
		end

	is_query_string : BOOLEAN
		do
			Result := signature_type = query_string
		end

feature -- Change Market Type
	set_signature_type (a_signature_type : INTEGER_32)
		require
			valid_signature_type: is_valid_signature (a_signature_type)
		do
			signature_type := a_signature_type
		ensure
			signature_type_set : signature_type = a_signature_type
		end

	mark_header
		do
			set_signature_type (header)
		end

	mark_query_string
		do
			set_signature_type (query_string)
		end

feature -- Constants
	Header : INTEGER = 1
 	Query_string : INTEGER = 2

invariant
	signature_type_set: is_valid_signature (signature_type)
end

