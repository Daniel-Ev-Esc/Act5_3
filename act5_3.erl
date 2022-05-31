-module(act5_3).
-export([readlines/1, get_all_lines/1, run/1]).
% -export([runParallel/1]).

readlines(FileName) ->
    {ok, Device} = file:open(FileName, [read]),
    try get_all_lines(Device)
      after file:close(Device)
    end.

get_all_lines(Device) ->
    case io:get_line(Device, "") of
        eof  -> [];
        Line -> Line ++ get_all_lines(Device)
    end.


run(FileName) ->
    L1 = readlines(FileName),
    L1,
    L2 = string:lexemes(L1, "\n"),
    L2.

% runSequencial(File)->
%     FileIn = File ++ "1.in",
%     FileOut = File ++ "1.out",
%     {ok, SIn} = file:open(FileIn, read),
%     ListaLineas = get_all_lines(SIn),

%     List1 = string:split(lists:nth(1,ListaLineas), " ",all),
%     %List1,
%     {ok, SOut} = file:open(FileOut, [write]),
%     io:format(SOut, "~s~n", [List1]).




