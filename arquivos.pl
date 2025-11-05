%%% ===== fatos básicos =====
mago(gandalf).
mago(merlin).
mago(arthur).

%%% ===== 1 - Todo mago lança algum feitiço (opção de regra ou fatos concretos) =====
lanca(gandalf, bola_de_fogo).

%%% ===== 2 - Existe um mago que é poderoso =====
poderoso(merlin).
mago_poderoso(X) :- mago(X), poderoso(X).

%%% ===== 3 - Se um mago é poderoso, então ele pode derrotar qualquer outro mago =====
derrota(X, Y) :- mago(X), poderoso(X), mago(Y).

%%% ===== 4 - Algum mago não é aliado de nenhum outro =====
aliado(gandalf, merlin).

% nao_aliado_de_nenhum(X) é verdadeiro se X é mago e não existe nenhum Y (mago, Y\=X) tal que aliado(X,Y)
nao_aliado_de_nenhum(X) :-
    mago(X),
    \+ ( mago(Y), Y \= X, aliado(X, Y) ).

%%% ===== 5 - Se um mago derrota outro, então ele é mais poderoso que o derrotado =====
% regra de implicação para "mais poderoso"
mais_poderoso_que(X, Y) :- mago(X), mago(Y), derrota(X, Y).

%%% ===== 6 - Todo mago que lança um feitiço é considerado poderoso =====
% esta regra fará com que TODO mago seja poderoso.
poderoso(X) :- mago(X), lanca(X, _).

%%% ===== 7 - Todo mago tem algum aliado =====
aliado(X, aliado_de(X)) :- mago(X).

todos_magos_tem_aliado :-
    \+ ( mago(X), \+ aliado(X, _) ).

%%% ===== 8 - Nenhum mago derrota a si mesmo =====
derrota_no_self(X, Y) :- mago(X), poderoso(X), mago(Y), X \= Y.
nenhum_mago_derrota_si_mesmo :-
    \+ ( mago(X), derrota_no_self(X, X) ).

%%% ===== 9 - Algum mago lança um feitiço =====
mago(gandalf).
lanca(gandalf, bola_de_fogo).

%%% ===== 10 - Existe um mago que derrota todos os outros =====
campeao(X) :-
    mago(X),
    \+ ( mago(Y), Y \= X, \+ derrota(X, Y) ).
