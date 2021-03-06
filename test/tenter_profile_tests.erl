-module(tenter_profile_tests).

-include_lib("eunit/include/eunit.hrl").

-include("tenter.hrl").

-define(PROFILE_JSON, <<"{
    \"https://tent.io/types/info/basic/v0.1.0\": {
        \"avatar_url\": \"http://example.com/avatar.png\", 
        \"bio\": \"I like testing\", 
        \"birthdate\": \"2012-12-13\", 
        \"gender\": \"male\", 
        \"location\": \"Melbourne, Australia\", 
        \"name\": \"mrexample\", 
        \"permissions\": {
            \"public\": true
        }, 
        \"version\": 1
    }, 
    \"https://tent.io/types/info/core/v0.1.0\": {
        \"entity\": \"https://mrexample.tent.example.com\", 
        \"licenses\": [], 
        \"permissions\": {
            \"public\": true
        }, 
        \"servers\": [
            \"https://mrexample.tent.example.com/tent\"
        ], 
        \"tent_version\": \"0.2\", 
        \"version\": 1
    }
  }">>).

profile() ->
  {ok, Profile} = tenter_profile:build(json, ?PROFILE_JSON),
  Profile.

basic() ->
  Profile = profile(),
  Profile#post_profile.info_basic.


build_json_basic_test() ->
  Basic = basic(),
  ?assertEqual(<<"http://example.com/avatar.png">>, Basic#info_basic.avatar_url),
  ?assertEqual(<<"I like testing">>, Basic#info_basic.bio),
  ?assertEqual(<<"2012-12-13">>, Basic#info_basic.birthdate),
  ?assertEqual(<<"male">>, Basic#info_basic.gender),
  ?assertEqual(<<"Melbourne, Australia">>, Basic#info_basic.location),
  ?assertEqual(<<"mrexample">>, Basic#info_basic.name),
  ?assertEqual([{<<"public">>, true}], Basic#info_basic.permissions),
  ?assertEqual(1, Basic#info_basic.version).
