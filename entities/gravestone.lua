all_gravestones={}

function update_gravestones(all_gravestones)
 for gravestone in all(all_gravestones) do
    update_gravestone(gravestone)
 end
end

function update_gravestone(gravestone)
-- gravestone
 if frame_count == 15 and gravestone.gs_sspr_sx == 45 then
   gravestone.gs_sspr_sx=43
 elseif frame_count == 15 and gravestone.gs_sspr_sx == 43 then
   gravestone.gs_sspr_sx=45
 end
 gravestone.x = gravestone.x-gravestone.spd
 if gravestone.x < -10 then
    del(all_gravestones,gravestone)
 end
end

function spawn_gravestone(x,y)
    gravestone = {x=x, y=y, gs_sspr_sx=43, spd=fgspeed }
    add(all_gravestones,gravestone)
end

function draw_gravestone(gravestone)
  spr(gravestone.gs_sspr_sx,gravestone.x,gravestone.y,2,2)
 end

function draw_gravestones(all_gravestones)
 for gravestone in all(all_gravestones) do
    draw_gravestone(gravestone)
 end
end