-- BOSS: PONZI BUNNY
-- a giant golden easter bunny that hides money in offshore eggs
-- instills fear in bankers: shoots launder/offshore/hide beams
-- sprite 144: boss body placeholder 4x4 tiles (dev: replace with golden bunny art)
ponzibunnies={}
ponzi_card_wait=0
ponzi_attacks={"launder","offshore","hide"}

function spawn_ponzibunny(py)
 local pb={}
 pb.x=140
 pb.y=py
 pb.hp=100
 pb.isboss=true
 pb.score=2000
 pb.laugh=true
 pb.update=function(self)
  self.hitbox={{x=self.x+8,y=self.y+8},
               {x=self.x+24,y=self.y+24}}
 end
 pb.hitbox={{x=-5,y=-5},{x=-5,y=-5}}
 pb.shoot=ponzi_fire
 add(ponzibunnies,pb)
end

function ponzi_fire(type,tx,ty)
 if type=="egg" then
  if ponzi_card_wait==0 then
   ponzi_card_wait=20
   local b={}
   b.x=tx b.y=ty
   b.spd=2 b.muzzle=5
   b.sprite=112 -- placeholder: golden egg projectile
   b.update_hitbox=function(self)
    self.hitbox={{x=self.x+1,y=self.y+1},
                 {x=self.x+6,y=self.y+6}}
   end
   b.width=1
   b:update_hitbox()
   add(enemy_bullets,b)
  end
 end
 if type=="launder" or type=="offshore" or type=="hide" then
  local b={}
  b.x=tx b.y=ty
  b.spd=3 b.muzzle=5
  -- placeholder sprites - dev: replace with launder/offshore/hide word sprites
  if type=="launder" then
   b.sprite=11
  elseif type=="offshore" then
   b.sprite=27
  else
   b.sprite=29
  end
  b.update_hitbox=function(self)
   self.hitbox={{x=self.x+1,y=self.y+1},
                {x=self.x+15,y=self.y+7}}
  end
  b.width=2
  b:update_hitbox()
  add(enemy_bullets,b)
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
 if sin(t/40)<0.2 then
  pb.laugh=true
 else
  pb.laugh=false
 end
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
