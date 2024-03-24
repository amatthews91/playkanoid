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
  self:setCollideRect(0, 0, r * 2, r * 2)

  self.collisionResponse = 'bounce'
  self.dirX = 0
  self.dirY = 0
  self.speed = 0
end

function Ball:launch(speed, paddle, startPoint)
  self.speed = speed
  local x,y = getPaddleLaunchAngle(paddle.w, paddle.x, startPoint)
  self.dirX = x
  self.dirY = y
end

function Ball:stop()
  self.speed = 0
end

function Ball:update()
  Ball.super.update(self)

  local _, _, cols, length = self:moveWithCollisions(self.x + (self.dirX * self.speed), self.y + (self.dirY * self.speed))

  -- This only works right now as the ball moves directly up and down. Not a solution for when we have actual angles.
  if (length > 0) then
    for i = 1, length do
      local collision = cols[i].other
      if (collision.className == 'Brick') then
        collision:hit()
      end
    end

    if (length == 1 and cols[1].other.className == 'Paddle') then
      local paddle = cols[1].other
      local x, y = getPaddleLaunchAngle(paddle.w, paddle.x, cols[1].touch.x)
      self.dirX = x
      self.dirY = y
    end

    -- self.dirX = cols[1].normal.dx
    -- self.dirY = cols[1].normal.dy
    self.speed *= -1
  end
end

function getPaddleLaunchAngle(paddleWidth, paddleX, contactX)
  -- Convert the point on the screen, X, where the ball touches the paddle to an angle between 10 and 170
  -- Algorithm taken from https://stackoverflow.com/a/929107
  -- return x, y directions
  local paddleStart = (paddleX - (paddleWidth / 2))
  local lowestAngle = 20
  local angleRange = 140 -- (160 - 20) - dont go all the way flat i.e. 0 or 180
  local launchAngle = (((contactX - paddleStart) * angleRange) / paddleWidth) + lowestAngle

  local rads = math.rad(launchAngle)
  return math.cos(rads), math.sin(rads)
end