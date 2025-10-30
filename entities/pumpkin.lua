all_pumpkins={}
pumpkinanim_x={}
for i=0, 45 do
    add(pumpkinanim_x, -2)
end
for i=0, 30 do
    add(pumpkinanim_x, 0)
end
for i=0, 45 do
    add(pumpkinanim_x, 2)
end
pumpkinanim_y={}
for i=0, 30 do
 add(pumpkinanim_y,0)
end
for i=0, 60 do
 add(pumpkinanim_y,1)
end
for i=0, 30 do
 add(pumpkinanim_y,0)
end

function spawn_pumpkin(py)
 pumpkin = {x=128,y=py,sx=56,sy=0,anim=1,spd=1,
            hitbox={{x=128, y=py},
                    {x=128+15,y=py+13}},
            hp=10,
            sfx=04,
            blink=0,
            score=3}
 add(all_pumpkins,pumpkin)
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

function move_pumpkin(pumpkin)
 pumpkin.x = pumpkin.x+pumpkinanim_x[pumpkin.anim]
 pumpkin.y = pumpkin.y+pumpkinanim_y[pumpkin.anim]
 if frame_count % 10 == 0 and pumpkin.sx == 56 then
  pumpkin.sx = 72
 elseif frame_count % 10 == 0 and pumpkin.sx == 72 then
  pumpkin.sx = 56
 end
 
 
 pumpkin.hitbox={{x=pumpkin.x, y=pumpkin.y}, {x=pumpkin.x+15,y=pumpkin.y+13}}
 pumpkin.anim=pumpkin.anim+1
 if pumpkin.anim > #pumpkinanim_x then
    del(all_pumpkins,pumpkin)
 end
end

function update_pumpkins(all_pumpkins)
 for pumpkin in all(all_pumpkins) do
    move_pumpkin(pumpkin)
 end
end