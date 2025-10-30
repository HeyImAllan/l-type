auditrons={}
fires={}
enemy_bullets={}
card_wait=0
function spawn_auditron(py)
    local auditron={}
    auditron.x=140
    auditron.y=py
    auditron.spd=0
    auditron.laugh=true
    auditron.hp=100
    auditron.isboss=true
    auditron.score=1000
    auditron.update=function(self)
        self.hitbox={{x=self.x+14,y=self.y+38},
                    {x=self.x+14+6,y=self.y+38+10}}
        end
    auditron.hitbox={{x=-5,y=-5},
                 {x=-5,y=-5}}

    auditron.shoot=auditron_fire
    add(auditrons,auditron)
end

function auditron_fire(type,tx,ty)
    if type == "card" then
        if card_wait == 0 then
            card_wait=20
            local mycard={}
            mycard.x=tx
            mycard.y=ty
            mycard.spd=2
            mycard.muzzle=5
            mycard.sprite=48
            mycard.update_hitbox=function(self)
                self.hitbox={{x=self.x+1,y=self.y+1},
                            {x=self.x+6,y=self.y+4}}
                end
            mycard.width=1
            mycard:update_hitbox()
            add(enemy_bullets,mycard)
        end
    end
    if type == "fraud" then
        local myfraud={}
        myfraud.x=tx
        myfraud.y=ty
        myfraud.spd=3
        myfraud.muzzle=5
        myfraud.sprite=11
        myfraud.update_hitbox=function(self)
            self.hitbox={{x=self.x+1,y=self.y+1},
                        {x=self.x+23,y=self.y+7}}
            end
        myfraud.width=3
        myfraud:update_hitbox()
        add(enemy_bullets,myfraud)
    end
    if type == "risk" or type == "hack" then
        local risk={}
        risk.x=tx
        risk.y=ty
        risk.spd=3
        risk.muzzle=5
        if type == "hack" then
            risk.sprite=29
        else
            risk.sprite=27
        end
        risk.update_hitbox=function(self)
            self.hitbox={{x=self.x+1,y=self.y+1},
                        {x=self.x+15,y=self.y+7}}
            end
        risk:update_hitbox()    
        risk.width=2
        add(enemy_bullets,risk)
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
    if sin(t/40)<0.2 then
        tron.laugh=true
    else
        tron.laugh=false
    end
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
    local myex={x=x,y=y,life=rnd(life)}
    myex.sx=(rnd()-0.5)*2
    myex.sy=(rnd())*-4
    myex.color=color
    add(fires,myex)
end

function draw_fires(fires)
    draw_shrapnel(fires)
end