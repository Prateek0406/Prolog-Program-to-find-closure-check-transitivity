

/*MEMBERSHIP RELATION*/
is_member(X,[X|Tail]).
is_member(X,[Head|Tail]):- is_member(X,Tail).


/*EXTRACT THE ELEMENTS OF A GIVEN TUPLE*/
extract((A,B),A,B). 

/*MAKE  A TUPLE GIVEN TWO ELEMENTS*/
make_tuple(A,B,(A,B)). 

/*FUNCTION RETURNS â€˜TRUEâ€™ IF THE GIVEN LIST OF RELATION IS TRANSTIVE, RETURNS FALSE OTHERWISE*/ 
is_transitive(List):- is_member(X,List), check(List,X,List).

/*FUNCTION TO CHECK TRANSITIVITY*/
check(List,(_,_),[]).
check(List,X,Smaller_List):- extract(X,A,B), make_tuple(B,Y,New_tuple), ((is_member(New_tuple,List)) -> make_tuple(A,Y,Tuple3), is_member(Tuple3,List); true),
next(Z,Smaller_List,Smaller_List1), check(List,Z,Smaller_List1).

/*FUNCTION TO CHOP THE HEAD OFF OF A GIVEN LIST RETURN IT*/
next(H,[H|T],T).

/*FUNCTION TO CONCATINATE TWO LISTS*/
appendl([],L,L).
appendl([H|T],L2,[H|L3]):- appendl(T,L2,L3). 



/*FUNCTION THAT RETURN THE TRANSITIVE CLOSURE OF A GIVEN RELATION LIST*/
find_closure(List,Solution):- appendl(List,[],Solution1), is_member(Z,List), add_l(List,Solution1,Z,Solution_2), appendl(Solution_2,List,Solution).


/*FUNCTION TO ADD NEW ELEMENTS TO TRANSITIVE CLOSRE*/
add_l(L,Smaller_List,X,Solution):- extract(X,A,B), make_tuple(B,Y,New_tuple),

( 
	(is_member(New_tuple,L) ) -> 

	( 
		
		  (make_tuple(A,Y,H), \+is_member(H,L) )  -> 
		  (
		  	
		  	 appendl([H],L,Solution_1) , is_member(New_first,Solution_1), add_l(Solution_1,Solution_1,New_first,Solution_2), 
		     appendl(Solution_2,[H],Solution)
		  )

	        ; 

		     next(Z, Smaller_List, Smaller_List1), add_l(L,Smaller_List1,Z,Solution)
	)
	
	;
	 
	next(Z, Smaller_List, Smaller_List1), add_l(L,Smaller_List1,Z,Solution)
).
add_l(List,[],(_,_),Solution).




