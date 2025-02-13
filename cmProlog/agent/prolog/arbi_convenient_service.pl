:- module(arbi_convenient_service,
    [
    current_visible_on_Physical/2,
    on_Physical/2,
    %in_Physical/2,
    misPlaced_item/1,
    fully_empty_displayShelf/2,
    partially_empty_displayShelf/2,
    on_Physical_count/3,
	  displayShelfFor/2,
	  wellPlaced_item/1,
    on_placementpoint/2
    ]).


getAngle(Radian, Angle):-
   Angle is ( Radian * (180/3.14)).
getRadian(Angle, Radian):-
   Radian is ( Angle * (3.14 / 180)).


%getOrientatedPoint(Object, OrientatedPoint):-
%.

current_visible_on_Physical(Top, Bottom) :-
    rdfs_individual_of(Top,  knowrob:'SpatialThing-Localized'),not(rdfs_individual_of(Top, knowrob:'ShelfInABuilding')),
    rdfs_individual_of(Bottom,  knowrob:'ShelfInABuilding'),
    Top \= Bottom,

	currentVisibleObjectPose(Top, Tpose),
	semanticObjectPose(Bottom, Bpose),
	
    objectSize(Top, Tsize),
    objectSize(Bottom, Bsize),
    [TX,TY,TZ,ToX, ToY, ToZ, ToW|_]=Tpose,    
    [BX,BY,BZ, BoX, BoY, BoZ, BoW|_]=Bpose,
    [_,_,TH|_]=Tsize,
    [BD,BW,BH|_]=Bsize,
    <( BZ, TZ ),
    THhalf is TH*0.5,
    BHhalf is BH*0.5,
    abs((TZ-THhalf) - (BZ+BHhalf))<0.05,
 
    =<( (BX - (BD*0.5)), TX ), >=( (BX + (BD*0.5)), TX ),
    =<( (BY - (0.5*BW)), TY ), >=( (BY + (0.5*BW)), TY ).
%TopX,..., TopOrientationX
on_Physical(Top, Bottom) :-
    findall([T, B], on_Physical2(T, B),TB),
    findall([T2, SB],(member(E,TB),nth0(0,E,T2),nth0(1,E,B2),rdf(B2,knowrob:'physicalPartOf',SB)),TB2),
    findall(E2,(member(E2,TB),not(member(E2,TB2))),TB3),append(TB3,TB2,TB4),
    member(E3,TB4),nth0(0,E3,Top),nth0(1,E3,Bottom).
   
on_Physical2(Top, Bottom) :-
        currentObjectPose(Top, Tpose),
	semanticObjectPose(Bottom, Bpose),
    rdfs_individual_of(Top,  knowrob:'SpatialThing-Localized'),not(rdfs_individual_of(Top, knowrob:'ShelfInABuilding')),
    rdfs_individual_of(Bottom,  knowrob:'ShelfInABuilding'),
    Top \= Bottom,

	%currentObjectPose(Top, Tpose),
	%semanticObjectPose(Bottom, Bpose),
	
    objectSize(Top, Tsize),
    objectSize(Bottom, Bsize),
    [TX,TY,TZ,ToX, ToY, ToZ, ToW|_]=Tpose,    
    [BX,BY,BZ, BoX, BoY, BoZ, BoW|_]=Bpose,
    [_,_,TH|_]=Tsize,
    [BD,BW,BH|_]=Bsize,
    <( BZ, TZ ),
    THhalf is TH*0.5,
    BHhalf is BH*0.5,
    abs((TZ-THhalf) - (BZ+BHhalf))<0.05,
 
    =<( (BX - (BD*0.5)), TX ), >=( (BX + (BD*0.5)), TX ),
    =<( (BY - (0.5*BW)), TY ), >=( (BY + (0.5*BW)), TY ).
%temp
/*
in_Physical(Item, Container) :-
    nb_getval(arbi_convenient_service_in_Physical_intersectPer_threshold, IntersectPer_threshold),
    rdfs_individual_of(Item,  knowrob:'SpatialThing-Localized'),
    rdfs_individual_of(Container,  knowrob:'SpatialThing-Localized'),
    Item \= Container,

	currentObjectPose(Item, Ipose),
	semanticObjectPose(Container, Cpose),
	
    objectSize(Item, Isize),
    objectSize(Container, Csize),

    vertex(Ipose, Isize, Ivertice),
    vertex(Cpose, Csize, Cvertice),
    intersects2(Ivertice,Cvertice,IntersectPer),
    IntersectPer >= IntersectPer_threshold.
*/
%typed_misplaced_item(-Item, +ItemType, +Shelf):-
%typed_misplaced_item(Item, ItemType, Shelf):-
%	rdf(Shelf, knowrob:'physicalPartOf', ShelfType),
%    on_Physical(Item, ShelfType),
%	misplaced_item(Item),
%    not(type(Item, ItemType)).





on_placementpoint(Item, Placementpoint):-
  %currentObjectPose(Item, Tpose),
  %rdf(Shelf, knowrob:'locatedAtPoint-Spatial', Placementpoint),
  on_Physical(Item,Shelf),
  rdf(Shelf, knowrob:'locatedAtPoint-Spatial', Placementpoint),

  %물체자리 포인틀를 가지고옴
  rdf(Placementpoint, knowrob:'m03',literal(type(_,SIx))),atom_to_term(SIx,SIX,_),
  rdf(Placementpoint, knowrob:'m13',literal(type(_,SIy))),atom_to_term(SIy,SIY,_),


  %물체의 중심점 좌표를 구함
  currentObjectPose(Item,ItemPose),
  [IX,IY|_]=ItemPose,


  %물체의 크기를 가지고옴
  objectSize(Item,ItemSize),
  [ID,IW|_]=ItemSize,

  %조건3 물체가 각 영역안의 포인트 반경 내에 있는지 확인
  =<( (SIX - (ID*0.74)), IX ), >=( (SIX + (ID*0.74)), IX ),
    =<( (SIY - (0.74*IW)), IY ), >=( (SIY + (0.74*IW)), IY ).
  



wellPlaced_item(Item):-
  %조건1 어딘가 위에 올라가있어야함 
  on_Physical(Item,Shelf),
  rdf(Item, rdf:type, ItemType),
  rdf(Shelf, knowrob:'physicalParts', ShelfType),
  
  %조건2 shelfType의 ItemType과 현재 Item의 Type이 일치해야함
  displayShelfFor(ShelfType,ItemType),
  
  %영역의 크기를 구함
  rdf(ShelfType, knowrob:depthOfObject, literal(type(_,Sd))),atom_to_term(Sd,SD,_),
  rdf(ShelfType, knowrob:widthOfObject, literal(type(_,Sw))),atom_to_term(Sw,SW,_),

  rdf(ShelfType, knowrob:'locatedAtPoint-Spatial', Placementpoint),
  on_placementpoint(Item, Placementpoint).







%misplaced_item(-Item)
misPlaced_item(Item):-
   on_Physical(Item,Shelf),
   not(rdf(Shelf,rdf:type,knowrob:'Shelf')),
   not(rdf('http://www.arbi.com/ontologies/arbi.owl#storageRack_1', knowrob:'physicalParts', Shelf)),
   not(rdf('http://www.arbi.com/ontologies/arbi.owl#displayRack_1', knowrob:'physicalParts', Shelf)),
   not(rdf('http://www.arbi.com/ontologies/arbi.owl#displayRack_2', knowrob:'physicalParts', Shelf)),
   not(graspedBy(Item,Hand)),
   not(wellPlaced_item(Item)).

on_Physical_count(Count, Top, Bottom):-
  findall(Top, on_Physical(Top, Bottom),Objects),
  length(Objects, Count).

%displayShelfFor(+Shelf, -ItemType)
displayShelfFor(Shelf, ItemType):-
  rdfs_individual_of(Shelf, knowrob:'ShelfInABuilding'),
  rdf(Shelf, knowrob:'typePrimaryFunction-StoragePlaceFor', ItemType).

fully_empty_displayShelf(Shelf, Rack):-
  rdf(Rack, knowrob:'physicalParts', ShelfType),
  rdf(ShelfType, knowrob:'physicalParts', Shelf),
  not(on_Physical(Item,Shelf)).

partially_empty_displayShelf(Shelf, Rack):-
  distinct(pre_partially_empty_displayShelf(Shelf,Rack)).

pre_partially_empty_displayShelf(Shelf, Rack):-	
  rdf(Rack, knowrob:'physicalParts', ShelfType),
  rdf(ShelfType, knowrob:'physicalParts', Shelf),
  rdf(Shelf, knowrob:'locatedAtPoint-Spatial', Placementpoint),
  not(fully_empty_displayShelf(Shelf, Rack)),
  not(on_placementpoint(Item, Placementpoint)).

