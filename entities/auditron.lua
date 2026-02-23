auditrons={}
fires={}
enemy_bullets={}
card_wait=0
function spawn_auditron(py)
 local a={}
 a.x,a.y,a.spd=140,py,0
 a.laugh,a.hp,a.isboss,a.score=true,100,true,1000
 a.hx1,a.hy1,a.hx2,a.hy2=14,38,20,48
 a.update=upd_hb
 a.hitbox={{x=-5,y=-5},{x=-5,y=-5}}
 a.shoot=auditron_fire
 add(auditrons,a)
end

function auditron_fire(type,tx,ty)
 if type=="card" then
  if card_wait>0 then return end
  card_wait=20
  add(enemy_bullets,mk_ebul(tx,ty,2,48,1,6,4))
 elseif type=="fraud" then
  add(enemy_bullets,mk_ebul(tx,ty,3,11,3,23,7))
 else
  add(enemy_bullets,mk_ebul(tx,ty,3,type=="hack" and 29 or 27,2,15,7))
 end
end

function update_enemy_bullets(enemy_bullets)
    for mybul in all(enemy_bullets) do
        if mybul.x < -10 then
            del(enemy_bullets,mybul)
        end
        if mybul.muzzle == 0 then
            mybul.x-=mybul.spd
            mybul:update_hitbox()
        end
        
    end
end
function draw_enemy_bullets(enemy_bullets)
    for mybul in all(enemy_bullets) do
        if mybul.muzzle > 0 then
            circfill(mybul.hitbox[2].x,mybul.y,mybul.muzzle,9)
            mybul.muzzle-=1
        else
            spr(mybul.sprite,mybul.x,mybul.y,mybul.width,1)
        end
    end
end

function draw_auditrons(auditrons)
    for tron in all(auditrons) do
        
        if mode == "game" then
        print("BOSS: AUDITRON", 1,10,9)
        print("HP: ", 1,16,7)
            for i=1, tron.hp/2 do
                pset(i+11,18,8)
            end
        end
        spr(138,tron.x,tron.y,6,4)
        spr(201,tron.x-8,tron.y+32,7,6)
        if tron.laugh then
            spr(137,tron.x+13,tron.y+28)
        end
        for i=0,20 do
            spawn_fire(tron.x+8+i, tron.y+6,8,5)
            spawn_fire(tron.x+8+i, tron.y+6,9,3)
        end
        spawn_fire(tron.x+rnd(56)-8,tron.y+40,8,15)
        spawn_fire(tron.x+rnd(56)-8,tron.y+40,9,5)

        draw_fires(fires)
        draw_enemy_bullets(enemy_bullets)
    end
end

wordattackanim={"hack", "fraud", "risk"}
function animate_auditron(tron)
    update_enemy_bullets(enemy_bullets)
    if tron.x >= 80 then
            tron.x-=fgspeed
    else
            tron.y+=sin(t/200)
            tron:update()
            tron.shoot("card",tron.x+14,tron.y+38+5)
            if t % 135 == 0 then
                tron.shoot(wordattackanim[flr(rnd(3))+1],tron.x+14,tron.y+38+5)
            end
            
    end
    tron.laugh=sin(t/40)<0.2
    if card_wait > 0 then
        card_wait-=1
    end 
end

function update_auditrons(auditrons)
    for tron in all(auditrons) do
        animate_auditron(tron)
    end
end

function spawn_fire(x,y,color,life)
 local e={x=x,y=y,life=rnd(life),color=color}
 e.sx,e.sy=(rnd()-.5)*2,-rnd()*4
 add(fires,e)
end

function draw_fires(fires)
    draw_shrapnel(fires)
end