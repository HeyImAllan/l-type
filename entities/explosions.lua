explosions={}
explodsanim={96,96,96,96,96,98,98,98,100,100,102,102,104,104,106,106}
shraps={}
shwaves={}
sparks={}

function spawn_explosion(x,y,isblue,delay)
   if delay == nil then
      delay=0
   end
   local myex={x=x-8,y=y-8,life=5}
   myex.delay=delay
   myex.sx=0
   myex.sy=0
   myex.isblue=isblue
   add(explosions,myex)
   for i=1,5 do
      local myex={x=x-8,y=y-8,life=rnd(5)}
      myex.delay=delay
      myex.isblue=isblue
      myex.sx=(rnd()-0.5)*2
      myex.sy=(rnd()-0.5)*2
      add(explosions,myex)
   end
end

function draw_explosions(explosions)
 for myex in all(explosions) do
   if myex.delay == 0 then
      sfx(28)
   end
   if myex.delay < 0 then
      age = flr(myex.life)
      sprite = explodsanim[age]
      if myex.isblue == true then
         pal(10,12)
         pal(9,13)
         pal(8,6)
         pal(2,1)
      end
      spr(sprite,myex.x,myex.y,2,2)
      pal()
      setpalt()
      myex.life+=1
      myex.x+=myex.sx*0.9
      myex.y+=myex.sy*0.9
      if myex.life > #explodsanim then
      del(explosions,myex)
      end
   else 
      myex.delay-=1
   end
 end
end

function spawn_shrapnel(x,y)
   for i=1,10 do
      local myex={x=x,y=y,life=rnd(15)}
      myex.sx=(rnd())*2
      myex.sy=(rnd()-0.5)*2
      myex.color=12
      add(shraps,myex)
   end
end

function spawn_sparks(x,y,color,life)
   for i=1,50 do
      local myex={x=x,y=y,life=rnd(life)}
      myex.sx=(rnd()-0.5)*4
      myex.sy=(rnd()-0.5)*4
      myex.color=color
      add(sparks,myex)
   end
end

function draw_shrapnel(shraps)
   for mys in all(shraps) do
      pset(mys.x,mys.y,mys.color)
      mys.x+=mys.sx*0.9
      mys.y+=mys.sy*0.9
      mys.life-=1
      if mys.life < 0 then
         del(shraps,mys)
      end
   end
end

function small_shwave(shx,shy,color)
   myshwave = shwave(shx,shy,1,6,1,color)
   add(shwaves,myshwave)
end

function big_shwave(shx,shy,color)
   myshwave = shwave(shx,shy,3,30,3,color)
   add(shwaves,myshwave)
end


function shwave(shx,shy,shr,shtr,spd,color)
 local myshwave={}
 myshwave.color=color
 myshwave.x=shx
 myshwave.y=shy
 myshwave.r=shr
 myshwave.tr=shtr
 myshwave.spd=spd
 return myshwave
end

function draw_shwaves(shwaves)
   for shwave in all(shwaves) do
      circ(shwave.x, shwave.y, shwave.r, shwave.color )
      shwave.r+=shwave.spd*0.9
      if shwave.r >= shwave.tr then
         del(shwaves,shwave)
      end
   end
end