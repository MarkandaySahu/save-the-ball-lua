local love = require"love"

function Enemy(level)
    local dice = math.random(1,4)--determine from which side enemy will pop up.
    local _x,_y
    local _radius = 20

    if dice==1 then
        _x=math.random(0,love.graphics.getWidth())
        _y=-_radius*4
    elseif dice==2 then
        _x=-_radius*4
        _y=math.random(0,love.graphics.getHeight())
    elseif dice==3 then
        _x=math.random(0,love.graphics.getWidth())
        _y=love.graphics.getHeight() + (_radius*4)
    elseif dice==4 then
        _x=love.graphics.getWidth() + (_radius*4)
        _y=math.random(0,love.graphics.getWidth())
    end

    return{
        level=level or 1,
        radius=_radius,
        x=_x,
        y=_y,

        move = function (self,player_x,player_y)
            --for x coordinate
            if player_x - self.x >0 then--enemy is at the left side of the player
                self.x = self.x + self.level--move the enemy a level closer to player
            elseif player_x - self.x <0 then--enemy is at the Right side of the player
                self.x = self.x - self.level--move the enemy a level closer to player
            end
            --for y coordinate
            if player_y - self.y >0 then--enemy is at the upper side of the player
                self.y = self.y + self.level--move the enemy a level closer to player
            elseif player_y - self.y <0 then--enemy is at the lower side of the player
                self.y = self.y - self.level--move the enemy a level closer to player
            end
        end,
        draw = function (self)
            love.graphics.setColor(1,0.5,0.7) 
            love.graphics.circle("fill",self.x,self.y,self.radius)
            love.graphics.setColor(1,1,1)
        end
    }
end

return Enemy