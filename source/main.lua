import "CoreLibs/sprites"
import "CoreLibs/object"
import "CoreLibs/graphics"

import "paddle"
import "ball"

local gfx <const> = playdate.graphics

local STATES = {
  Holding = "0",
  Playing = "1"
}

local state = STATES.Holding
local paddleX = 200
local paddleY = 220
local ballR = 5

local paddle = Paddle(paddleX, paddleY)
local ball = Ball(paddleX, paddleY-(ballR*2), ballR)

paddle:add()
ball:add()

function playdate.update()
  gfx.sprite.update()

  paddle:handleInput()

  if (state == STATES.Holding) then
    ball:moveTo(paddle.x, paddle.y - (ballR*2))

    if playdate.buttonIsPressed(playdate.kButtonA) then
      ball:launch(1, 0, -10)
      state = STATES.Playing
      print(state)
    end
  elseif (state == STATES.Playing) then
    if playdate.buttonIsPressed(playdate.kButtonB) then
      ball:stop()
      state = STATES.Holding
    end
  end
end