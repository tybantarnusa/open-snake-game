require "snakecomp"
require "food"

math.randomseed( os.time() )

function love.load()
    snake = SnakeComp:new(nil, 250, 250)
    child1 = SnakeComp:new(nil, 250, 250)
    child2 = SnakeComp:new(nil, 250, 250)

    snake:makeChild()
    snake:makeChild()
    snake:makeChild()
    snake:makeChild()

    local x = math.random(10, 790)
    local y = math.random(10, 590)

    food = Food:new(nil, x, y)
end

function love.update(dt)
    snake:update(dt)

    if (food.x > snake.x) and (food.x < snake.x + 50) and (food.y > snake.y) and (food.y < snake.y + 50) then
        local x = math.random(10, 790)
        local y = math.random(10, 590)
        food:setPosition(x, y)
    end
end

function love.draw()
    snake:draw()
    food:draw()
end
