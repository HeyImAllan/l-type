function shoot()
  if shoot_wait == 0 then  
   local bullet={}
   bullet={x=leo.x+13, y=leo.y+8,
           spd=3, lvl=0}
 	 bullet.hitbox={
 	               {x=bullet.x+1,y=bullet.y+1},
 	               {x=bullet.x+6,y=bullet.y+6}
 	               }
 	 	 sfx(01)
		 muzzle=3
		 add(bullets,bullet)
		 shoot_wait=3
		end
end

function move_bullets()
 for mybul in all(bullets) do
  if mybul.x > 128 then
   del(bullets, mybul)
  else
    mybul.x = mybul.x+mybul.spd
    mybul.hitbox={
 	              {x=mybul.x+1,y=mybul.y+1},
 	              {x=mybul.x+6,y=mybul.y+6}
 	              }
  end
 end
 if shoot_wait > 0 then
  shoot_wait-=1
 end
end

function draw_bullets()
 for mybul in all(bullets) do
  spr(16,mybul.x,mybul.y)
 end
end
