-- powerups
function afterburner_processing() 
 leo.prop=3
 leo.speed_bonus=2
 afterburner_time=afterburner_time+1	 
	afterburner_gfx=afterburner_gfx+1
 if (afterburner_gfx > 55) then
  afterburner_gfx=51
 end
 if (leo.sx != 0 or leo.sy != 0) then
  leo.sx=leo.sx*leo.speed_bonus
  leo.sy=leo.sy*leo.speed_bonus
 end
 if (afterburner_time > afterburner_time_max) then
  afterburner_on = false
  afterburner_time=0
 end
end