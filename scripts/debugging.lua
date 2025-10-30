--debugging
function draw_hitboxes(a,b)
 a_left=a.hitbox[1].x
 a_right=a.hitbox[2].x
 a_top=a.hitbox[1].y
 a_bot=a.hitbox[2].y
 b_left=b.hitbox[1].x
 b_right=b.hitbox[2].x
 b_top=b.hitbox[1].y
 b_bot=b.hitbox[2].y
 
 for i=b_left,b_right do
  pset(i,b_top,8)
  pset(i,b_bot,8)
 end
 for i=b_top,b_bot do
  pset(b_left,i,8)
  pset(b_right,i,8)
 end
 for i=a_left,a_right do
  pset(i,a_top,8)
  pset(i,a_bot,8)
 end
 for i=a_top,a_bot do
  pset(a_left,i,8)
  pset(a_right,i,8)
 end
end