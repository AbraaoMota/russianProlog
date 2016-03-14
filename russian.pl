:- use_module(library(lists)).

% prolog



% This is a little tool to help with learning russian, prolog style.


% The methods take a list of letters (a word) and output the correspondent output


% Due to coding limitations and language barriers, output and input will follow a phonetic approach, 
% using the following mapping

/*


а = a
б = b
в = v
г = g
д = d
е = ye
ё = yo
ж = xh
з = z
и = i
й = y
к = k
л = l
м = m
н = n
о = o
п = p
р = r
с = s
т = t
у = u
ф = f
х = h
ц = ts
ч = ch
ш = sh
щ = tsch
ъ = _ ??
ы = ui
ь = `
э = e
ю = yu
я = ya

*/


%% add_to_end([X|Xs], InitCopy, NewLetter, Intermediate, NewWord) :-
%% 	Ending = [X|NewLetter],
%% 	NewWord = [Intermediate|Ending].
%% add_to_end([X|Xs], InitCopy, , NewLetter, Intermediate, NewWord) :-
%% 	add_to_end([X|Xs], [Xs], NewLetter, [X|Intermediate], NewWord).


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

