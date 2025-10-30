-- background animations
starfield_array={}
function starfield(size)
 if #starfield_array == 0 then  
  for i=0,size do
   local star = {x=rnd(128),
   y=rnd(60),
   anim=flr(rnd(5))+1,
   spd=rnd(1)+1
   }
   add(starfield_array,star)
   
  end
 end
 sanim={ 2, 1, 0,0,0, 1}
 for star in all(starfield_array) do
  if (frame_count == 1) then
   if star.x-star.spd < 0 then
    star.x = 130
    star.spd=rnd(3)
   else
    star.x = star.x-star.spd
   end
   if star.anim >= #sanim then
     star.anim=1
   else
     star.anim=star.anim+1
   end
  end
 
  if pget(star.x,star.y) == 1 or pget(star.x,star.y) == 5 then
    starcolor = 13
  else
    starcolor = nil
  end
  
  for i=0, sanim[star.anim] do
   if (starcolor != 13) then
    starcolor = 7-i
   end
   pset(star.x,star.y+i,starcolor)
	  pset(star.x+i,star.y,starcolor)
	  pset(star.x-i,star.y,starcolor)
	  pset(star.x,star.y-i,starcolor)
	 end
	end
end