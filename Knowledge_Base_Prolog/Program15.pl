%240 - Pirate 'Quest' using knowledge base

start_state(begin_voyage).

%define the edges of the finite state diagram

next_state(begin_voyage, a, crew_member_dilemma).
next_state(begin_voyage, b, begin_voyage).

next_state(crew_member_dilemma, a, sailing).
next_state(crew_member_dilemma, b, sailing).

next_state(sailing, a, sailing).
next_state(sailing, b, dreaded_pirate).
next_state(sailing, c, sailing).
next_state(sailing, d, treasure).

next_state(dreaded_pirate, a, killed) :-
    stored_answer(charitable, no).
next_state(dreaded_pirate, b, killed) :-
    stored_answer(charitable, no).
next_state(dreaded_pirate, a, tragic_sacrifice) :-
    stored_answer(charitable, yes).
next_state(dreaded_pirate, b, tragic_sacrifice) :-
    stored_answer(charitable, yes).

next_state(tragic_sacrifice, a, treasure).
next_state(tragic_sacrifice, b, retire).

%code to be executed at the beginning

display_intro :-
    write('Pirate Simulator'), nl, nl,
    write('You are a farmer recently forced to turn to the pirate trade '), nl,
    write('after your herd of cows formed a union and it became too  '), nl,
    write('expensive to pay for their medical insurance. '), nl,
    write('Let us see how you fare on the high seas as a pirate.'), nl.

initialize :-
    asserta(stored_answer(moves, 0)),
    asserta(stored_answer(doubloons, 1000)),
    asserta(stored_answer(charitable, no)).

%code to be executed at the end

goodbye :-
    stored_answer(moves, Count),
    write( 'You made this many moves...' ),
    write( Count ), nl,
    stored_answer(doubloons, Amount),
    write( 'You have this many doubloons...' ),
    write( Amount ), nl,
    write( 'I hope you enjoyed your journey' ), nl.

%code to be executed upon reaching each state

show_state(begin_voyage) :-
    write( 'You ready your sails and set upon the high seas with' ), nl,
    write( 'a group of men you have come to trust after years of' ), nl,
    write( 'working with on your now defunct farm.' ), nl, nl,
    write( 'Begin Voyage?' ), nl,
    write( '(a) Yes' ), nl,
    write( '(b) No' ), nl,
    write( '(q) Quit the program' ), nl.

show_state(crew_member_dilemma) :-
    write( 'One of your crew members and longtime friends, ScurvyLegs,'), nl,
    write( 'comes up to you meekly and asks for a huge show of empathy from you.'), nl,
    write( 'His wife Mrs. ScurvyLegs has contracted yellow fever and is in need'), nl,
    write( 'of specialized medicine in order to live through the sickness.'), nl,
    write( 'He requests 300 doubloons to pay for her medication.'), nl, nl,
    write( 'You currently have 1000 doubloons, but losing that many doubloons'), nl,
    write( 'could leave you unable to pay ransom demands from enemy pirates. '), nl, nl,
    write( 'What do you do?' ), nl,
    write( '(a) Give ScurvyLegs 300 doubloons' ), nl,
    write( '(b) Keep the 300 doubloons' ), nl,
    write( '(q) Quit the program'), nl.

show_state(sailing) :-
    write( 'You continue sailing the seas, but in which direction?' ), nl,
    write( '(a) North' ), nl,
    write( '(b) East' ), nl,
    write( '(c) South' ), nl,
    write( '(d) West' ), nl,
    write( '(q) Quit the program' ), nl.

show_state(dreaded_pirate) :-
    write( 'Your crew gives it their all to fight back,'), nl,
    write( 'especially ScurvyLegs, who wishes to see his wife again. '), nl,
    write( 'Alas, your ship is overtaken by the enemy.' ), nl,
    write( 'The opposing captain raise his cutlass to execute you'), nl,
    write( 'and asks if you have any last words.'), nl,
    write( 'What do you say?' ), nl,
    write( '(a) Plead for your life; offer doubloons' ), nl,
    write( '(b) Say honourable last words'), nl,
    write( '(q) Quit the program' ), nl.

show_state(tragic_sacrifice) :-
    write( 'You weep over ScurvyLegs`s corpse. He was a loyal to the end, '), nl,
    write( 'the best crew member and friend one could ever ask for. '), nl,
    write( 'A small but beautiful uninhibited island is found and you '), nl,
    write( 'and the rest of your crew hold a worthy burial for ScurvyLegs. '), nl,
    write( 'After the burial, you decide you must continue on, it`s what'), nl,
    write( 'ScurvyLegs would have wanted. '),nl,
    write( 'In which direction do you sail?' ), nl,
    write( '(a) North' ), nl,
    write( '(b) South' ), nl,
    write( '(q) Quit the program' ), nl.

%final states; do not display a menu - automatically quit ('q')

show_state(killed) :-
    write( 'In one fell swoop, the enemy captain swings his cutlass and'), nl,
    write( 'ends your short-lived pirate career and your life. RIP.'), nl,
    retract(stored_answer(doubloons, _)),
    assert(stored_answer(doubloons, 0)).

show_state(retire) :-
    write( 'You decide to quit while you`re ahead and return home with'), nl,
    write( 'your remaining crew. Once home, you find Mrs. ScurvyLegs'), nl,
    write( 'and buy her the medicine she needs to survive the Yellow Fever.'), nl,
    write( 'She is devastated to hear the news about her husband and'), nl,
    write( 'treasures his spy glass that you saved for the rest'), nl,
    write( 'of her days.'), nl.

show_state(treasure) :-
    write( 'You land your ship on the island.' ), nl,
    write( 'Crew members look around until one of them finds a map.'), nl,
    write( 'You follow the directions on the map, which lead you to'), nl,
    write( 'a hidden treasure chest further inland. Inside are all'), nl,
    write( 'the doubloons you would ever need! You return home safely'), nl,
    write( 'with the rest of your crew. Mrs. ScurvyLegs is able to '), nl,
    write( 'receive the medicine she needs to survive the Yellow Fever.'), nl,
    write( 'You are able to retire, never having to return to a life of'), nl,
    write( 'piracy. The atrocities you encountered at sea, however, '), nl,
    write( 'never leave your memories. '), nl,
    stored_answer(doubloons, Amount),
    retract(stored_answer(doubloons, _)),
    NewAmount is Amount + 999300,
    assert(stored_answer(doubloons, NewAmount)).


get_choice(killed, q).
get_choice(retire, q).
get_choice(treasure, q).

%code to be executed for each choice of action from each state

show_transition(begin_voyage, a) :-
    write( 'All hands hoay!' ), nl.
show_transition(begin_voyage, b) :-
    write( 'Very funny. Can we begin now?'), nl.

show_transition(crew_member_dilemma, a) :-
    write( 'ScurvyLegs: "I will forever be indebted to you, my captain."'), nl,
    write( 'You now have 700 doubloons' ), nl,
    retract(stored_answer(charitable, no)),
    asserta(stored_answer(charitable, yes)),
    stored_answer(doubloons, Amount),
    retract(stored_answer(doubloons, _)),
    NewAmount is Amount - 300,
    asserta(stored_answer(doubloons, NewAmount)).
show_transition(crew_member_dilemma, b) :-
    write( 'ScurvyLegs: "I understand captain, all I can hope for now'), nl,
    write( '             is to strike big on treasure... '), nl.

show_transition(sailing, a) :-
    write( 'You sail North for days, but find nothing of interest.'), nl,
    write( 'Try steering in a different direction.'), nl.
show_transition(sailing, b) :-
    write( 'You see a red flag in the distance, the flag symbolizes'), nl,
    write( 'bloodshed. They ready their cannons and draw closer.'), nl.
show_transition(sailing, c) :-
    write( 'You sail South for days, but find nothing of interest.'), nl,
    write( 'Try steering in a different direction.'), nl.
show_transition(sailing, d) :-
    write( 'After sailing West for several more days, ScurvyLegs spots '), nl,
    write( 'an island in the distance. This island isn`t on the map '), nl,
    write( 'but you decide to take a chance. ' ), nl.

show_transition(dreaded_pirate, a) :-
    stored_answer(charitable, no),
    write( 'You plead with the rival ship captain, offering him '), nl,
    write( 'all the doubloons you have in exchange for mercy.'), nl,
    write( 'He scoffs: "You think your measly 1000 doubloons are'), nl,
    write( '            enough for me break my belief of taking no'),nl,
    write( '            prisoners?'), nl.

show_transition(dreaded_pirate, b):-
    stored_answer(charitable, no),
    write( 'Hurry up scallywag! I could kill ten men while you`re'), nl,
    write( 'fooling around!'), nl,
    write( 'The captain is not impressed.'), nl,
    write( 'He scoffs: "As you wish" '), nl.

show_transition(dreaded_pirate, a) :-
    stored_answer(charitable, yes),
    write( 'You plead with the rival ship captain, offering him '), nl,
    write( 'all the doubloons you have in exchange for mercy.'), nl,
    write( 'He scoffs: "You think your measly 700 doubloons are '), nl,
    write( '            enough for me break my belief of taking no'), nl,
    write( '            prisoners?'), nl,
    write( 'As he swings his cutlass to end your life, ScurvyLegs'), nl,
    write( 'jumps in front of you, taking the fatal blow.'), nl,
    write( 'in this moment you are able to pull out your dagger and'), nl,
    write( 'stab the captain, saving yourself and the rest of your crew'), nl.

show_transition(dreaded_pirate, b) :-
    stored_answer(charitable, yes),
    write( 'Hurry up scallywag! I could kill ten men while you`re'), nl,
    write( 'fooling around!'), nl,
    write( 'The captain is not impressed.'), nl,
    write( 'He scoffs: "As you wish" '), nl,
    write( 'As he swings his cutlass to end your life, ScurvyLegs'), nl,
    write( 'jumps in front of you, taking the fatal blow.'), nl,
    write( 'in this moment you are able to pull out your dagger and'), nl,
    write( 'stab the captain, saving yourself and the rest of your crew'), nl.

show_transition(tragic_sacrifice, a) :-
    write( 'You steer your ship northward'), nl,
    write( 'Perhaps you could have brushed up on your navigation skills'), nl,
    write( 'because you once again encounter the island ScurvyLegs'), nl,
    write( 'was buried. Something is drawing you in...'), nl,
    write( 'almost as though your old friend is signalling you to'), nl,
    write( 'once again land on this mysterious island.'), nl.
show_transition(tragic_sacrifice, b) :-
    write( 'After traveling southward for several days, supplies'),nl,
    write( 'are diminishing and there is still no treasure in sight.'), nl.

% in case anything goes wrong

show_transition(begin_voyage, fail) :-
    write( 'a,b,c,d, or q'), nl.
show_transition(crew_member_dilemma, fail) :-
    write( 'a,b,c,d, or q'), nl.
show_transition(sailing, fail) :-
    write( 'a,b,c,d, or q'), nl.
show_transition(dreaded_pirate, fail) :-
    write( 'a,b,c,d, or q'), nl.
show_transition(tragic_sacrific, fail) :-
    write( 'a,b,c,d, or q'), nl.

% basic finite state machine engine

go :-
	intro,
	start_state(X),
	show_state(X),
	get_choice(X,Y),
	go_to_next_state(X,Y).

intro :-
	display_intro,
	clear_stored_answers,
	initialize.

go_to_next_state(_,q) :-
	goodbye,!.

go_to_next_state(S1,Cin) :-
	next_state(S1,Cin,S2),
	show_transition(S1,Cin),
	show_state(S2),
	stored_answer(moves,K),
	OneMoreMove is K + 1,
	retract(stored_answer(moves,_)),
	asserta(stored_answer(moves,OneMoreMove)),
	get_choice(S2,Cnew),
	go_to_next_state(S2,Cnew).

go_to_next_state(S1,Cin) :-
	\+ next_state(S1,Cin,_),
	show_transition(S1,fail),
	get_choice(S1,Cnew),
	go_to_next_state(S1,Cnew).

get_choice(_,C) :-
    write('Next entry (letter followed by a period)? '),
    read(C),
    nl.

% case knowledge base - user responses

:- dynamic(stored_answer/2).

% procedure to get rid of previous responses
% without abolishing the dynamic declaration

clear_stored_answers :- retract(stored_answer(_,_)),fail.
clear_stored_answers.
