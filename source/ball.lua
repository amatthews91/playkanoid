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
end