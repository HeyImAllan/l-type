-- flying egg obstacle
-- sprites 112,113: two-frame egg wobble (dev: replace with easter egg art)
eggs={}
egg_wanim={112,113}

function spawn_egg(py)
 local egg={}
 egg.x=128
 egg.y=py
 egg.spd=1.5
 egg.anim=1
 egg.hp=2
 egg.blink=0
 egg.sfx=4
 egg.score=2
 egg.vy=(rnd(1)-0.5)*0.4
 egg.update_hitbox=function(self)
  self.hitbox={{x=self.x+1,y=self.y+1},
               {x=self.x+6,y=self.y+6}}
 end
 egg:update_hitbox()
 add(eggs,egg)
end

function update_eggs()
 for egg in all(eggs) do
  egg.x-=egg.spd
  egg.y+=egg.vy
  if egg.y<8 or egg.y>100 then egg.vy=-egg.vy end
  if egg.x<-10 then del(eggs,egg) end
  if frame_count%8==0 then
   egg.anim=egg.anim%2+1
  end
  egg:update_hitbox()
 end
end

function draw_eggs()
 for egg in all(eggs) do
  blink_sprite(egg)
  spr(egg_wanim[egg.anim],egg.x,egg.y)
  pal()
  setpalt()
 end
end
