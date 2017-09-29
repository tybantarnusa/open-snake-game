Food = {
    x = 0,
    y = 0,
    size = 10
}

-- Derived class method new
function Food:new(o, x, y)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = x or 0
    self.y = y or 0
    return o
end

function Food:setPosition(x, y)
    self.x = x
    self.y = y
end

function Food:draw()
    love.graphics.rectangle("fill", self.x - 5, self.y - 5, self.size, self.size)
end
