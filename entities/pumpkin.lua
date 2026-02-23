all_pumpkins={}
-- anim_x: frames 1-46 move left(-2), 47-77 hover(0), 78-123 move right(+2)
-- anim_y: frames 1-31 rise(0), 32-92 fall(+1), 93-123 level(0)

function spawn_pumpkin(py)
 local e={}
 mk_en(e,py,10,4,3,0,0,15,13)
 e.sx,e.sy,e.anim,e.spd=56,0,1,1
 add(all_pumpkins,e)
end

function draw_pumpkin(pumpkin)
  -- pumpkin baddy
  blink_sprite(pumpkin)
  sspr(pumpkin.sx,pumpkin.sy,15,13,pumpkin.x,pumpkin.y)
  pal()
  setpalt()
end

function draw_pumpkins(all_pumpkins)
    for pumpkin in all(all_pumpkins) do
     draw_pumpkin(pumpkin)
    end
end

function move_pumpkin(p)
 local i=p.anim
 p.x+=i<=46 and -2 or i>77 and 2 or 0
 p.y+=i>31 and i<=92 and 1 or 0
 if frame_count%10==0 then p.sx=p.sx==56 and 72 or 56 end
 p:update_hitbox()
 p.anim+=1
 if p.anim>123 then del(all_pumpkins,p) end
end

function update_pumpkins(all_pumpkins)
 for pumpkin in all(all_pumpkins) do
    move_pumpkin(pumpkin)
 end
end