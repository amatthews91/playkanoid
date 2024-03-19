local gfx <const> = playdate.graphics

class('Paddle').extends(gfx.sprite)

local function getPaddlePosition(crankPos)
  -- Effectively rotate the crank position 90 degrees counter-clockwise
  -- So 0 is now at 9o'clock
  local rotatedPos = crankPos > 270 and crankPos - 270 or crankPos + 90

  if rotatedPos > 270 then return 0
  elseif rotatedPos > 180 then return 400
  else return rotatedPos * 2.22 end
end

function Paddle:init(x, y)
  local h = 10
  local w = 40

  Paddle.super.init(self)
  self:moveTo(x, y)

  local rect = gfx.image.new(w, h)
  gfx.pushContext(rect)
    gfx.fillRect(0, 0, w, h)
  gfx.popContext()
  self:setImage(rect)

  self.y = y
  self.speed = 10
end

-- This is not in the update function because back in main trying to stick the ball to the paddle causes the ball to lag behind.
-- So for now call this manually from main update function
function Paddle:handleInput()
  local newPaddlePosition = getPaddlePosition(playdate.getCrankPosition())

  -- The two didn't play nice together for now I'm just gonna say it's one or the other
  if not playdate.isCrankDocked() then
    self:moveTo(newPaddlePosition, self.y)
  else
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
      self:moveBy(-self.speed, 0)
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
      self:moveBy(self.speed, 0)
    end
  end
end