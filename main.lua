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
    },
    points = 0,
    levels = {15,30,60,120}
}
local player={
    radius=20,
    x=30,
    y=30
}
local buttons={
    menu_state={}
}
local function changeGameState(state)
    game.state["menu"] = (state == "menu")
    game.state["paused"] = (state == "paused")
    game.state["running"] = (state == "running")
    game.state["ended"] = (state == "ended")
end
local function startNewGame()
    changeGameState("running")
    game.points = 0--when the game starts our score will be zero.
    Enemies = {
        enemy(1)
    }
end

function love.mousepressed(x,y,but,istouch,press)--it'll check the mouse press event(pg-16,MKGVI).
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
        for i = 1, #Enemies do
            if not Enemies[i]:checkTouched(player.x,player.y,player.radius) then
                Enemies[i]:move(player.x,player.y)--(pg-72,MKSI)
                for j = 1, #game.levels, 1 do
                    if math.floor(game.points)==game.levels[j] then
                        table.insert(Enemies,1,enemy(game.difficulty*(j+1)))
                        game.points = game.points + 1
                    end
                end
            else
                changeGameState("menu")
            end
        end
    end
    game.points = game.points + dt
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
        love.graphics.printf(math.floor(game.points),love.graphics.newFont(24),0,10,love.graphics.getWidth(),"center")
        for i = 1, #Enemies do
            Enemies[i]:draw()
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