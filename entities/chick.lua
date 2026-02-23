chicks={}
chick_pat=split"3,3,-3,-3"
chick_sprs=split"64,65,66,67"
function spawn_chick(py)
 local e={}
 mk_en(e,py,3,3,2,2,2,12,10)
 e.anim=flr(rnd(4))+1
 add(chicks,e)
end

function update_chicks()
 for e in all(chicks) do
  bounds_check(e,chicks)
  if frame_count%3==0 then
   e.anim=e.anim<#chick_pat and e.anim+1 or 1
   e.y+=chick_pat[e.anim]
   e.x-=2.5
   if e.y<8 then e.y=8 end
   if e.y>100 then e.y=100 end
   e:update_hitbox()
  end
 end
end

function draw_chicks()
 for e in all(chicks) do
  blink_sprite(e)
  spr(chick_sprs[e.anim],e.x,e.y)
  spr(chick_sprs[e.anim],e.x+8,e.y,1,1,true)
  pal()
  setpalt()
 end
end
