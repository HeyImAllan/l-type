hearts={}

function spawn_heart(x,y)
 local heart={}
 heart.x=x
 heart.y=y
 heart.spd=0.1
 heart.accel=0.01
 heart.hitbox={{x=x,y=y},{x=x+7,y=y+7}}
 add(hearts,heart)
end

function update_hearts()
 for heart in all(hearts) do
  heart.spd+=heart.accel
  heart.x-=heart.spd
  heart.hitbox={{x=heart.x,y=heart.y},{x=heart.x+7,y=heart.y+7}}
  if heart.x < -8 then
   del(hearts,heart)
  elseif coll(leo,heart) then
   if leo.health < leo.max_health+1 then
    leo.health+=1
   end
   del(hearts,heart)
  end
 end
end

function draw_hearts()
 for heart in all(hearts) do
  spr(20,heart.x,heart.y)
 end
end
