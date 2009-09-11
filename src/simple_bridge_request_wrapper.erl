% Simple Bridge
% Copyright (c) 2008-2009 Rusty Klophaus
% See MIT-LICENSE for licensing information.

-module (simple_bridge_request_wrapper, [Mod, Req]).
-compile(export_all).

request_method() -> Mod:request_method(Req).
path() -> Mod:path(Req).

peer_ip() -> Mod:peer_ip(Req).
peer_port() -> Mod:peer_port(Req).

headers() -> Mod:headers(Req).

header(Header) -> 
	case erlang:function_exported(Mod, header, 2) of
		true -> 
			Mod:header(Header, Req);
		false ->
				Headers = Mod:headers(Req),
				proplists:get_value(Header, Headers)
	end.
	
cookies() -> Mod:cookies(Req).

query_params() -> Mod:query_params(Req).

post_params() -> Mod:post_params(Req).

request_body() -> Mod:request_body(Req).

socket() -> 
	case erlang:function_exported(Mod, socket, 1) of
		true -> Mod:socket(Req);
		false -> throw({not_supported, Mod, socket})
	end.

get_peername() -> inet:peername(socket()).

recv_from_socket(Length, Timeout) -> 
	case erlang:function_exported(Mod, recv_from_socket, 3) of
		true ->  Mod:recv_from_socket(Length, Timeout, Req);
		false -> throw({not_supported, Mod, recv_from_socket})
	end.