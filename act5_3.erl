-module(act5_3).
-export([runSequencial/1]).
-export([get_all_lines/1]).
-export([runParallel/1]).

get_all_lines(SIn) ->
    case io:get_line(SIn, "") of
        eof  -> [];
        Line -> [Line] ++ get_all_lines(SIn)
    end.

runSequencial(File)->
    FileIn = File ++ "1.in",
    FileOut = File ++ "1.out",
    {ok, SIn} = file:open(FileIn, read),
    ListaLineas = get_all_lines(SIn),

    List1 = string:split(lists:nth(1,ListaLineas), " ",all),
    %List1,
    {ok, SOut} = file:open(FileOut, [write]),
    io:format(SOut, "~s~n", [List1]).

runParallel(File)->
    File.