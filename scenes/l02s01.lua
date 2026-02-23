-- level 02: eggfield of greed (easter theme)
-- 6 waves + ponzi bunny boss

function update_l02()
 if scene_start then
  local wave_resets={
   [1]=reset_l02wave01,
   [2]=reset_l02wave02,
   [3]=reset_l02wave03,
   [4]=reset_l02wave04,
   [5]=reset_l02wave05,
   [6]=reset_l02wave06,
   [7]=reset_l02boss
  }
  local reset_func=wave_resets[halloweenwave]
  if reset_func then reset_func() end
 end
 process_enemy_map(enemy_map)
 update_eggs()
 update_bunnies()
 update_chicks()
 update_ponzibunnies()
 update_hearts()
 check_enemy_col(eggs)
 check_enemy_col(bunnies)
 check_enemy_col(chicks)
 check_enemy_col(enemy_bullets)
 check_bull_col(eggs,bullets)
 check_bull_col(bunnies,bullets)
 check_bull_col(chicks,bullets)
 check_bull_col(ponzibunnies,bullets)
 level_frame_count+=1
 enemies_spawned=#eggs+#bunnies+#chicks+#ponzibunnies
 if enemies_spawned<=0 and level_frame_count>300 then
  halloweenwave+=1
  scene_start=true
 end
end

function draw_l02()
 -- spring sky background
 rectfill(0,0,128,112,12)
 clouds(3)
 draw_ground_l02()

 -- sun (dev: replace with sun sprite)
 circfill(108,12,10,10)
 circ(108,12,10,9)

 if level_frame_count<30*5 then
  print(welcome_text,10,28,menu_gfx())
 end

 draw_eggs()
 draw_bunnies()
 draw_chicks()
 draw_hearts()
 draw_ponzibunnies()

 if level_frame_count==32767 then
  level_frame_count=1
 end

 draw_generic_game()
end

ground_shift_l02=0
function draw_ground_l02()
 if ground_shift_l02>=8 then
  ground_shift_l02=0
 end
 -- dev: replace spr(58,...) with spring grass tile sprite
 for i=0,128,8 do
  spr(58,i-ground_shift_l02,112)
 end
 ground_shift_l02+=fgspeed
 rectfill(0,120,128,128,11)
end

function reset_l02()
 music(1)
 level_frame_count=0
 eggs={}
 bunnies={}
 chicks={}
 ponzibunnies={}
 hearts={}
 enemy_bullets={}
 starfield_array={}
 clouds_array={}
end

-- wave 1: eggs only - intro to easter chaos
function reset_l02wave01()
 enemy_map={
  {frame=30*0,enemy_y={50},func=spawn_egg},
  {frame=30*1,enemy_y={40},func=spawn_egg},
  {frame=30*2,enemy_y={60},func=spawn_egg},
  {frame=30*3,enemy_y={30,70},func=spawn_egg},
  {frame=30*5,enemy_y={50},func=spawn_bunny},
  {frame=30*6,enemy_y={40,70},func=spawn_egg},
  {frame=30*7,enemy_y={50},func=spawn_bunny},
  {frame=30*8,enemy_y={30,50,70},func=spawn_egg},
  {frame=30*9,enemy_y={40},func=spawn_bunny},
  {frame=30*10,enemy_y={60},func=spawn_bunny},
  {frame=30*12,enemy_y={25,50,75},func=spawn_egg},
  {frame=30*13,enemy_y={35,65},func=spawn_egg},
  {frame=30*14,enemy_y={50},func=spawn_bunny},
  {frame=30*15,enemy_y={40,60},func=spawn_egg},
 }
 level_frame_count=0
 scene_start=false
 welcome_text="eggfield of greed - wave 1"
end

-- wave 2: eggs and bunnies mixed
function reset_l02wave02()
 enemy_map={}
 generate_yswerve(enemy_map,0,spawn_egg)
 add(enemy_map,{frame=30*1,enemy_y={30,70},func=spawn_bunny})
 add(enemy_map,{frame=30*2,enemy_y={50},func=spawn_bunny})
 add(enemy_map,{frame=30*3,enemy_y={20,80},func=spawn_egg})
 add(enemy_map,{frame=30*4,enemy_y={40,60},func=spawn_bunny})
 add(enemy_map,{frame=30*5,enemy_y={50},func=spawn_egg})
 add(enemy_map,{frame=30*6,enemy_y={30,50,70},func=spawn_egg})
 add(enemy_map,{frame=30*7,enemy_y={40,60},func=spawn_bunny})
 add(enemy_map,{frame=30*8,enemy_y={25,75},func=spawn_egg})
 add(enemy_map,{frame=30*9,enemy_y={50},func=spawn_bunny})
 level_frame_count=0
 scene_start=false
 welcome_text="eggfield of greed - wave 2"
end

-- wave 3: chicks introduced with eggs
function reset_l02wave03()
 enemy_map={
  {frame=30*0,enemy_y={40,60},func=spawn_egg},
  {frame=30*1,enemy_y={50},func=spawn_chick},
  {frame=30*2,enemy_y={30,70},func=spawn_egg},
  {frame=30*3,enemy_y={40,60},func=spawn_chick},
  {frame=30*4,enemy_y={20,80},func=spawn_egg},
  {frame=30*5,enemy_y={50},func=spawn_bunny},
  {frame=30*6,enemy_y={30,50,70},func=spawn_chick},
  {frame=30*7,enemy_y={40,60},func=spawn_egg},
  {frame=30*8,enemy_y={35,65},func=spawn_bunny},
  {frame=30*10,enemy_y={25,50,75},func=spawn_egg},
 }
 generate_yswerve(enemy_map,12,spawn_chick)
 add(enemy_map,{frame=30*13,enemy_y={10,90},func=spawn_egg})
 add(enemy_map,{frame=30*14,enemy_y={30,70},func=spawn_bunny})
 add(enemy_map,{frame=30*15,enemy_y={50},func=spawn_chick})
 level_frame_count=0
 scene_start=false
 welcome_text="eggfield of greed - wave 3"
end

-- wave 4: all three types, medium intensity
function reset_l02wave04()
 enemy_map={}
 add(enemy_map,{frame=30*0,enemy_y={20,50,80},func=spawn_egg})
 add(enemy_map,{frame=30*1,enemy_y={40,60},func=spawn_bunny})
 add(enemy_map,{frame=30*2,enemy_y={50},func=spawn_chick})
 add(enemy_map,{frame=30*3,enemy_y={30,70},func=spawn_egg})
 add(enemy_map,{frame=30*4,enemy_y={50},func=spawn_bunny})
 add(enemy_map,{frame=30*5,enemy_y={20,80},func=spawn_chick})
 add(enemy_map,{frame=30*6,enemy_y={10,30,50,70,90},func=spawn_egg})
 add(enemy_map,{frame=30*7,enemy_y={40,60},func=spawn_bunny})
 add(enemy_map,{frame=30*8,enemy_y={50},func=spawn_chick})
 add(enemy_map,{frame=30*9,enemy_y={25,75},func=spawn_egg})
 add(enemy_map,{frame=30*10,enemy_y={35,65},func=spawn_bunny})
 add(enemy_map,{frame=30*11,enemy_y={20,50,80},func=spawn_chick})
 level_frame_count=0
 scene_start=false
 welcome_text="eggfield of greed - wave 4"
end

-- wave 5: heavy pressure - egg tunnel + chick swerve + bunnies
function reset_l02wave05()
 enemy_map={}
 -- egg tunnel opening
 add(enemy_map,{frame=30*0,enemy_y={10,20,70,80},func=spawn_egg})
 add(enemy_map,{frame=30*1,enemy_y={40,60},func=spawn_bunny})
 add(enemy_map,{frame=30*2,enemy_y={50},func=spawn_chick})
 -- chick swerve attack
 generate_yswerve(enemy_map,3,spawn_chick)
 -- flanking eggs during swerve
 add(enemy_map,{frame=30*4,enemy_y={10,90},func=spawn_egg})
 add(enemy_map,{frame=30*5,enemy_y={20,80},func=spawn_egg})
 add(enemy_map,{frame=30*6,enemy_y={15,85},func=spawn_egg})
 -- bunnies from different heights
 add(enemy_map,{frame=30*7,enemy_y={30},func=spawn_bunny})
 add(enemy_map,{frame=30*8,enemy_y={70},func=spawn_bunny})
 add(enemy_map,{frame=30*9,enemy_y={50},func=spawn_bunny})
 -- chick-bunny-egg triple threat
 add(enemy_map,{frame=30*11,enemy_y={20,40,60,80},func=spawn_chick})
 add(enemy_map,{frame=30*12,enemy_y={10,30,50,70,90},func=spawn_egg})
 add(enemy_map,{frame=30*13,enemy_y={35,65},func=spawn_bunny})
 level_frame_count=0
 scene_start=false
 welcome_text="eggfield of greed - wave 5"
end

-- wave 6: maximum pre-boss intensity
function reset_l02wave06()
 enemy_map={}
 -- dense egg barrage
 add(enemy_map,{frame=30*0,enemy_y={20,40,60,80},func=spawn_egg})
 add(enemy_map,{frame=30*1,enemy_y={30,50,70},func=spawn_chick})
 add(enemy_map,{frame=30*2,enemy_y={40,60},func=spawn_bunny})
 add(enemy_map,{frame=30*3,enemy_y={10,30,50,70,90},func=spawn_egg})
 -- chick swerve + simultaneous bunnies
 generate_yswerve(enemy_map,4,spawn_chick)
 add(enemy_map,{frame=30*5,enemy_y={25,75},func=spawn_bunny})
 add(enemy_map,{frame=30*6,enemy_y={40,60},func=spawn_bunny})
 -- egg wall
 add(enemy_map,{frame=30*7,enemy_y={10,20,30,40,60,70,80,90},func=spawn_egg})
 add(enemy_map,{frame=30*8,enemy_y={50},func=spawn_chick})
 add(enemy_map,{frame=30*9,enemy_y={30,70},func=spawn_bunny})
 -- final barrage
 add(enemy_map,{frame=30*11,enemy_y={15,35,55,75},func=spawn_chick})
 add(enemy_map,{frame=30*12,enemy_y={25,50,75},func=spawn_egg})
 add(enemy_map,{frame=30*13,enemy_y={5,15,25,35,45,55,65,75,85,95},func=spawn_egg})
 level_frame_count=0
 scene_start=false
 welcome_text="eggfield of greed - wave 6"
end

-- boss wave
function reset_l02boss()
 music(6)
 ponzi_card_wait=0
 enemy_map={}
 add(enemy_map,{frame=0,enemy_y={15},func=spawn_ponzibunny})
 level_frame_count=0
 scene_start=false
 welcome_text="eggfield of greed - boss"
end
