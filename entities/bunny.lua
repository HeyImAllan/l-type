-- evil hopping bunny enemy
-- sprites 114,115: two-frame hop animation (dev: replace with bunny art)
-- sprite area: 16x16 (2x2 tiles)
bunnies={}
bunny_pat={0,0,-2,-4,-4,-2,0,0,2,4,4,2}
bunny_sprs={114,115}

function spawn_bunny(py)
 local b={}
 b.x=128
 b.y=py
 b.anim=flr(rnd(#bunny_pat))+1
 b.hp=6
 b.blink=0
 b.sfx=3
 b.score=2
 b.update_hitbox=function(self)
  self.hitbox={{x=self.x+2,y=self.y+2},
               {x=self.x+12,y=self.y+14}}
 end
 b:update_hitbox()
 add(bunnies,b)
end

function update_bunnies()
 for b in all(bunnies) do
  bounds_check(b,bunnies)
  if frame_count%3==0 then
   b.anim=b.anim%#bunny_pat+1
   b.y+=bunny_pat[b.anim]
   b.x-=1.5
   if b.y<8 then b.y=8 end
   if b.y>100 then b.y=100 end
   b:update_hitbox()
  end
 end
end

function draw_bunnies()
 for b in all(bunnies) do
  blink_sprite(b)
  spr(bunny_sprs[(b.anim%2)+1],b.x,b.y,2,2)
  pal()
  setpalt()
 end
end
