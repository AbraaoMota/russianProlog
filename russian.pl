:- use_module(library(lists)).

% prolog


add_to_end([X], NewLetter, Intermediate, NewWord) :-
	Int2 = [NewLetter, X],
	append(Int2, Intermediate, Int3),
	reverse(Int3, NewWord).

add_to_end([X|Xs], NewLetter, Intermediate, NewWord) :-
	add_to_end(Xs, NewLetter, [X|Intermediate], NewWord).


ending([X], X).
ending([_|Xs], Ending) :-
	ending(Xs, Ending).
	

remove_end([_], Intermediate, NewWord) :-
	reverse(Intermediate, NewWord).
remove_end([X|Xs], Intermediate, NewWord) :-
	remove_end(Xs, [X|Intermediate], NewWord).

prep_sing(Word, feminine, NewWord) :-
	ending(Word, Ending),
	(Ending == '`' ->
		add_to_end(Word, 'i', [], NewWord)
	;
		% Assume ending is 'ya'
		add_to_end(Word, 'i', [], InterWord),
		add_to_end(InterWord, 'i', [], NewWord)
	).


%If ends in 'iye', change to 'ii', otherwise has a normal prep ending like masculine nouns (ye)

prep_sing(Word, neuter, NewWord) :-
	ending(Word, E1),
	remove_end(Word, [], W1),
	ending(W1, E2),
	((E1 == 'ye', E2 == 'i' ) ->
		remove_end(Word, [], W1),
		add_to_end(W1, 'i', [], NewWord)
	;
		remove_end(Word, [], W1),
		add_to_end(Word, 'ye', [], NewWord)
	).

prep_sing(Word, masculine, NewWord) :-
	add_to_end(Word, 'ye', [], NewWord).

%acc_sing(Word) :-

