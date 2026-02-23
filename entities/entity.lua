-- shared hitbox updater: uses flat offset fields hx1,hy1,hx2,hy2
function upd_hb(self)
 self.hitbox={
  {x=self.x+self.hx1,y=self.y+self.hy1},
  {x=self.x+self.hx2,y=self.y+self.hy2}
 }
end

-- common enemy constructor
-- e=table, py=spawn y, hp,sfxn,sc=stats, hx1/hy1/hx2/hy2=hitbox offsets
function mk_en(e,py,hp,sfxn,sc,hx1,hy1,hx2,hy2)
 e.x,e.y,e.blink,e.hp,e.sfx,e.score=128,py,0,hp,sfxn,sc
 e.hx1,e.hy1,e.hx2,e.hy2=hx1,hy1,hx2,hy2
 e.update_hitbox=upd_hb
 e:update_hitbox()
end

-- enemy bullet constructor (shared by auditron + ponzi)
function mk_ebul(tx,ty,spd,sprite,w,hx2,hy2)
 local b={x=tx,y=ty,spd=spd,muzzle=5,sprite=sprite,width=w}
 b.hx1,b.hy1,b.hx2,b.hy2=1,1,hx2,hy2
 b.update_hitbox=upd_hb
 b:update_hitbox()
 return b
end
