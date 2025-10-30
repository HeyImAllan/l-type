-- movement constraints

function new_leo()
    leo={}
    leo.x=20
    leo.sx=0
    leo.y=64
    leo.sy=0
    leo.hitbox={
            {x=leo.x+9, y=leo.y+11},
            {x=leo.x+10, y=leo.y+11}
            }

    leo.speed_bonus=0
    leo.plane_sspr_sx=8
    leo.plane_sspr_sy=16
    leo.invert=false
    leo.vertical_bob=0
    leo.blink=0
    leo.prop=19
    leo.prop_x=16
    leo.max_health=3
    leo.health=4
    return leo
end



function leoboundscheck(leo)
 -- bounds checking
 if (leo.y >= 100) then
  leo.y=100
 end

 if (leo.y <= -1) then
	 leo.y=-1
 end

 if (leo.x >= 112) then
  leo.x=112
 end

 if (leo.x <= -1) then
  leo.x=0
 end
end

function leoreset(leo)
 leo.sx=0
 leo.sy=0
 leo.plane_sspr_sy=16
 leo.invert_spr=false
 leo.prop_x=16
 afterburner_x=-7
 leo.speed_bonus=0
 if muzzle >= 0 then
  muzzle=muzzle-1
 end
end

function draw_leo(leo)
 draw_x=leo.x
 draw_y=leo.y+leo.vertical_bob
 blink_sprite(leo)
 sspr(8,0,16,8,draw_x,draw_y,16,8,leo.invert_spr)
 sspr(leo.plane_sspr_sx
     ,leo.plane_sspr_sy
     ,16,8
     ,draw_x,draw_y+8
     ,16,8,leo.invert_spr)
 spr(leo.prop,draw_x+leo.prop_x,draw_y+8,1,1,leo.invert_spr)
 -- display afterburner
 if (afterburner_on == true) then
  spr(afterburner_gfx,draw_x+afterburner_x,draw_y+8,1,1,leo.invert_spr)
 end
 pal()
 setpalt()
 
end

function move_leo(leo)
    	-- movement calculations
	leo.x=leo.x+leo.sx
	leo.y=leo.y+leo.sy
	leo.hitbox={
           {x=leo.x+9, y=leo.y+11},
           {x=leo.x+10, y=leo.y+11}
           }
end

