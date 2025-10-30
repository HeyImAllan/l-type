function leo_vert_bob(leo)
 -- vertical bobbing
	if (frame_count >= 30) then
		frame_count=0
	if (leo.vertical_bob == 0) then
			leo.vertical_bob=1
		else
			leo.vertical_bob=0
		end
	end
end

-- propeller gfx
function prop_gfx(leo)
	if (frame_count % 2 == 0) then
	 leo.prop=35
	else
	 leo.prop=19
	end
end