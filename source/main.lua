import "CoreLibs/sprites"
import "CoreLibs/object"
import "CoreLibs/graphics"

import "paddle"
import "ball"
import "brick"

local gfx <const> = playdate.graphics

local STATES = {
  Holding = "0",
  Playing = "1"
}

local state = STATES.Holding
local paddleX = 200
local paddleY = 220

local ballR = 5
local ballStartX = 205
local ballStartY = paddleY-(ballR*2)

local paddle = Paddle(paddleX, paddleY)
local ball = Ball(ballStartX, ballStartY, ballR)

local rows = 5
local columns = 12
local bricks = {}
for i = 1,rows,1
do
  for j = 1,columns,1
  do
    if bricks[i] == nil then
      bricks [i] = {}
    end

    -- The X position was a lot of trial and error, probably doesnt work for all columns vals
    bricks[i][j] = Brick((math.floor(400 / columns) * j) - (columns + 3), i * 15, 28, 10)
    bricks[i][j]:add()
  end
end

paddle:add()
ball:add()
-- brick:add()

function playdate.update()
  gfx.sprite.update()

  paddle:handleInput()

  if (state == STATES.Holding) then
    ball:moveTo(ballStartX, ballStartY)

    if playdate.buttonIsPressed(playdate.kButtonA) or playdate.buttonIsPressed(playdate.kButtonUp) then
      ball:launch(1, paddle, ballStartX)
      state = STATES.Playing
    end
  elseif (state == STATES.Playing) then
    if playdate.buttonIsPressed(playdate.kButtonB) then
      ball:stop()
      state = STATES.Holding
    end
  end
end