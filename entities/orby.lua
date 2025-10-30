orbys={}
function spawn_orby(py)
 myorb={}
 myorb.x=128
 myorb.y=py
 myorb.spd=fgspeed
 myorb.hitbox={{x=128,y=py},
                {x=128+8,y=py+8}}
 myorb.sprite=80
 myorb.coll_effect=orb_coll_effect
 add(orbys,myorb)
end

function update_orbys(orbys)
    for myorb in all(orbys) do
    
        myorb.x-=myorb.spd
        if myorb.x < -10 then
            del(orbys,myorb)
        end
        myorb.y+=0
        myorb.hitbox={{x=myorb.x,y=myorb.y},
        {x=myorb.x+8,y=myorb.y+8}}
    
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
