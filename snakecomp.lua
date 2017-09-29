-- Meta class
SnakeComp = {
    x = 0,
    y = 0,
    speed = 100,
    size = 20,
    timer = 0,
    current = -1,
    next = 0,
    child = nil,
    responseTime = 0,
    response = true
}

-- Derived class method new
function SnakeComp:new(o, x, y, responseTime)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = x or 0
    self.y = y or 0
    self.responseTime = responseTime or 0
    return o
end

-- Derived class method update
function SnakeComp:update(delta)
        if love.keyboard.isDown('up') then
            self.next = 0
            self.response = true
        elseif love.keyboard.isDown('right') then
            self.next = 1
            self.response = true
        elseif love.keyboard.isDown('down') then
            self.next = 2
            self.response = true
        elseif love.keyboard.isDown('left') then
            self.next = 3
            self.response = true
        end
    
    print(self.response, self.responseTime, child)

    if self.response then
        self.timer = self.timer + delta
        if self.timer > self.responseTime then
            self.response = false
            self.current = self.next
            self.timer = 0
        end
    end

    if self.current == 0 then
        self.y = self.y - self.speed * delta
    elseif self.current == 1 then
        self.x = self.x + self.speed * delta
    elseif self.current == 2 then
        self.y = self.y + self.speed * delta
    elseif self.current == 3 then
        self.x = self.x - self.speed * delta
    end

    if self.child ~= nil then
        self.child:update(delta)
    end
end

-- Derived class method draw
function SnakeComp:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)

    if self.child ~= nil then
        self.child:draw()
    end
end

-- Derived class method setChild
function SnakeComp:setChild(comp)
    self.child = comp
end

function SnakeComp:getChild()
    return self.child
end

function SnakeComp:setResponseTime(time)
    self.responseTime = time
end

function SnakeComp:setPosition(x, y)
    self.x = x
    self.y = y
end

function SnakeComp:makeChild()
    if self.child ~= nil then
        self.child:makeChild()
    else
        self.child = SnakeComp:new(nil, self.x, self.y)
        self.child:setResponseTime(self.responseTime + 0.2)
        self:setCurrent(-1)
    end
end

function SnakeComp:setCurrent(cur)
    self.current = cur
end
