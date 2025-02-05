local love = require"love"
local conf = require"conf"
local enemy = require"Enemy"
local button = require"Button"

math.randomseed(os.time())--(pg-14,MKGVI)
local game ={
    difficulty=1,
    state={
        menu=true,
        paused=false,
        running=false,
        ended=false
    }
}
local player={
    radius=20,
    x=30,
    y=30
}
local buttons={
    menu_state={}
}
local enemies={}
local function startNewGame()
    game.state["menu"]=false
    game.state["running"]=true
    
    table.insert(enemies,1,enemy())
end

function love.mousepressed(x,y,but,istouch,press)--it'll check the mouse press event.
    if not game.state["running"] then--the button press(1) will only work in non running state of the game.
        if but==1 then
            if game.state['menu'] then
                for index in pairs(buttons.menu_state) do--iterate through all the buttons to check which one was clicked
                    buttons.menu_state[index]:checkPressed(x,y,player.radius)
                end
            end
        end
    end
end
--------------------------------------------------------------------------------------
function love.load()
    love.window.setTitle("Save the ball")--to set the title of the window
    love.mouse.setVisible(false)--this will make the mouse invisible

    buttons.menu_state.play_game = button("Play Game",startNewGame,nil,120,40)
    buttons.menu_state.settings = button("Settings",nil,nil,120,40)
    buttons.menu_state.exit_game = button("Exit Game",love.event.quit,nil,120,40)

end

--------------------------------------------------------------------------------------
function love.update(dt)
    player.x,player.y=love.mouse.getPosition()
    if game.state["running"] then
        for i = 1, #enemies do
            enemies[i]:move(player.x,player.y)--(pg-72,MKSI)
        end
    end
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
        for i = 1, #enemies do
            enemies[i]:draw()
        end
        love.graphics.circle("fill",player.x,player.y,player.radius)
    elseif game.state["menu"] then
        buttons.menu_state.play_game:draw(10,20,30,10)
        buttons.menu_state.settings:draw(10,80,30,10)
        buttons.menu_state.exit_game:draw(10,140,30,10)
    end
    if not game.state["running"] then
        love.graphics.circle("fill",player.x,player.y,player.radius/2)
    end

end