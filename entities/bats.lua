bats={}
bpattern=split"2,2,2,-2,-2,-2"
banim=split"64,65,66,67,66,65"
function spawn_bat(py)
 local e={}
 mk_en(e,py,4,3,1,5,3,10,6)
 e.anim=flr(rnd(3))
 add(bats,e)
end

function update_bats()
 for e in all(bats) do
  bounds_check(e,bats)
  if frame_count%3==0 then
   e.anim=e.anim<#banim and e.anim+1 or 1
   e.y+=bpattern[e.anim]
   e.x-=2
   e:update_hitbox()
  end
 end
end

function draw_bats()
 for e in all(bats) do
  blink_sprite(e)
  spr(banim[e.anim],e.x,e.y)
  spr(banim[e.anim],e.x+8,e.y,1,1,true)
  pal()
  setpalt()
 end
end

function bounds_check(e,t)
 if e.x<-20 then del(t,e) end
end

