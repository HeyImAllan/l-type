-- movement constraints

function new_leo()
 leo={}
 leo.x,leo.sx,leo.y,leo.sy=20,0,64,0
 leo.hx1,leo.hy1,leo.hx2,leo.hy2=9,11,10,11
 leo.update_hitbox=upd_hb
 leo:update_hitbox()
 leo.speed_bonus,leo.plane_sspr_sx,leo.plane_sspr_sy=0,8,16
 leo.invert,leo.vertical_bob,leo.blink=false,0,0
 leo.prop,leo.prop_x,leo.max_health,leo.health=19,16,3,4
 return leo
end



function leoboundscheck(leo)
 leo.x=mid(leo.x,0,112)
 leo.y=mid(leo.y,-1,100)
end

function leoreset(leo)
 leo.sx,leo.sy,leo.plane_sspr_sy,leo.invert_spr,leo.prop_x,leo.speed_bonus=0,0,16,false,16,0
 afterburner_x=-7
 if muzzle>=0 then muzzle-=1 end
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
 if afterburner_on then
  spr(afterburner_gfx,draw_x+afterburner_x,draw_y+8,1,1,leo.invert_spr)
 end
 pal()
 setpalt()
 
end

function move_leo(leo)
 leo.x+=leo.sx
 leo.y+=leo.sy
 leo:update_hitbox()
end

