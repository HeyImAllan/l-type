function check_bull_col(all_enemies, bullets)
 for myen in all(all_enemies) do
  for mybul in all(bullets) do
   if coll(myen,mybul) then
    sfx(29)
    if myen.hp > 0 then
      myen.hp-=1
      myen.blink=5
      myen_vert_hitbox_middle=((myen.hitbox[2].y-myen.hitbox[1].y)/2)
      spawn_shrapnel(myen.hitbox[1].x,myen.hitbox[1].y+myen_vert_hitbox_middle)
      small_shwave(myen.hitbox[1].x,myen.hitbox[1].y+myen_vert_hitbox_middle,12)
    end
    if myen.hp == 0 then
        myen_hori_hitbox_middle=((myen.hitbox[2].x-myen.hitbox[1].x)/2)
        big_shwave(myen.hitbox[1].x+myen_hori_hitbox_middle,myen.hitbox[1].y+myen_vert_hitbox_middle,9)
        spawn_explosion(myen.hitbox[1].x+myen_hori_hitbox_middle,myen.hitbox[1].y+myen_vert_hitbox_middle)
        spawn_sparks(myen.hitbox[1].x+myen_hori_hitbox_middle,myen.hitbox[1].y+myen_vert_hitbox_middle,9,25)

        if myen.isboss then
          winwait=90
          spawn_explosion(myen.hitbox[1].x,myen.hitbox[1].y,false,15)
          spawn_explosion(myen.hitbox[2].x,myen.hitbox[1].y,false,30)
          spawn_explosion(myen.hitbox[1].x,myen.hitbox[2].y,false,45)
          spawn_explosion(myen.hitbox[2].x,myen.hitbox[2].y,false,60)
          if level>=max_level then
           mode="gamewon"
          else
           mode="levelcomplete"
          end
          music(-1)
        end
        del(all_enemies,myen)
        sfx(myen.sfx)
        score+=myen.score
        if not myen.isboss and flr(rnd(20))==0 then
         spawn_heart(myen.hitbox[1].x,myen.hitbox[1].y)
        end
    end
    del(bullets, mybul)
   end
  end
 end
end

function check_enemy_col(all_enemies)
 if #all_enemies > 0 and leo.health >= 1 then
  for myen in all(all_enemies) do
   if coll(leo,myen) and
    nodmg_frames == 0 then
    if myen.coll_effect != nil then
      myen:coll_effect()
    end
    sfx(00)
    leo.health=leo.health-1
    if leo.health <= 0 then
      spawn_explosion(leo.hitbox[1].x,leo.hitbox[1].y,true)
      big_shwave(leo.hitbox[1].x, leo.hitbox[1].y,12)
      spawn_sparks(leo.hitbox[1].x, leo.hitbox[1].y,12,25)
      gameoverwait=60
      sfx(05)
    else
      leo.blink=5
      nodmg_frames=120
    end
    
   end
  end
 end
end

function coll(a,b)
 local ah,bh=a.hitbox,b.hitbox
 return not(ah[1].y>bh[2].y or ah[2].y<bh[1].y
        or ah[2].x<bh[1].x or ah[1].x>bh[2].x)
end

