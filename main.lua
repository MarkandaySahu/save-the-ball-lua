local love = require"love"
local player={
    radius=20,
    x=30,
    y=30
}
local game ={
    state={
        menu=true,
        paused=false,
        running=false,
        ended=false
    }
}
--------------------------------------------------------------------------------------
function love.load()
    love.window.setTitle("Save the ball")--to set the title of the window
    love.mouse.setVisible(false)--this will make the mouse invisible
end
--------------------------------------------------------------------------------------
function love.update(dt)
    player.x,player.y=love.mouse.getPosition()
end
--------------------------------------------------------------------------------------
function love.draw()

    love.graphics.printf(
    "FPS: "..love.timer.getFPS(),
    love.graphics.newFont(16),
    10,--the x position on screen
    love.graphics.getHeight()-30,--the y position on screen
    love.graphics.getWidth()--Wrap the line after this many horizontal pixels.
    )--this will get you the FPS counter

    if game.state["running"] then
        love.graphics.circle("fill",player.x,player.y,player.radius)
    end
    if not game.state["running"] then
        love.graphics.circle("fill",player.x,player.y,player.radius/2)
    end
    
end