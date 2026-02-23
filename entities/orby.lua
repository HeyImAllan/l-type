orbys={}
function spawn_orby(py)
 local e={x=128,y=py,spd=fgspeed,sprite=80,coll_effect=orb_coll_effect}
 e.hx1,e.hy1,e.hx2,e.hy2=0,0,8,8
 e.update_hitbox=upd_hb
 e:update_hitbox()
 add(orbys,e)
end

function update_orbys(orbys)
 for e in all(orbys) do
  e.x-=e.spd
  if e.x<-10 then del(orbys,e)
  else e:update_hitbox() end
 end
end

function draw_orbys(orbys)
    for myorb in all(orbys) do
        if sin(level_frame_count/4)<0.2 then
            pal(7,0)
        end
        spr(myorb.sprite,myorb.x,myorb.y)
        pal()
        setpalt()
    end
end

function orb_coll_effect(myorb)
    sfx(06)
    myorb_hori_hitbox_middle=((myorb.hitbox[2].x-myorb.hitbox[1].x)/2)
    myorb_vert_hitbox_middle=((myorb.hitbox[2].y-myorb.hitbox[1].y)/2)
    spawn_sparks(myorb.hitbox[1].x+myorb_hori_hitbox_middle,myorb.hitbox[1].y+myorb_vert_hitbox_middle,10,10)
end
