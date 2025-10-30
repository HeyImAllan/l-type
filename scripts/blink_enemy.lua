function blink_sprite(myen)
 if myen.blink > 0 then
  for i=0,14 do
   pal(i,7)
  end
  myen.blink-=1
 end
end
