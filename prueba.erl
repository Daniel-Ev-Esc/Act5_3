-module(prueba).
-export([readlines/1, get_all_lines/1, run/1, split2/3]).
-export([join2/3]).


readlines(FileName) ->
    {ok, Device} = file:open(FileName, read),
    try get_all_lines(Device)
      after file:close(Device)
    end.

get_all_lines(Device) ->
    case io:get_line(Device, "") of
        eof  -> [];
        Line -> Line ++ get_all_lines(Device)
    end.

join2(N1,O,N2) -> if
    O == "+" -> io:format("Lei: ~p~n", [N1 + N2]);
    O == "-" -> io:format("Lei: ~p~n", [N1 - N2]);
    O == "*" -> io:format("Lei: ~p~n", [N1 * N2]);
    O == "/" -> io:format("Lei: ~p~n", [N1 / N2]);
    O == "%" -> io:format("Lei: ~p~n", [N1 rem N2]);
    true -> io:format("No support for negative numbers. ̃n")

end.

split2(L, I, N)-> 
    if I < (N + 1) ->
        L0 = string:lexemes(hd(L), " "),
        N1 = list_to_integer(lists:nth(1, L0)),
        Operador = lists:nth(2, L0),
        N2 = list_to_integer(lists:nth(3, L0)),
        
        %Aqui hay que poner que gusrade el elemento que le amnde Operations
        join2(N1, Operador, N2),
        M = tl(L),
        if M /= [] ->
            split2(M, I+1, N);
            true -> io:format("Lectura terminada")
        end;

    true -> split2(tl(L), I+1, N)
end.


run(FileName) ->
    FileIn1 = FileName ++ "4.in",
    FileOut1 = FileName ++ "1.out",

    L1 = readlines(FileIn1),
    L1,
    L2 = string:lexemes(L1, "\n"),
    L2,
    % L3 = string:lexemes(lists:nth(2, L2), " "),
    % L3,
    L2Len = length(L2),
    L2Len,
    split2(L2, 1, L2Len).