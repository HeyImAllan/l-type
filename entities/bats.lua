-- enemy handling
bats={}
bpattern={2,2,2,-2,-2,-2}
banim={64,65,66,67,66,65}
-- spawn a bat
function spawn_bat(py)
  local newbat={}
  newbat.blink=0
  newbat.x=128
  newbat.y=py
  newbat.anim=flr(rnd(3))
  newbat.hp=4
  newbat.sfx=03
  newbat.score=1

  newbat.update_hitbox=function(self)
        self.hitbox={{x=self.x+5,y=self.y+3},{x=self.x+10,y=self.y+6}}
      end
  newbat:update_hitbox()         
 add(bats,newbat)
end
    

-- animate_bats
function update_bats()

 for bat in all(bats) do
 bounds_check(bat, bats)
  if frame_count % 3 == 0 then
   if bat.anim < #banim then
    bat.anim+=1
   else
    bat.anim=1
   end
   bat.y=bat.y+bpattern[bat.anim]
   bat.x-=2
   bat:update_hitbox()
  end
 end
end


-- draw bats
function draw_bats(bats)
  for bat in all(bats) do
   blink_sprite(bat)
   spr(banim[bat.anim],bat.x,bat.y)
   spr(banim[bat.anim],bat.x+8,bat.y,1,1,true,false)
   pal()
   setpalt()
  end
end

function bounds_check(enemy, enemy_map)
 if enemy.x < -20 then
  del(enemy_map, enemy)
 end
end

