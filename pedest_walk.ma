[top]
components : walk_grid

[walk_grid]
type : cell
dim : (10,10)
delay : inertial
defaultDelayTime  : 200
border : nowrapped

% Neighbourhood definition
neighbors : walk_grid(-1,-1) walk_grid(-1,0) walk_grid(-1,1)
neighbors : walk_grid(0,-1)  walk_grid(0,0)  walk_grid(0,1)
neighbors : walk_grid(1,-1)  walk_grid(1,0)  walk_grid(1,1)

% Initialization of dimensional space
initialvalue : 0

%Grid layout
initialCellsValue : pedest_path.val



localtransition : walk_rules




[walk_rules]
% Coordinate cells from current (0,0)
%(E) = (0,1); (W) = (0,-1); (N) = (-1,0); (S) = (1,0);
%(NE) = (-1,1); (NW) = (-1,-1); (SE) = (1,1); (SW) = (1,-1)


% Definition of cell states:
%
% 0 Cell isn't on a defined path. Will accept a pedestrian
% 100 Cell is a blocking obstacle.
%
% -1x1 Cell is free and ready to host Pedestrian 1
% -1x0 Cell occupied by Pedestrian 1 broadcast its direction to surrounding neighbours
% -2x1 Cell is free and ready to host Pedestrian 2
% -2x0 Cell occupied by Pedestrian 2 broadcast its direction to surrounding neighbours
% -3x1 Cell is free and ready to host Pedestrian 3
% -3x0 Cell occupied by Pedestrian 3 broadcast its direction to surrounding neighbours
% -4x1 Cell is free and ready to host Pedestrian 4
% -4x0 Cell occupied by Pedestrian 4 broadcast its direction to surrounding neighbours
%
% Values of directions x:
% 1	pedestrian present and travelling E
% 2	pedestrian present and travelling N-E
% 3	pedestrian present and travelling N
% 4	pedestrian present and travelling N-W
% 5	pedestrian present and travelling W
% 6	pedestrian present and travelling S-W
% 7	pedestrian present and travelling S
% 8	pedestrian present and travelling S-E

%10 Destination Cell for Pedestrian 1
%20 Destination Cell for Pedestrian 2
%30 Destination Cell for Pedestrian 3
%40 Destination Cell for Pedestrian 4


%--------------------------------
%Movement rules for Pedestrian 1
%--------------------------------

%1.1-Rules to make a free cell send a hosting broadcast, accepting incoming pedestrian from particular location
rule : -111 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and  (0,-1) = -110}
rule : -121 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (1,-1) = -120}
rule : -181 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (-1,-1)= -180}
rule : -131 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and  (1,0)  = -130}
rule : -171 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and  (-1,0) = -170}
rule : -141 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (1,1)  = -140}
rule : -161 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (-1,1) = -160}
rule : -151 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and  (0,1)  = -150}

%1.2-Rules to clear current cell as pedestrian is leaving it
rule : 0 0 {(0,0)= -110 and ( (0,1)  = -111 or (0,1)  = 10 )}
rule : 0 0 {(0,0)= -120 and ( (-1,1) = -121 or (-1,1) = 10 )}
rule : 0 0 {(0,0)= -130 and ( (-1,0) = -131 or (-1,0) = 10 )}
rule : 0 0 {(0,0)= -140 and ( (-1,-1)= -141 or (-1,-1)= 10 )}
rule : 0 0 {(0,0)= -150 and ( (0,-1) = -151 or (0,-1) = 10 )}
rule : 0 0 {(0,0)= -160 and ( (1,-1) = -161 or (1,-1) = 10 )}
rule : 0 0 {(0,0)= -170 and ( (1,0)  = -171 or (1,0)  = 10 )}
rule : 0 0 {(0,0)= -180 and ( (1,1)  = -181 or (1,1)  = 10 )}

%1.2.1-Rules to switch direction if pedestrian can't go in a certain way
rule : {if( ((-1,1) = 0 or (-1,1) = 10) and (-1,1) !=?, -120, -180)} 400 {(0,0)= -110 and ( (0,1)  = 100 or (0,1)  = ? or (0,1)  = 10 or (0,1)  = 20 or (0,1)  = 30 or (0,1)  = 40 )}
rule : {if( ((-1,0) = 0 or (-1,0) = 10) and (-1,0) !=?, -130, -110)} 400 {(0,0)= -120 and ( (-1,1) = 100 or (-1,1) = ? or (-1,1) = 10 or (-1,1) = 20 or (-1,1) = 30 or (-1,1) = 40 )}
rule : {if( ((-1,-1)= 0 or (-1,-1)= 10) and (-1,-1)!=?, -140, -120)} 400 {(0,0)= -130 and ( (-1,0) = 100 or (-1,0) = ? or (-1,0) = 10 or (-1,0) = 20 or (-1,0) = 30 or (-1,0) = 40 )}
rule : {if( ((0,-1) = 0 or (0,-1) = 10) and (0,-1) !=?, -150, -130)} 400 {(0,0)= -140 and ( (-1,-1)= 100 or (-1,-1)= ? or (-1,-1)= 10 or (-1,-1)= 20 or (-1,-1)= 30 or (-1,-1)= 40 )}
rule : {if( ((1,-1) = 0 or (1,-1) = 10) and (1,-1) !=?, -160, -140)} 400 {(0,0)= -150 and ( (0,-1) = 100 or (0,-1) = ? or (0,-1) = 10 or (0,-1) = 20 or (0,-1) = 30 or (0,-1) = 40 )}
rule : {if( ((1,0)  = 0 or (1,0)  = 10) and (1,0)  !=?, -170, -150)} 400 {(0,0)= -160 and ( (1,-1) = 100 or (1,-1) = ? or (1,-1) = 10 or (1,-1) = 20 or (1,-1) = 30 or (1,-1) = 40 )}
rule : {if( ((1,1)  = 0 or (1,1)  = 10) and (1,1)  !=?, -180, -160)} 400 {(0,0)= -170 and ( (1,0)  = 100 or (1,0)  = ? or (1,0)  = 10 or (1,0)  = 20 or (1,0)  = 30 or (1,0)  = 40 )}
rule : {if( ((0,1)  = 0 or (0,1)  = 10) and (0,1)  !=?, -110, -170)} 400 {(0,0)= -180 and ( (1,1)  = 100 or (1,1)  = ? or (1,1)  = 10 or (1,1)  = 20 or (1,1)  = 30 or (1,1)  = 40 )}

%1.3-Rules for a pedestrian to determin the direction of their next step
rule : {if((0,1)  !=100 and (0,1)  >=0 and (0,1)  !=? and (0,1)!=20 and (0,1)!=30 and (0,1)!=40 and cellpos(1)!=9, -110, -130)} 0 {(0,0)= -111}
rule : {if((0,1)  !=100 and (0,1)  >=0 and (0,1)  !=? and (0,1)!=20 and (0,1)!=30 and (0,1)!=40 and cellpos(0)=1, -110, -150)} 0 {(0,0)= -111}
rule : {if((-1,1) !=100 and (-1,1) >= 0 and (-1,1) !=? and (-1,1)!=20 and (-1,1)!=30 and (-1,1)!=40 and cellpos(0)!=1, -120, -110)} 0 {(0,0)= -121}
rule : {if((-1,1) !=100 and (-1,1) >= 0 and (-1,1) !=? and (-1,1)!=20 and (-1,1)!=30 and (-1,1)!=40 and cellpos(1)=9, -120, -130)} 0 {(0,0)= -121}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(0)!=1, -180, -110)} 0 {(0,0)= -181}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(1)=9, -180, -170)} 0 {(0,0)= -181}
rule : {if((-1,0) !=100 and (-1,0) >= 0 and (-1,0) !=? and (-1,0)!=20 and (-1,0)!=30 and (-1,0)!=40 and cellpos(0)!=1, -130, -150)} 0 {(0,0)= -131}
rule : {if((-1,0) !=100 and (-1,0) >= 0 and (-1,0) !=? and (-1,0)!=20 and (-1,0)!=30 and (-1,0)!=40 and cellpos(1)=9, -130, -170)} 0 {(0,0)= -131}
rule : {if((1,0)  !=100 and (1,0) >= 0 and (1,0)  !=? and (1,0)!=20 and (1,0)!=30 and (1,0)!=40 and cellpos(0)!=1, -170, -110)} 0 {(0,0)= -171}
rule : {if((1,0)  !=100 and (1,0) >= 0 and (1,0)  !=? and (1,0)!=20 and (1,0)!=30 and (1,0)!=40 and cellpos(1)=9, -170, -130)} 0 {(0,0)= -171}
rule : {if((-1,-1) !=100 and (-1,-1) >= 0 and (-1,-1) !=? and (-1,-1)!=20 and (-1,-1)!=30 and (-1,-1)!=40 and cellpos(0)!=1, -140, -150)} 0 {(0,0)= -141}
rule : {if((-1,-1) !=100 and (-1,-1) >= 0 and (-1,-1) !=? and (-1,-1)!=20 and (-1,-1)!=30 and (-1,-1)!=40 and cellpos(1)=9, -140, -130)} 0 {(0,0)= -141}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(0)!=1, -160, -150)} 0 {(0,0)= -161}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(1)=9, -160, -170)} 0 {(0,0)= -161}
rule : {if((0,-1) !=100 and (0,-1) >= 0 and (0,-1) !=? and (0,-1)!=20 and (0,-1)!=30 and (0,-1)!=40 and cellpos(1)!=9, -150, -170)} 0 {(0,0)= -151}
rule : {if((0,-1) !=100 and (0,-1) >= 0 and (0,-1) !=? and (0,-1)!=20 and (0,-1)!=30 and (0,-1)!=40 and cellpos(0)=1, -150, -110)} 0 {(0,0)= -151}



%--------------------------------
%Movement rules for Pedestrian 2
%--------------------------------

%2.1-Rules to make a free cell send a hosting broadcast, accepting incoming pedestrian from particular location
rule : -211 400 { (0,0)!=100 and (0,0)!=20 and (0,0)!=10 and (0,0)!=40 and (0,0)!=30 and  (0,-1) = -210}
rule : -221 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (1,-1) = -220}
rule : -281 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (-1,-1)= -280}
rule : -231 400 { (0,0)!=100 and (0,0)!=20 and (0,0)!=10 and (0,0)!=40 and (0,0)!=30 and  (1,0)  = -230}
rule : -271 400 { (0,0)!=100 and (0,0)!=20 and (0,0)!=10 and (0,0)!=40 and (0,0)!=30 and  (-1,0) = -270}
rule : -241 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (1,1)  = -240}
rule : -261 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (-1,1) = -260}
rule : -251 400 { (0,0)!=100 and (0,0)!=20 and (0,0)!=10 and (0,0)!=40 and (0,0)!=30 and  (0,1)  = -250}

%2.2-Rules to clear current cell as pedestrian is leaving it
rule : 0 0 {(0,0)= -210 and ( (0,1)  = -211 or (0,1)  = 20 )}
rule : 0 0 {(0,0)= -220 and ( (-1,1) = -221 or (-1,1) = 20 )}
rule : 0 0 {(0,0)= -230 and ( (-1,0) = -231 or (-1,0) = 20 )}
rule : 0 0 {(0,0)= -240 and ( (-1,-1)= -241 or (-1,-1)= 20 )}
rule : 0 0 {(0,0)= -250 and ( (0,-1) = -251 or (0,-1) = 20 )}
rule : 0 0 {(0,0)= -260 and ( (1,-1) = -261 or (1,-1) = 20 )}
rule : 0 0 {(0,0)= -270 and ( (1,0)  = -271 or (1,0)  = 20 )}
rule : 0 0 {(0,0)= -280 and ( (1,1)  = -281 or (1,1)  = 20 )}

%2.2.1-Rules to switch direction if pedestrian can't go in a certain way
rule : {if( ((-1,1) = 0 or (-1,1) = 20) and (-1,1) !=?, -220, -280)} 400 {(0,0)= -210 and ( (0,1)  = 100 or (0,1)  = ? or (0,1)  = 10 or (0,1)  = 20 or (0,1)  = 30 or (0,1)  = 40 )}
rule : {if( ((-1,0) = 0 or (-1,0) = 20) and (-1,0) !=?, -230, -210)} 400 {(0,0)= -220 and ( (-1,1) = 100 or (-1,1) = ? or (-1,1) = 10 or (-1,1) = 20 or (-1,1) = 30 or (-1,1) = 40 )}
rule : {if( ((-1,-1)= 0 or (-1,-1)= 20) and (-1,-1)!=?, -240, -220)} 400 {(0,0)= -230 and ( (-1,0) = 100 or (-1,0) = ? or (-1,0) = 10 or (-1,0) = 20 or (-1,0) = 30 or (-1,0) = 40 )}
rule : {if( ((0,-1) = 0 or (0,-1) = 20) and (0,-1) !=?, -250, -230)} 400 {(0,0)= -240 and ( (-1,-1)= 100 or (-1,-1)= ? or (-1,-1)= 10 or (-1,-1)= 20 or (-1,-1)= 30 or (-1,-1)= 40 )}
rule : {if( ((1,-1) = 0 or (1,-1) = 20) and (1,-1) !=?, -260, -240)} 400 {(0,0)= -250 and ( (0,-1) = 100 or (0,-1) = ? or (0,-1) = 10 or (0,-1) = 20 or (0,-1) = 30 or (0,-1) = 40 )}
rule : {if( ((1,0)  = 0 or (1,0)  = 20) and (1,0)  !=?, -270, -250)} 400 {(0,0)= -260 and ( (1,-1) = 100 or (1,-1) = ? or (1,-1) = 10 or (1,-1) = 20 or (1,-1) = 30 or (1,-1) = 40 )}
rule : {if( ((1,1)  = 0 or (1,1)  = 20) and (1,1)  !=?, -280, -260)} 400 {(0,0)= -270 and ( (1,0)  = 100 or (1,0)  = ? or (1,0)  = 10 or (1,0)  = 20 or (1,0)  = 30 or (1,0)  = 40 )}
rule : {if( ((0,1)  = 0 or (0,1)  = 20) and (0,1)  !=?, -210, -270)} 400 {(0,0)= -280 and ( (1,1)  = 100 or (1,1)  = ? or (1,1)  = 10 or (1,1)  = 20 or (1,1)  = 30 or (1,1)  = 40 )}

%2.3-Rules for a pedestrian to determin the direction of their next step
rule : {if((0,1)  !=100 and (0,1) >= 0 and (0,1)  !=? and (0,1)!=10 and (0,1)!=30 and (0,1)!=40 and cellpos(1)!=0, -210, -230)} 0 {(0,0)= -211}
rule : {if((0,1)  !=100 and (0,1) >= 0 and (0,1)  !=? and (0,1)!=10 and (0,1)!=30 and (0,1)!=40 and cellpos(0)=6, -210, -230)} 0 {(0,0)= -211}
rule : {if((-1,1) !=100 and (-1,1) >= 0 and (-1,1) !=? and (-1,1)!=20 and (-1,1)!=30 and (-1,1)!=40 and cellpos(0)!=6, -220, -210)} 0 {(0,0)= -221}
rule : {if((-1,1) !=100 and (-1,1) >= 0 and (-1,1) !=? and (-1,1)!=20 and (-1,1)!=30 and (-1,1)!=40 and cellpos(1)=0, -220, -230)} 0 {(0,0)= -221}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(0)!=6, -280, -210)} 0 {(0,0)= -281}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(1)=0, -280, -270)} 0 {(0,0)= -281}
rule : {if((-1,0) !=100 and (-1,0) >= 0 and (-1,0) !=? and (-1,0)!=10 and (-1,0)!=30 and (-1,0)!=40 and cellpos(0)!=6, -230, -250)} 0 {(0,0)= -231}
rule : {if((-1,0) !=100 and (-1,0) >= 0 and (-1,0) !=? and (-1,0)!=10 and (-1,0)!=30 and (-1,0)!=40 and cellpos(1)=0, -230, -270)} 0 {(0,0)= -231}
rule : {if((1,0)  !=100 and (1,0) >= 0 and (1,0)  !=? and (1,0)!=10 and (1,0)!=30 and (1,0)!=40 and cellpos(0)!=6, -270, -210)} 0 {(0,0)= -271}
rule : {if((1,0)  !=100 and (1,0) >= 0 and (1,0)  !=? and (1,0)!=10 and (1,0)!=30 and (1,0)!=40 and cellpos(1)=0, -270, -230)} 0 {(0,0)= -271}
rule : {if((-1,-1) !=100 and (-1,-1) >= 0 and (-1,-1) !=? and (-1,-1)!=20 and (-1,-1)!=30 and (-1,-1)!=40 and cellpos(0)!=6, -240, -250)} 0 {(0,0)= -241}
rule : {if((-1,-1) !=100 and (-1,-1) >= 0 and (-1,-1) !=? and (-1,-1)!=20 and (-1,-1)!=30 and (-1,-1)!=40 and cellpos(1)=0, -240, -230)} 0 {(0,0)= -241}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(0)!=6, -260, -250)} 0 {(0,0)= -261}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(1)=0, -260, -270)} 0 {(0,0)= -261}
rule : {if((0,-1) !=100 and (0,-1) >= 0 and (0,-1) !=? and (0,-1)!=10 and (0,-1)!=30 and (0,-1)!=40 and cellpos(1)!=0, -250, -270)} 0 {(0,0)= -251}
rule : {if((0,-1) !=100 and (0,-1) >= 0 and (0,-1) !=? and (0,-1)!=10 and (0,-1)!=30 and (0,-1)!=40 and cellpos(0)=6, -250, -210)} 0 {(0,0)= -251}



%--------------------------------
%Movement rules for Pedestrian 3
%--------------------------------

%3.1-Rules to make a free cell send a hosting broadcast, accepting incoming pedestrian from particular location
rule : -311 400 { (0,0)!=100 and (0,0)!=30 and (0,0)!=10 and (0,0)!=40 and (0,0)!=20 and  (0,-1) = -310}
rule : -321 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (1,-1) = -320}
rule : -381 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (-1,-1)= -380}
rule : -331 400 { (0,0)!=100 and (0,0)!=30 and (0,0)!=10 and (0,0)!=40 and (0,0)!=20 and  (1,0)  = -330}
rule : -371 400 { (0,0)!=100 and (0,0)!=30 and (0,0)!=10 and (0,0)!=40 and (0,0)!=20 and  (-1,0) = -370}
rule : -341 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (1,1)  = -340}
rule : -361 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (-1,1) = -360}
rule : -351 400 { (0,0)!=100 and (0,0)!=30 and (0,0)!=10 and (0,0)!=40 and (0,0)!=20 and  (0,1)  = -350}

%3.2-Rules to clear current cell as pedestrian is leaving it
rule : 0 0 {(0,0)= -310 and ( (0,1)  = -311 or (0,1)  = 30 )}
rule : 0 0 {(0,0)= -320 and ( (-1,1) = -321 or (-1,1) = 30 )}
rule : 0 0 {(0,0)= -330 and ( (-1,0) = -331 or (-1,0) = 30 )}
rule : 0 0 {(0,0)= -340 and ( (-1,-1)= -341 or (-1,-1)= 30 )}
rule : 0 0 {(0,0)= -350 and ( (0,-1) = -351 or (0,-1) = 30 )}
rule : 0 0 {(0,0)= -360 and ( (1,-1) = -361 or (1,-1) = 30 )}
rule : 0 0 {(0,0)= -370 and ( (1,0)  = -371 or (1,0)  = 30 )}
rule : 0 0 {(0,0)= -380 and ( (1,1)  = -381 or (1,1)  = 30 )}

%3.2.1-Rules to switch direction if pedestrian can't go in a certain way
rule : {if( ((-1,1) = 0 or (-1,1) = 30) and (-1,1) !=?, -320, -380)} 400 {(0,0)= -310 and ( (0,1)  = 100 or (0,1)  = ? or (0,1)  = 10 or (0,1)  = 20 or (0,1)  = 30 or (0,1)  = 40 )}
rule : {if( ((-1,0) = 0 or (-1,0) = 30) and (-1,0) !=?, -330, -310)} 400 {(0,0)= -320 and ( (-1,1) = 100 or (-1,1) = ? or (-1,1) = 10 or (-1,1) = 20 or (-1,1) = 30 or (-1,1) = 40 )}
rule : {if( ((-1,-1)= 0 or (-1,-1)= 30) and (-1,-1)!=?, -340, -320)} 400 {(0,0)= -330 and ( (-1,0) = 100 or (-1,0) = ? or (-1,0) = 10 or (-1,0) = 20 or (-1,0) = 30 or (-1,0) = 40 )}
rule : {if( ((0,-1) = 0 or (0,-1) = 30) and (0,-1) !=?, -350, -330)} 400 {(0,0)= -340 and ( (-1,-1)= 100 or (-1,-1)= ? or (-1,-1)= 10 or (-1,-1)= 20 or (-1,-1)= 30 or (-1,-1)= 40 )}
rule : {if( ((1,-1) = 0 or (1,-1) = 30) and (1,-1) !=?, -360, -340)} 400 {(0,0)= -350 and ( (0,-1) = 100 or (0,-1) = ? or (0,-1) = 10 or (0,-1) = 20 or (0,-1) = 30 or (0,-1) = 40 )}
rule : {if( ((1,0)  = 0 or (1,0)  = 30) and (1,0)  !=?, -370, -350)} 400 {(0,0)= -360 and ( (1,-1) = 100 or (1,-1) = ? or (1,-1) = 10 or (1,-1) = 20 or (1,-1) = 30 or (1,-1) = 40 )}
rule : {if( ((1,1)  = 0 or (1,1)  = 30) and (1,1)  !=?, -380, -360)} 400 {(0,0)= -370 and ( (1,0)  = 100 or (1,0)  = ? or (1,0)  = 10 or (1,0)  = 20 or (1,0)  = 30 or (1,0)  = 40 )}
rule : {if( ((0,1)  = 0 or (0,1)  = 30) and (0,1)  !=?, -310, -370)} 400 {(0,0)= -380 and ( (1,1)  = 100 or (1,1)  = ? or (1,1)  = 10 or (1,1)  = 20 or (1,1)  = 30 or (1,1)  = 40 )}

%3.3-Rules for a pedestrian to determin the direction of their next step
rule : {if((0,1)  !=100 and (0,1) >= 0 and (0,1)  !=? and (0,1)!=10 and (0,1)!=20 and (0,1)!=40 and cellpos(1)!=6, -310, -330)} 0 {(0,0)= -311}
rule : {if((0,1)  !=100 and (0,1) >= 0 and (0,1)  !=? and (0,1)!=10 and (0,1)!=20 and (0,1)!=40 and cellpos(0)=9, -310, -350)} 0 {(0,0)= -311}
rule : {if((-1,1) !=100 and (-1,1) >= 0 and (-1,1) !=? and (-1,1)!=20 and (-1,1)!=30 and (-1,1)!=40 and cellpos(0)!=9, -320, -310)} 0 {(0,0)= -321}
rule : {if((-1,1) !=100 and (-1,1) >= 0 and (-1,1) !=? and (-1,1)!=20 and (-1,1)!=30 and (-1,1)!=40 and cellpos(1)=6, -320, -330)} 0 {(0,0)= -321}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(0)!=9, -380, -310)} 0 {(0,0)= -381}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(1)=6, -380, -370)} 0 {(0,0)= -381}
rule : {if((-1,0) !=100 and (-1,0) >= 0 and (-1,0) !=? and (-1,0)!=10 and (-1,0)!=20 and (-1,0)!=40 and cellpos(0)!=9, -330, -350)} 0 {(0,0)= -331}
rule : {if((-1,0) !=100 and (-1,0) >= 0 and (-1,0) !=? and (-1,0)!=10 and (-1,0)!=20 and (-1,0)!=40 and cellpos(1)=6, -330, -370)} 0 {(0,0)= -331}
rule : {if((1,0)  !=100 and (1,0) >= 0 and (1,0)  !=? and (1,0)!=10 and (1,0)!=20 and (1,0)!=40 and cellpos(0)!=9, -370, -310)} 0 {(0,0)= -371}
rule : {if((1,0)  !=100 and (1,0) >= 0 and (1,0)  !=? and (1,0)!=10 and (1,0)!=20 and (1,0)!=40 and cellpos(1)=6, -370, -330)} 0 {(0,0)= -371}
rule : {if((-1,-1) !=100 and (-1,-1) >= 0 and (-1,-1) !=? and (-1,-1)!=20 and (-1,-1)!=30 and (-1,-1)!=40 and cellpos(0)!=9, -340, -350)} 0 {(0,0)= -341}
rule : {if((-1,-1) !=100 and (-1,-1) >= 0 and (-1,-1) !=? and (-1,-1)!=20 and (-1,-1)!=30 and (-1,-1)!=40 and cellpos(1)=6, -340, -330)} 0 {(0,0)= -341}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(0)!=9, -360, -350)} 0 {(0,0)= -361}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(1)=6, -360, -370)} 0 {(0,0)= -361}
rule : {if((0,-1) !=100 and (0,-1) >= 0 and (0,-1) !=? and (0,-1)!=10 and (0,-1)!=20 and (0,-1)!=40 and cellpos(1)!=6, -350, -370)} 0 {(0,0)= -351}
rule : {if((0,-1) !=100 and (0,-1) >= 0 and (0,-1) !=? and (0,-1)!=10 and (0,-1)!=20 and (0,-1)!=40 and cellpos(0)=9, -350, -310)} 0 {(0,0)= -351}



%--------------------------------
%Movement rules for Pedestrian 4
%--------------------------------

%4.1-Rules to make a free cell send a hosting broadcast, accepting incoming pedestrian from particular location
rule : -411 400 { (0,0)!=100 and (0,0)!=40 and (0,0)!=10 and (0,0)!=30 and (0,0)!=20 and  (0,-1) = -410}
rule : -421 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (1,-1) = -420}
rule : -481 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (-1,-1)= -480}
rule : -431 400 { (0,0)!=100 and (0,0)!=40 and (0,0)!=10 and (0,0)!=30 and (0,0)!=20 and  (1,0)  = -430}
rule : -471 400 { (0,0)!=100 and (0,0)!=40 and (0,0)!=10 and (0,0)!=30 and (0,0)!=20 and  (-1,0) = -470}
rule : -441 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (1,1)  = -440}
rule : -461 400 { (0,0)!=100 and (0,0)!=10 and (0,0)!=30 and (0,0)!=40 and (0,0)!=20 and (-1,1) = -460}
rule : -451 400 { (0,0)!=100 and (0,0)!=40 and (0,0)!=10 and (0,0)!=30 and (0,0)!=20 and  (0,1)  = -450}

%4.2-Rules to clear current cell as pedestrian is leaving it
rule : 0 0 {(0,0)= -410 and ( (0,1)  = -411 or (0,1)  = 40 )}
rule : 0 0 {(0,0)= -420 and ( (-1,1) = -421 or (-1,1) = 40 )}
rule : 0 0 {(0,0)= -430 and ( (-1,0) = -431 or (-1,0) = 40 )}
rule : 0 0 {(0,0)= -440 and ( (-1,-1)= -441 or (-1,-1)= 40 )}
rule : 0 0 {(0,0)= -450 and ( (0,-1) = -451 or (0,-1) = 40 )}
rule : 0 0 {(0,0)= -460 and ( (1,-1) = -461 or (1,-1) = 40 )}
rule : 0 0 {(0,0)= -470 and ( (1,0)  = -471 or (1,0)  = 40 )}
rule : 0 0 {(0,0)= -480 and ( (1,1)  = -481 or (1,1)  = 40 )}

%4.2.1-Rules to switch direction if pedestrian can't go in a certain way
rule : {if( ((-1,1) = 0 or (-1,1) = 40) and (-1,1) !=?, -420, -480)} 200 {(0,0)= -410 and ( (0,1)  = 400 or (0,1)  = ? or (0,1)  = 10 or (0,1)  = 20 or (0,1)  = 30 or (0,1)  = 40 )}
rule : {if( ((-1,0) = 0 or (-1,0) = 40) and (-1,0) !=?, -430, -410)} 200 {(0,0)= -420 and ( (-1,1) = 400 or (-1,1) = ? or (-1,1) = 10 or (-1,1) = 20 or (-1,1) = 30 or (-1,1) = 40 )}
rule : {if( ((-1,-1)= 0 or (-1,-1)= 40) and (-1,-1)!=?, -440, -420)} 200 {(0,0)= -430 and ( (-1,0) = 400 or (-1,0) = ? or (-1,0) = 10 or (-1,0) = 20 or (-1,0) = 30 or (-1,0) = 40 )}
rule : {if( ((0,-1) = 0 or (0,-1) = 40) and (0,-1) !=?, -450, -430)} 200 {(0,0)= -440 and ( (-1,-1)= 400 or (-1,-1)= ? or (-1,-1)= 10 or (-1,-1)= 20 or (-1,-1)= 30 or (-1,-1)= 40 )}
rule : {if( ((1,-1) = 0 or (1,-1) = 40) and (1,-1) !=?, -460, -440)} 200 {(0,0)= -450 and ( (0,-1) = 400 or (0,-1) = ? or (0,-1) = 10 or (0,-1) = 20 or (0,-1) = 30 or (0,-1) = 40 )}
rule : {if( ((1,0)  = 0 or (1,0)  = 40) and (1,0)  !=?, -470, -450)} 200 {(0,0)= -460 and ( (1,-1) = 400 or (1,-1) = ? or (1,-1) = 10 or (1,-1) = 20 or (1,-1) = 30 or (1,-1) = 40 )}
rule : {if( ((1,1)  = 0 or (1,1)  = 40) and (1,1)  !=?, -480, -460)} 200 {(0,0)= -470 and ( (1,0)  = 400 or (1,0)  = ? or (1,0)  = 10 or (1,0)  = 20 or (1,0)  = 30 or (1,0)  = 40 )}
rule : {if( ((0,1)  = 0 or (0,1)  = 40) and (0,1)  !=?, -410, -470)} 200 {(0,0)= -480 and ( (1,1)  = 400 or (1,1)  = ? or (1,1)  = 10 or (1,1)  = 20 or (1,1)  = 30 or (1,1)  = 40 )}

%4.3-Rules for a pedestrian to determin the direction of their next step
rule : {if((0,1)  !=100 and (0,1) >= 0 and (0,1)  !=? and (0,1)!=10 and (0,1)!=30 and (0,1)!=20 and cellpos(1)!=3, -410, -430)} 0 {(0,0)= -411}
rule : {if((0,1)  !=100 and (0,1) >= 0 and (0,1)  !=? and (0,1)!=10 and (0,1)!=30 and (0,1)!=20 and cellpos(0)=0, -410, -450)} 0 {(0,0)= -411}
rule : {if((-1,1) !=100 and (-1,1) >= 0 and (-1,1) !=? and (-1,1)!=20 and (-1,1)!=30 and (-1,1)!=40 and cellpos(0)!=0, -420, -410)} 0 {(0,0)= -421}
rule : {if((-1,1) !=100 and (-1,1) >= 0 and (-1,1) !=? and (-1,1)!=20 and (-1,1)!=30 and (-1,1)!=40 and cellpos(1)=3, -420, -430)} 0 {(0,0)= -421}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(0)!=0, -480, -410)} 0 {(0,0)= -481}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(1)=3, -480, -470)} 0 {(0,0)= -481}
rule : {if((-1,0) !=100 and (-1,0) >= 0 and (-1,0) !=? and (-1,0)!=10 and (-1,0)!=30 and (-1,0)!=20 and cellpos(0)!=0, -430, -450)} 0 {(0,0)= -431}
rule : {if((-1,0) !=100 and (-1,0) >= 0 and (-1,0) !=? and (-1,0)!=10 and (-1,0)!=30 and (-1,0)!=20 and cellpos(1)=3, -430, -470)} 0 {(0,0)= -431}
rule : {if((1,0)  !=100 and (1,0) >= 0 and (1,0)  !=? and (1,0)!=10 and (1,0)!=30 and (1,0)!=20 and cellpos(0)!=0, -470, -410)} 0 {(0,0)= -471}
rule : {if((1,0)  !=100 and (1,0) >= 0 and (1,0)  !=? and (1,0)!=10 and (1,0)!=30 and (1,0)!=20 and cellpos(1)=3, -470, -430)} 0 {(0,0)= -471}
rule : {if((-1,-1) !=100 and (-1,-1) >= 0 and (-1,-1) !=? and (-1,-1)!=20 and (-1,-1)!=30 and (-1,-1)!=40 and cellpos(0)!=0, -440, -450)} 0 {(0,0)= -441}
rule : {if((-1,-1) !=100 and (-1,-1) >= 0 and (-1,-1) !=? and (-1,-1)!=20 and (-1,-1)!=30 and (-1,-1)!=40 and cellpos(1)=3, -440, -430)} 0 {(0,0)= -441}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(0)!=0, -460, -450)} 0 {(0,0)= -461}
rule : {if((1,-1) !=100 and (1,-1) >= 0 and (1,-1) !=? and (1,-1)!=20 and (1,-1)!=30 and (1,-1)!=40 and cellpos(1)=3, -460, -470)} 0 {(0,0)= -461}
rule : {if((0,-1) !=100 and (0,-1) >= 0 and (0,-1) !=? and (0,-1)!=10 and (0,-1)!=30 and (0,-1)!=20 and cellpos(1)!=3, -450, -470)} 0 {(0,0)= -451}
rule : {if((0,-1) !=100 and (0,-1) >= 0 and (0,-1) !=? and (0,-1)!=10 and (0,-1)!=30 and (0,-1)!=20 and cellpos(0)=0, -450, -410)} 0 {(0,0)= -451}



%-------------------------------------------
%5- GENERAL RULE :
%  keep cell value the same for all cases.
%-------------------------------------------
rule : {(0,0)} 0 {t}

