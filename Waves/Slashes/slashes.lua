timer = 0
slashes = {}
--slashes will contain a {} with the projectile and existance time
function Update()
  timer = timer + 1
  if timer < 1000 then
    --spawns slashes
    if timer % 60 == 0 then
      local x = math.random(-Arena.width/2,Arena.width/2)
      local y = math.random(-Arena.height/2,Arena.height/2)
      local rotation = math.random(1,360)
      local slash = CreateProjectile("slash1",x,y)
      slash.SetVar("hit",false)
      slash.sprite.rotation = rotation
      table.insert(slashes,{slash,0})
    end
    if timer % 12 == 0 then
      if #slashes > 0 then
        for i = 1,#slashes do
          --sprite and damage inflicting changing
          slashes[i][2] = slashes[i][2] + 1
          if slashes[i][2] == 2 then
            slashes[i][1].sprite.Set("slash2")
          elseif slashes[i][2] == 4 then
            slashes[i][1].sprite.Set("slash3")
            slashes[i][1].SetVar("hit",true)
          elseif slashes[i][2] == 6 then
            slashes[i][1].sprite.Set("slash4")
          elseif slashes[i][2] == 8 then
            slashes[i][1].sprite.Set("slash5")
            slashes[i][1].SetVar("hit",false)
          elseif slashes[i][2] == 10 then
            slashes[i][1].sprite.Set("slash6")
          elseif slashes[i][2] == 12 then
            slashes[i][1].sprite.Set("emptySlash")
          elseif slashes[i][2] == 18 then
            slashes[i][1].sprite.Set("slash6")
          elseif slashes[i][2] == 20 then
            slashes[i][1].sprite.Set("slash5")
            slashes[i][1].SetVar("hit",true)
          elseif slashes[i][2] == 22 then
            slashes[i][1].sprite.Set("slash4")
          elseif slashes[i][2] == 24 then
            slashes[i][1].sprite.Set("slash3")
            slashes[i][1].SetVar("hit",false)
          elseif slashes[i][2] == 26 then
            slashes[i][1].sprite.Set("slash2")
          elseif slashes[i][2] == 28 then
            slashes[i][1].sprite.Set("slash1")
          elseif slashes[i][2] == 30 then
            slashes[i][1].sprite.Set("emptySlash")
          end
        end
      end
    end
  else
    EndWave()
  end
end
--checks if the slash can hit
function OnHit(bullet)
  if bullet.GetVar("hit") == true then
    Player.Hurt(2)
  end
end
