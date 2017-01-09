Arena.ResizeImmediate(160,160)
spawn1 = CreateProjectile("beamer",Arena.width/2,100)
spawn2 = CreateProjectile("beamer",(Arena.width/2)-20,100)
spawn3 = CreateProjectile("beamer",(-Arena.width/2)+20,100)
spawn4 = CreateProjectile("beamer",(-Arena.width/2),100)
spawn1.sprite.rotation = 180
spawn2.sprite.rotation = 180
spawn3.sprite.rotation = 180
spawn4.sprite.rotation = 180
timer = 0
spawn1.SetVar("move",2)
spawn2.SetVar("move",1)
spawn3.SetVar("move",2)
spawn4.SetVar("move",1)
spawners = {spawn1,spawn2,spawn3,spawn4}
lastmoved = 0
bullets = {}
gone = 0
timePause = false
function newBullet(turned,bullet)
bullet.SetVar("turn",false)
bullet.SetVar("until",0)
if turned == 120 then
bullet.SetVar("xmove",-6)
bullet.SetVar("ymove",-4)
elseif turned == 130 then
bullet.SetVar("xmove",-5)
bullet.SetVar("ymove",-5)
elseif turned == 140 then
bullet.SetVar("xmove",-4)
bullet.SetVar("ymove",-6)
elseif turned == 150 then
bullet.SetVar("xmove",-3)
bullet.SetVar("ymove",-7)
elseif turned == 160 then
bullet.SetVar("xmove",-2)
bullet.SetVar("ymove",-8)
elseif turned == 170 then
bullet.SetVar("xmove",-1)
bullet.SetVar("ymove",-9)
elseif turned == 180 then
bullet.SetVar("xmove",0)
bullet.SetVar("ymove",-10)
elseif turned == 190 then
bullet.SetVar("xmove",1)
bullet.SetVar("ymove",-9)
elseif turned == 200 then
bullet.SetVar("xmove",2)
bullet.SetVar("ymove",-8)
elseif turned == 210 then
bullet.SetVar("xmove",3)
bullet.SetVar("ymove",-7)
elseif turned == 220 then
bullet.SetVar("xmove",4)
bullet.SetVar("ymove",-6)
elseif turned == 230 then
bullet.SetVar("xmove",5)
bullet.SetVar("ymove",-5)
elseif turned == 240 then
bullet.SetVar("xmove",6)
bullet.SetVar("ymove",-4)
end
end
function shoot(x,y,turn)
local bullet = CreateProjectile("bullet", x, y)
-- example: distance between the bullet and the player
table.insert(bullets, bullet)
bullet.SetVar("hit",true)
newBullet(turn,bullet)
end
function Update()
timer = timer + 1
if timer == 200 then
timePause = true
elseif timer == 270 then
timePause = false
end
for i=1,#bullets do
local bullet = bullets[i]
if timePause == false then
if bullet.GetVar("turn") == true then
if bullet.isactive then
bullet.Move(bullet.GetVar("distance_x")*2, bullet.GetVar("distance_y")*2)
end
else
bullet.move(bullet.GetVar("xmove"),bullet.GetVar("ymove"))
bullet.SetVar("until",(bullet.GetVar("until")+1))
if bullet.GetVar("until") == 10 then
bullet.SetVar("turn",true)
local distance = math.sqrt(math.pow((Player.x+math.random(-10,10)) - (bullet.x+math.random(-10,10)), 2) + math.pow((Player.y+math.random(-10,10)) - (bullet.y+math.random(-10,10)), 2))
bullet.SetVar("distance_x", (Player.x - bullet.x) / distance)
bullet.SetVar("distance_y", (Player.y - bullet.y) / distance)
end
end
else
if bullet.x < Player.x then
bullet.Move(-5,0)
else
bullet.Move(5,0)
end
if bullet.y < Player.y then
bullet.Move(0,-5)
else
bullet.Move(0,5)
end
end
end
moved = math.floor(timer/5)
if moved == lastmoved + 1 then
lastmoved = lastmoved + 1
if timePause == false then
for i = 1,4 do
if spawners[i].GetVar("move") == 1 then
if spawners[i].sprite.rotation == 120 then
spawners[i].sprite.rotation = 130
spawners[i].SetVar("move",2)
else
spawners[i].sprite.rotation = spawners[i].sprite.rotation - 10
end
else
if spawners[i].sprite.rotation == 240 then
spawners[i].sprite.rotation = 230
spawners[i].SetVar("move",1)
else
spawners[i].sprite.rotation = spawners[i].sprite.rotation + 10
end
end
if spawners[i] == spawn1 then
if moved % 8 == 0 then
shoot(Arena.width/2,100,spawners[i].sprite.rotation)
end
elseif spawners[i] == spawn2 then
if moved % 8 == 2 then
shoot((Arena.width/2)-20,100,spawners[i].sprite.rotation)
end
elseif spawners[i] == spawn3 then
if moved % 8 == 4 then
shoot((-Arena.width/2)+20,100,spawners[i].sprite.rotation)
end
else
if moved % 8 == 6 then
shoot(Arena.width/2,100,spawners[i].sprite.rotation)
end
end
end
end
end
if timer == 500 then
lastmoved = 314
moved = 413
for i = 1,#bullets do
i = i - gone
local bullet = bullets[i]
table.remove(bullets,i)
bullet.Remove()
gone = gone + 1
end
spawn1.Remove()
spawn2.Remove()
spawn3.Remove()
spawn4.Remove()
EndWave()
end
end
function OnHit(bullet)
Player.Hurt(1)
end
