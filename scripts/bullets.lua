function shoot()
 if shoot_wait==0 then
  local b={x=leo.x+13,y=leo.y+8,spd=3}
  b.hx1,b.hy1,b.hx2,b.hy2=1,1,6,6
  b.update_hitbox=upd_hb
  b:update_hitbox()
  sfx(1)
  muzzle,shoot_wait=3,3
  add(bullets,b)
 end
end

function move_bullets()
 for b in all(bullets) do
  if b.x>128 then del(bullets,b)
  else b.x+=b.spd b:update_hitbox() end
 end
 if shoot_wait>0 then shoot_wait-=1 end
end

function draw_bullets()
 for mybul in all(bullets) do
  spr(16,mybul.x,mybul.y)
 end
end
