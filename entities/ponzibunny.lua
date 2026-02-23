-- BOSS: PONZI BUNNY
-- a giant golden easter bunny that hides money in offshore eggs
-- instills fear in bankers: shoots launder/offshore/hide beams
-- sprite 144: boss body placeholder 4x4 tiles (dev: replace with golden bunny art)
ponzibunnies={}
ponzi_card_wait=0
ponzi_attacks={"launder","offshore","hide"}

function spawn_ponzibunny(py)
 local pb={}
 pb.x,pb.y=140,py
 pb.hp,pb.isboss,pb.score,pb.laugh=100,true,2000,true
 pb.hx1,pb.hy1,pb.hx2,pb.hy2=8,8,24,24
 pb.update=upd_hb
 pb.hitbox={{x=-5,y=-5},{x=-5,y=-5}}
 pb.shoot=ponzi_fire
 add(ponzibunnies,pb)
end

function ponzi_fire(type,tx,ty)
 if type=="egg" then
  if ponzi_card_wait>0 then return end
  ponzi_card_wait=20
  add(enemy_bullets,mk_ebul(tx,ty,2,112,1,6,6))
 else
  local s=type=="launder" and 11 or type=="offshore" and 27 or 29
  add(enemy_bullets,mk_ebul(tx,ty,3,s,2,15,7))
 end
end

function animate_ponzibunny(pb)
 update_enemy_bullets(enemy_bullets)
 if pb.x>=70 then
  pb.x-=fgspeed
 else
  pb.y+=sin(t/200)*1.5
  pb:update()
  pb.shoot("egg",pb.x+24,pb.y+20)
  if t%120==0 then
   pb.shoot(ponzi_attacks[flr(rnd(3))+1],pb.x+24,pb.y+20)
  end
 end
 pb.laugh=sin(t/40)<0.2
 if ponzi_card_wait>0 then ponzi_card_wait-=1 end
end

function update_ponzibunnies()
 for pb in all(ponzibunnies) do
  animate_ponzibunny(pb)
 end
end

function draw_ponzibunnies()
 for pb in all(ponzibunnies) do
  if mode=="game" then
   print("boss: ponzi bunny",1,10,9)
   print("hp: ",1,16,7)
   for i=1,pb.hp/2 do
    pset(i+11,18,8)
   end
  end
  -- dev: replace spr(144,...) with actual golden bunny boss sprite
  spr(144,pb.x,pb.y,4,4)
  draw_enemy_bullets(enemy_bullets)
 end
end
