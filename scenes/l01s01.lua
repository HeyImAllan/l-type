-- level one scenes
boss_defeated=false
enemies_spawned=0
function update_l01()
  
  if scene_start then
    local wave_resets = {
      [1] = reset_l01wave01,
      [2] = reset_l01wave02,
      [3] = reset_l01wave03,
      [4] = reset_l01wave04,
      [5] = reset_l01wave05,
      [6] = reset_l01boss
    }

    local reset_func = wave_resets[halloweenwave]
    if reset_func then reset_func() end
  end
 process_enemy_map(enemy_map)
 update_gravestones(all_gravestones)
 update_pumpkins(all_pumpkins)
 update_orbys(orbys)
 update_bats()
 update_auditrons(auditrons)
 check_enemy_col(all_pumpkins)
 check_enemy_col(bats)
 check_enemy_col(orbys)
 check_enemy_col(enemy_bullets)
 check_bull_col(auditrons,bullets)
 check_bull_col(all_pumpkins, bullets)
 check_bull_col(bats, bullets)

 level_frame_count+=1
 enemies_spawned = #bats + #orbys + #pumpkins + #auditrons
 if enemies_spawned <= 0 and level_frame_count > 300 then
   halloweenwave+=1
   scene_start=true
 end
end


function draw_l01()
 -- gui elements
 clouds(2)
 starfield(40)
 draw_ground()

 -- moon
 spr(128,100,8,2,2)
 if level_frame_count < 30*5 then
   print(welcome_text,10,28,menu_gfx())
 end

 if level_frame_count % (30*10) == 0 then
    spawn_gravestone(128,100)
 end

 draw_bats(bats)
 draw_gravestones(all_gravestones)
 draw_pumpkins(all_pumpkins)
 draw_orbys(orbys)
 draw_auditrons(auditrons)
 if level_frame_count == 32767 then
    level_frame_count = 1
 end

 draw_generic_game()
 
end

function process_enemy_map(enemy_map)
 for frame_instr in all(enemy_map) do
  if frame_instr.frame == level_frame_count then
   local frame_spawn=frame_instr.enemy_y
   for py in all(frame_spawn) do
    frame_instr.func(py)
   end
  end
 end
end

function generate_yswerve(target_map,start_time_seconds,spawn_func)
yswerve={10,20,30,40,50,60,70,80,90,90,80,70,60,50,40,30,20,10}
 j=1
 for i=start_time_seconds,start_time_seconds+10,1 do
  local enemy_scene={frame=30*i,enemy_y={yswerve[j]},func=spawn_func}
  j = j+1
  add(target_map,enemy_scene)
 end
end
function reset_l01()
  music(0)
  level_frame_count=0
  all_gravestones={}
  auditrons={}
  bats={}
  pumpkins={}
  orbys={}
  starfield_array = {}
  clouds_array = {}
end

function reset_l01wave01()
  enemy_map = {
    -- Introductie: enkele vleermuizen
    {frame=30*0,enemy_y={50},func=spawn_bat},
    {frame=30*2,enemy_y={40},func=spawn_bat},

    -- Eerste verdwaalde orb
    {frame=30*3,enemy_y={60},func=spawn_orby},

    -- Vleermuizen in een rij
    {frame=30*5,enemy_y={30,50,70},func=spawn_bat},

    -- Rustmoment
    {frame=30*8,enemy_y={45},func=spawn_bat},

    -- Orb in de weg
    {frame=30*9,enemy_y={50},func=spawn_orby},

    -- Vleermuizen in diagonale opbouw
    {frame=30*11,enemy_y={30},func=spawn_bat},
    {frame=30*12,enemy_y={40},func=spawn_bat},
    {frame=30*13,enemy_y={50},func=spawn_bat},

    -- Orb net na de vleermuizen
    {frame=30*14,enemy_y={55},func=spawn_orby},

    -- Vleermuizen links en rechts
    {frame=30*16,enemy_y={20,80},func=spawn_bat},

    -- Rustmoment
    {frame=30*18,enemy_y={50},func=spawn_bat},

    -- Laatste vleermuisrij
    {frame=30*21,enemy_y={25,50,75},func=spawn_bat},

    -- Laatste orb als afsluiter
    {frame=30*20,enemy_y={45},func=spawn_orby},

    -- Finale vleermuisgroep, zodat ze ~8–9 sec in beeld blijven
    {frame=30*24,enemy_y={20,50,80},func=spawn_bat},
    {frame=30*25,enemy_y={35,65},func=spawn_bat},
    {frame=30*27,enemy_y={25,75},func=spawn_bat},

    -- Optioneel: een laatste vleermuis die net voor het einde spawnt
    {frame=30*29,enemy_y={50},func=spawn_bat}
  }
  level_frame_count=0
  scene_start=false
  welcome_text="graveyard of greed - wave 1"
end

function reset_l01wave02()
enemy_map = {}

 -- Swerve-aanval vanaf seconde 0
 generate_yswerve(enemy_map,0,spawn_bat)

 -- Orb-patroon die de swerve belemmert (sneller en dichter op elkaar)
 add(enemy_map,{frame=30*0.5,enemy_y={30,50,70},func=spawn_orby})
 add(enemy_map,{frame=30*1.5,enemy_y={40,60},func=spawn_orby})
 add(enemy_map,{frame=30*2.5,enemy_y={20,80},func=spawn_orby})
 add(enemy_map,{frame=30*3.5,enemy_y={35,65},func=spawn_orby})
 add(enemy_map,{frame=30*4.5,enemy_y={45,55},func=spawn_orby})

 -- Vleermuizen tussen orb-gaten
 add(enemy_map,{frame=30*2,enemy_y={50},func=spawn_bat})
 add(enemy_map,{frame=30*3,enemy_y={30,70},func=spawn_bat})
 add(enemy_map,{frame=30*4,enemy_y={40,60},func=spawn_bat})

 -- Mini-climax: orb-tunnel + vleermuisflank
 add(enemy_map,{frame=30*6,enemy_y={10,20,30,70,80,90},func=spawn_orby})
 add(enemy_map,{frame=30*6.5,enemy_y={50},func=spawn_bat})
 add(enemy_map,{frame=30*7,enemy_y={25,75},func=spawn_bat})

 -- Laatste dreiging
 add(enemy_map,{frame=30*8,enemy_y={45,55},func=spawn_orby})
 add(enemy_map,{frame=30*8.5,enemy_y={50},func=spawn_bat})
 level_frame_count=0
 scene_start=false
 welcome_text="graveyard of greed - wave 2"
end

function reset_l01wave03()
  enemy_map={
    -- Opening: smalle orb-tunnel
    {frame=30*0,enemy_y={20,30,70,80},func=spawn_orby},
    {frame=30*2,enemy_y={25,35,65,75},func=spawn_orby},

    -- Eerste vleermuis in de opening
    {frame=30*3,enemy_y={50},func=spawn_bat},

    -- Zigzag orb-patroon
    {frame=30*5,enemy_y={10,30,50,70,90},func=spawn_orby},
    {frame=30*6,enemy_y={20,40,60,80},func=spawn_orby},

    -- Vleermuizen in de gaten
    {frame=30*7,enemy_y={35},func=spawn_bat},
    {frame=30*8,enemy_y={65},func=spawn_bat},

    -- Rustmoment met enkele orbs
    {frame=30*10,enemy_y={45,55},func=spawn_orby},

    
  }
  -- Swerve-aanval met vleermuizen
  generate_yswerve(enemy_map,12,spawn_bat)

  -- Orbs die de zijkanten blokkeren tijdens swerve
  add(enemy_map,{frame=30*13,enemy_y={10,90},func=spawn_orby})
  add(enemy_map,{frame=30*15,enemy_y={15,85},func=spawn_orby})
  add(enemy_map,{frame=30*17,enemy_y={20,80},func=spawn_orby})

  -- Finale: orb-muur met vleermuizen ertussen
  add(enemy_map,{frame=30*25,enemy_y={10,20,30,40,60,70,80,90},func=spawn_orby})
  add(enemy_map,{frame=30*26,enemy_y={50},func=spawn_bat})
  add(enemy_map,{frame=30*27,enemy_y={35,65},func=spawn_bat})

  -- Laatste barrage
  add(enemy_map,{frame=30*29,enemy_y={5,15,25,35,45,55,65,75,85,95},func=spawn_orby})


 level_frame_count=0
 scene_start=false
 welcome_text="graveyard of greed - wave 3"
end

function reset_l01wave04()
 enemy_map = {}

 -- Open rustig met een enkele pompoen
 add(enemy_map,{frame=30*1,enemy_y={50},func=spawn_pumpkin})

 -- Vleermuisduo, niet te dicht op elkaar
 add(enemy_map,{frame=30*3,enemy_y={30},func=spawn_bat})
 add(enemy_map,{frame=30*4,enemy_y={70},func=spawn_bat})

 -- Pompoen in de flank
 add(enemy_map,{frame=30*6,enemy_y={20},func=spawn_pumpkin})

 -- Orb als positioneringsobstakel
 add(enemy_map,{frame=30*7,enemy_y={50},func=spawn_orby})

 -- Rustmoment, dan pompoen in het midden
 add(enemy_map,{frame=30*10,enemy_y={60},func=spawn_pumpkin})

 -- Vleermuislijn, langzaam opgebouwd
 add(enemy_map,{frame=30*12,enemy_y={40},func=spawn_bat})
 add(enemy_map,{frame=30*13,enemy_y={50},func=spawn_bat})
 add(enemy_map,{frame=30*14,enemy_y={60},func=spawn_bat})

 -- Laatste pompoen als visuele afsluiter
 add(enemy_map,{frame=30*17,enemy_y={35},func=spawn_pumpkin})

 level_frame_count = 0
 scene_start = false
 welcome_text = "graveyard of greed - wave 4"
end

function reset_l01wave05()
 enemy_map = {}

 -- Opening barrage: orb-tunnel + vleermuisflank
 add(enemy_map,{frame=30*0,enemy_y={20,30,70,80},func=spawn_orby})
 add(enemy_map,{frame=30*1,enemy_y={40,60},func=spawn_bat})
 add(enemy_map,{frame=30*2,enemy_y={25,75},func=spawn_bat})

 -- Pompoen in het midden
 add(enemy_map,{frame=30*3,enemy_y={50},func=spawn_pumpkin})

 -- Swerve-aanval vleermuizen
 generate_yswerve(enemy_map,4,spawn_bat)

 -- Orbs die de swerve flankeren
 add(enemy_map,{frame=30*5,enemy_y={10,90},func=spawn_orby})
 add(enemy_map,{frame=30*6,enemy_y={15,85},func=spawn_orby})
 add(enemy_map,{frame=30*7,enemy_y={20,80},func=spawn_orby})

 -- Pompoen links en rechts
 add(enemy_map,{frame=30*8,enemy_y={30},func=spawn_pumpkin})
 add(enemy_map,{frame=30*9,enemy_y={70},func=spawn_pumpkin})

 -- Hartje als beloning
 --  add(enemy_map,{frame=30*10,enemy_y={50},func=spawn_heart})

 -- Vleermuislijn + orb-muur
 add(enemy_map,{frame=30*11,enemy_y={20,40,60,80},func=spawn_bat})
 add(enemy_map,{frame=30*12,enemy_y={10,30,50,70,90},func=spawn_orby})

 -- Pompoen in het midden, net voor de climax
 add(enemy_map,{frame=30*13,enemy_y={50},func=spawn_pumpkin})

 -- Laatste vleermuisflank
 add(enemy_map,{frame=30*14,enemy_y={25,75},func=spawn_bat})
 add(enemy_map,{frame=30*15,enemy_y={35,65},func=spawn_bat})

 -- Laatste hartje als hoop
--  add(enemy_map,{frame=30*16,enemy_y={50},func=spawn_heart})

 level_frame_count = 0
 scene_start = false
 welcome_text = "graveyard of greed - wave 5"
end

function reset_l01boss()
  music(6)
  enemy_map = {}
  add(enemy_map,{frame=0,enemy_y={15},func=spawn_auditron})
  level_frame_count = 0
  scene_start = false
  welcome_text = "graveyard of greed - boss"
end

ground_shift=0
function draw_ground()
 if ground_shift >= 8 then
   ground_shift = 0
 end
 for i=0,128,8 do
   spr(58,i-ground_shift,112)
 end
 ground_shift+=fgspeed
 rectfill(0,120,128,128,4)
end
