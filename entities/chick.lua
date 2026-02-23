-- baby chick enemy - flies in medusa/sine pattern (like bats)
-- sprites 116,117,118,117: four-frame wing flap (dev: replace with chick art)
-- sprite area: 16x8 (2x1 tiles), mirrored like bats
chicks={}
chick_pat={3,3,-3,-3}
chick_sprs={116,117,118,117}

function spawn_chick(py)
 local c={}
 c.x=128
 c.y=py
 c.anim=flr(rnd(4))+1
 c.hp=3
 c.blink=0
 c.sfx=3
 c.score=2
 c.update_hitbox=function(self)
  self.hitbox={{x=self.x+2,y=self.y+2},
               {x=self.x+12,y=self.y+10}}
 end
 c:update_hitbox()
 add(chicks,c)
end

function update_chicks()
 for c in all(chicks) do
  bounds_check(c,chicks)
  if frame_count%3==0 then
   if c.anim<#chick_pat then
    c.anim+=1
   else
    c.anim=1
   end
   c.y+=chick_pat[c.anim]
   c.x-=2.5
   if c.y<8 then c.y=8 end
   if c.y>100 then c.y=100 end
   c:update_hitbox()
  end
 end
end

function draw_chicks()
 for c in all(chicks) do
  blink_sprite(c)
  spr(chick_sprs[c.anim],c.x,c.y)
  spr(chick_sprs[c.anim],c.x+8,c.y,1,1,true,false)
  pal()
  setpalt()
 end
end
