function draw_gameover()
  print("you died!",30,40,rnd(16))
  print("press ❎ to play",30,48,9)
end

function draw_gamewin()
  print("congraturations you win!",14,40,rnd(16))
  print("press ❎ to play",30,48,9)
  print("score: "..score.."00",32,56,rnd(16))
end