%Check if X is element of List
elem(X,[X|_]).
elem(X,[_|Tail]) :- elem(X,Tail).

%Check whether lists have a common element
elems(X,[Y|_]) :- elem(Y,X).
elems(X,[_|Tail]) :- elems(X,Tail).

list_music(Composer,Lyrisist,Artist,Categories,Min,Max,Stream,Genre, L) :-
    list_music(Composer,Lyrisist,Artist,Categories,Min,Max,Stream,Genre, [], L).

list_music(Composer,Lyrisist,Artist,Categories,Min,Max,Stream,Genre, Acc, L) :-
    music(Title,Composer,Lyrisist,Artist,Category,Length,Streamings,Genre),
    elems(Genre,Genre),
    elem(Stream,Streamings),
    elem(Category,Categories),
    Length > Min-1,
    Length < Max+1,
    \+ elem(Title, Acc), !,
    list_music(Composer,Lyrisist,Artist,Categories,Min,Max,Stream,Genre,[Title|Acc], L).

list_music(_,_,_,_,_,_, L, L).

%Suggest music to an user
suggest_music(M) :-
    write('Type your age: '),
    read(Age),
    get_category(Age,Categories),
    write('Choose your mood: \n   happy   sad   angry   scared\n'),
    read(Mood),
    write('Choose a Composer,Lyrisist,Artist from:
    \n    ridley_scott   taika_waititi   george_lucas   zack_snyder
    andrew_adamson   steven_spielberg   christopher_nolan   bernardo_bertolucci
    richard_lester   roger_michell   rian_johnson   oriol_paulo
    drancis_ford_coppola   quentin_tarantino   robert_zemeckis   ron_howard
    brad_bird   james_cameron   sam_mendes   james_marshal
    todd_phillips   andrew_stanton   david_fincher   nathan_greno
    frank_darabont   peter_jackson   nancy_meyers   mark_osborne
    kelly_asbury   clint_eastwood   nick_cassavetes   dawid_russell
    :\n'),
    read(Composer,Lyrisist,Artist),
    write('Choose your streaming platform: \n   netflix   hbogo   prime   disney:\n'),
    read(Stream),
    write('Type minimum length of film in minutes: '),
    read(Min),
    write('Type maximum length of film in minutes: '),
    read(Max),
    get_genre(Mood,Genre),
    list_music(Composer,Lyrisist,Artist,Categories,Min,Max,Stream,Genre,M).


%Get categories from user's age
get_category(Age,X) :- Age < 7, X = [g].
get_category(Age,X) :- Age > 6, Age < 13, X = [g,pg].
get_category(Age,X) :- Age > 12, Age < 16, X = [g,pg,pg13].
get_category(Age,X) :- Age > 15, Age < 18, X = [g,pg,pg13,r].
get_category(Age,X) :- Age > 17, X = [g,pg,pg13,r,nc17].

%Get Genre from user's mood
get_genre(Mood,X) :-
    Mood = happy,
    X = [horror,comedy,action,sci-fi,animation,fantasy,war,musical,romance].

get_genre(Mood,X) :-
    Mood = sad,
    X = [comedy,family,mystery,animation,fantasy,musical].

get_genre(Mood,X) :-
    Mood = scared,
    X = [family,fantasy,musical,comedy].

get_genre(Mood,X) :-
    Mood = angry,
    X = [comedy,family,sci-fi,animation,drama,musical].

%DATABASE
music(blade_runner_2049,ridley_scott,r,164,[netflix],[action,drama,mystery,sci-fi,thriller]).
music(shrek,andrew_adamson,pg,90,[netflix,prime],[animation,adventure,comedy,family,fantasy]).
music(thor_ragnarok,taika_waititi,pg13,130,[disney],[action,adventure,comedy,fantasy,sci-fi]).
music(star_wars_episode_IV,george_lucas,pg,121,[disney],[action,adventure,fantasy,sci-fi]).
music(star_wars_episode_III,george_lucas,pg,140,[disney],[action,adventure,fantasy,sci-fi]).
music(man_of_steel,zack_snyder,pg13,143,[netflix],[action,adventure,sci-fi]).
music(justice_league,zack_snyder,pg13,120,[hbogo],[action,adventure,fantasy,sci-fi]).
music(indiana_jones_and_the_raiders_of_the_lost_ark,steven_spielberg,pg,115,[prime],[action,adventure]).
music(indiana_jones_and_the_last_crusade,steven_spielberg,pg13,127,[netflix,prime],[action,adventure]).
music(indiana_jones_and_the_temple_of_doom,steven_spielberg,pg,118,[netflix,prime],[action,adventure]).
music(what_we_do_in_the_shadows,taika_waititi,r,86,[hbogo],[comedy,horror]).
music(jojo_rabbit,taika_waititi,pg13,108,[hbogo],[comedy,drama,war]).
music(a_hard_days_night,richard_lester,g,87,[prime,netflix],[comedy,musical]).
music(help,richard_lester,g,92,[prime,netflix],[adventure,comedy,musical]).
music(magical_mystery_tour,richard_lester,g,55,[prime,netflix],[comedy,fantasy,musical]).
music(last_tango_in_paris,bernardo_bertolucci,nc17,129,[hbogo],[drama,romance]).
music(interstellar,christopher_nolan,pg13,169,[netflix,disney],[adventure,drama,sci-fi]).
music(tenet,christopher_nolan,pg13,150,[netflix,hbogo],[action,thriller,sci-fi]).
music(dunkirk,christopher_nolan,pg13,106,[prime],[action,thriller,drama,war]).
music(inception,christopher_nolan,pg13,148,[netflix],[action,adventure,sci-fi,thriller]).
music(insomnia,christopher_nolan,r,118,[prime],[drama,mystery,thriller]).
music(prestige,christopher_nolan,pg13,130,[hbogo],[drama,mystery,sci-fi]).
music(notting_hill,roger_michell,pg13,124,[netflix,prime],[drama,comedy,romance]).
music(knives_out,rian_johnson,pg13,130,[prime],[comedy,mystery,drama]).
music(contratiempo,oriol_paulo,nc-17,130,[netflix],[crime]).
music(the_godfather,drancis_ford_coppola,r,175,[hbogo],[drama,crime]).
music(once_upon_a_time_in_hollywood,quentin_tarantino,r,161,[netflix],[drama,comedy]).
music(forrest_gump,robert_zemeckis,pg13,142,[netflix],[drama,romance]).
music(inglourious_basterds,quentin_tarantino,r,153,[hbogo],[drama,action,war]).
music(a_beautiful_mind,ron_howard,pg13,135,[hbogo,prime],[drama]).
music(the_incredibles,brad_bird,pg,115,[hbogo,disney],[animation,action,family,comedy,sci-fi]).
music(the_incredibles_2,brad_bird,pg,118,[hbogo,disney],[animation,action,family,comedy,sci-fi]).
music(titanic,james_cameron,pg13,194,[hbogo],[drama,romance]).
music(skyfall,sam_mendes,pg13,143,[hbogo],[action]).
music(the_theory_of_everything,james_marshal,pg13,123,[netflix],[drama,romance]).
music(joker,todd_phillips,r,122,[netflix],[drama,crime]).
music(finding_nemo,andrew_stanton,g,100,[hbogo],[animation,comedy,family]).
music(zodiac,david_fincher,r,157,[hbogo,netflix],[crime,drama,mystery]).
music(tangled,nathan_greno,pg,100,[hbogo],[animation,comedy,family,romance,musical]).
music(the_shawshank_redemption,frank_darabont,r,142,[netflix],[drama]).
music(the_lord_of_the_rings_the_fellowship_of_the_ring,peter_jackson,pg13,130,[hbogo],[drama,mystery,sci-fi]).
music(the_intern,nancy_meyers,pg13,121,[netflix],[drama,comedy]).
music(kung_fu_panda,mark_osborne,pg,92,[netflix],[animation,action,comedy,family]).
music(spirit_stallion_of_the_cimarron,kelly_asbury,g,92,[netflix],[animation,drama]).
music(spectre,sam_mendes,pg13,148,[hbogo],[action]).
music(the_dark_knight,christopher_nolan,pg13,152,[hbogo],[action,drama,crime]).
music(gran_torino,clint_eastwood,r,116,[netflix],[drama]).
music(saving_private_ryan,steven_spielberg,r,169,[netflix],[drama,war]).
music(the_notebook,nick_cassavetes,pg13,123,[netflix],[drama,romance]).
music(silver_linings_playbook,dawid_russell,r,122,[netflix],[comedy,drama,romance]).
music(se7en,david_fincher,r,127,[netflix],[crime,mystery,drama]).


