clouds_array = {}

function clouds(amount)
 if #clouds_array == 0 then
 	generate_clouds(amount)
 end
   
 for cloud in all(clouds_array) do
  if (frame_count % 10 == 0) then
   --cloud moves off screen
   if cloud.x-cloud.spd < -20 then
    cloud.x=160
    cloud.y=20+rnd(30)
    cloud.spd=flr(rnd(2)+1)
    cloud.size=flr(rnd(3))    
   else 
    cloud.x-=cloud.spd
   end
  end
  sspr(16,64,16,10,cloud.x,cloud.y,cloud.size*16,cloud.size*8)
 end 
end

function generate_clouds(amount)
 for i=0,amount do
   local cloud = {x=rnd(128),
   y=20+rnd(30),
   spd=flr(rnd(2)+1),
   size=flr(rnd(3))
   }
   add(clouds_array,cloud)
 end
end