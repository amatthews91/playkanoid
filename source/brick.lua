local gfx <const> = playdate.graphics

class('Brick').extends(gfx.sprite)

function Brick:init(x, y, w, h, health)
  Brick.super.init(self)
  self:moveTo(x, y)

  local rect = gfx.image.new(w, h)
  gfx.pushContext(rect)
    gfx.fillRect(0, 0, w, h)
  gfx.popContext()
  self:setImage(rect)
  self:setCollideRect(0, 0, w, h)
  self.isDestroyed = false
end

function Brick:hit()
  self:remove()
  self.isDestroyed = true
end
