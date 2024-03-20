local gfx <const> = playdate.graphics

class('Ball').extends(gfx.sprite)

function Ball:init(x, y, r)
  Ball.super.init(self)

  self:moveTo(x, y)

  local circle = gfx.image.new(r*2, r*2)
  gfx.pushContext(circle)
      gfx.fillCircleAtPoint(r, r, r)
  gfx.popContext()
  self:setImage(circle)
  self:setCollideRect(x, y, r * 2, r * 2)

  self.dirX = 0
  self.dirY = 0
  self.speed = 0
end

function Ball:launch(speed, x, y)
  self.speed = speed
  self.dirX = x
  self.dirY = y
end

function Ball:stop()
  self.speed = 0
end

function Ball:update()
  self:moveWithCollisions(self.x + (self.dirX * self.speed), self.y + (self.dirY * self.speed))
end