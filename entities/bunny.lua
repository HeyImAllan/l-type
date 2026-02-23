bunnies={}
bunny_sprs=split"68,68,68,70,70,70"
function spawn_bunny(py)
 local e={}
 mk_en(e,py,6,3,2,2,2,12,14)
 e.anim=flr(rnd(#bunny_sprs))+1
 add(bunnies,e)
end

function update_bunnies()
 for e in all(bunnies) do
  bounds_check(e,bunnies)
  if frame_count%3==0 then
   e.anim=e.anim<#bunny_sprs and e.anim+1 or 1
   e.y+=bpattern[e.anim]
   e.x-=1.5
   e:update_hitbox()
  end
 end
end

function draw_bunnies()
 for e in all(bunnies) do
  blink_sprite(e)
  spr(bunny_sprs[e.anim],e.x,e.y,2,2)
  pal()
  setpalt()
 end
end
