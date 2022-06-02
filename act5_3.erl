-module(act5_3).
-export([readlines/1, get_all_lines/1,  runSequencial/1, split2/4, runParallel/1, operacionP/2]).
-export([join2/4]).

-import(timer, [now_diff/2]).


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

% Parametro de inicio -> "case"
runSequencial(FileName) ->
    T1 = time(),
    FileIn1 = FileName ++ "1.in",
    FileOut1 = FileName ++ "1.out",
    FileIn2 = FileName ++ "2.in",
    FileOut2 = FileName ++ "2.out",
    FileIn3 = FileName ++ "3.in",
    FileOut3 = FileName ++ "3.out",
    FileIn4 = FileName ++ "4.in",
    FileOut4 = FileName ++ "4.out",

    L1_1 = readlines(FileIn1),
    L1_2 = string:lexemes(L1_1, "\n"),
    L1_2Len = length(L1_2),
    {ok, SOut1} = file:open(FileOut1, [write]),
    split2(L1_2, 1, L1_2Len,SOut1),

    L2_1 = readlines(FileIn2),
    L2_2 = string:lexemes(L2_1, "\n"),
    L2_2Len = length(L2_2),
    {ok, SOut2} = file:open(FileOut2, [write]),
    split2(L2_2, 1, L2_2Len,SOut2),
    
    L3_1 = readlines(FileIn3),
    L3_2 = string:lexemes(L3_1, "\n"),
    L3_2Len = length(L3_2),
    {ok, SOut3} = file:open(FileOut3, [write]),
    split2(L3_2, 1, L3_2Len,SOut3),

    L4_1 = readlines(FileIn4),
    L4_2 = string:lexemes(L4_1, "\n"),
    L4_2Len = length(L4_2),
    {ok, SOut4} = file:open(FileOut4, [write]),
    split2(L4_2, 1, L4_2Len,SOut4),

    T2 = time(),
    TimeIs = now_diff(T2,T1),
    io:format("~p~n",[TimeIs]).


operacionP(FileIn,FileOut) -> 
    T1 = time(),

    L1_1 = readlines(FileIn),
    L1_2 = string:lexemes(L1_1, "\n"),
    L1_2Len = length(L1_2),
    {ok, SOut1} = file:open(FileOut, [write]),
    split2(L1_2, 1, L1_2Len,SOut1),

    T2 = time(),
    TimeIs = now_diff(T2,T1),
    io:format("Tiempo ~p~n",[TimeIs]).

runParallel(FileName) -> 
    FileIn1 = FileName ++ "1.in",
    FileOut1 = FileName ++ "1.2.out",
    FileIn2 = FileName ++ "2.in",
    FileOut2 = FileName ++ "2.2.out",
    FileIn3 = FileName ++ "3.in",
    FileOut3 = FileName ++ "3.2.out",
    FileIn4 = FileName ++ "4.in",
    FileOut4 = FileName ++ "4.2.out",

    spawn(act5_3,operacionP,[FileIn1,FileOut1]),
    spawn(act5_3,operacionP,[FileIn2,FileOut2]),
    spawn(act5_3,operacionP,[FileIn3,FileOut3]),
    spawn(act5_3,operacionP,[FileIn4,FileOut4]).