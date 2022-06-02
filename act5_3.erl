-module(act5_3).
-export([readlines/1, get_all_lines/1, run/1, split2/4]).
-export([join2/4,operaciones/2]).


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

join2(N1,O,N2,SOut) -> if
    O == "+" -> io:format(SOut,"~p~n", [N1 + N2]);
    O == "-" -> io:format(SOut,"~p~n", [N1 - N2]);
    O == "*" -> io:format(SOut,"~p~n", [N1 * N2]);
    O == "/" -> io:format(SOut,"~p~n", [N1 / N2]);
    O == "%" -> io:format(SOut,"~p~n", [N1 rem N2]);
    true -> io:format("No support for negative numbers. ̃n")

end.

split2(L, I, N,SOut)-> 
    if I < (N + 1) ->
        L0 = string:lexemes(hd(L), " "),
        N1 = list_to_integer(lists:nth(1, L0)),
        Operador = lists:nth(2, L0),
        N2 = list_to_integer(lists:nth(3, L0)),
        
        %Aqui hay que poner que gusrade el elemento que le amnde Operations
        join2(N1, Operador, N2,SOut),
        M = tl(L),
        if M /= [] ->
            split2(M, I+1, N,SOut);
            true -> io:format("Lectura terminada~n")
        end;

    true -> split2(tl(L), I+1, N,SOut)
end.

operaciones(FileIn,FileOut)->
    L1 = readlines(FileIn),
    L2 = string:lexemes(L1, "\n"),
    L2Len = length(L2),
    {ok, SOut} = file:open(FileOut, [write]),
    split2(L2, 1, L2Len,SOut).

% Parametro de inicio -> "case"
run(FileName) ->

    FileIn1 = FileName ++ "1.in",
    FileOut1 = FileName ++ "1.out",
    operaciones(FileIn1,FileOut1),
    FileIn2 = FileName ++ "2.in",
    FileOut2 = FileName ++ "2.out",
    operaciones(FileIn2,FileOut2),
    FileIn3 = FileName ++ "3.in",
    FileOut3 = FileName ++ "3.out",
    operaciones(FileIn3,FileOut3),
    FileIn4 = FileName ++ "4.in",
    FileOut4 = FileName ++ "4.out",
    operaciones(FileIn4,FileOut4).