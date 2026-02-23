bunnies={}
bunny_pat=split"0,0,-2,-4,-4,-2,0,0,2,4,4,2"
bunny_sprs=split"98,100"
function spawn_bunny(py)
 local e={}
 mk_en(e,py,6,3,2,2,2,12,14)
 e.anim=flr(rnd(#bunny_pat))+1
 add(bunnies,e)
end

function update_bunnies()
 for e in all(bunnies) do
  bounds_check(e,bunnies)
  if frame_count%3==0 then
   e.anim=e.anim%#bunny_pat+1
   e.y+=bunny_pat[e.anim]
   e.x-=1.5
   if e.y<8 then e.y=8 end
   if e.y>100 then e.y=100 end
   e:update_hitbox()
  end
 end
end

function draw_bunnies()
 for e in all(bunnies) do
  blink_sprite(e)
  spr(bunny_sprs[e.anim%2+1],e.x,e.y,2,2)
  pal()
  setpalt()
 end
end
