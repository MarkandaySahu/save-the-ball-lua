local love = require"love"

function Button(text,func,func_param,width,height)
    return{
        width = width or 100,
        height = height or 100,
        func_param = func_param,
        func = func or function() print("This button has no function attached.")end,
        button_X=0,
        button_Y=0,
        text_x=0,
        text_y=0,
        text = text,
        checkPressed = function (self, mouse_x,mouse_y,cursor_radius)
            if (mouse_x + cursor_radius >= self.button_X) and (mouse_x - cursor_radius <= self.button_X + self.width) then
                if (mouse_y + cursor_radius >= self.button_Y) and (mouse_y - cursor_radius <= self.button_Y + self.height) then
                    if self.func_param then
                        self.func(self.func_param)
                    else
                        self.func()
                    end
                end
            end
        end,

        draw = function (self,button_X,button_Y,text_x,text_y)--to draw the button.
            self.button_X = button_X or self.button_X
            self.button_Y = button_Y or self.button_Y
            
            if text_x then
                self.text_x = text_x + self.button_X
            else
                self.text_x = self.button_X
            end

            if text_y then
                self.text_y = text_y + self.button_Y
            else
                self.text_y = self.button_Y
            end

            love.graphics.setColor(0.6,0.6,0.6)
            love.graphics.rectangle("fill",self.button_X,self.button_Y,self.width,self.height)

            love.graphics.setColor(0,0,0)
            love.graphics.print(self.text,self.text_x,self.text_y)
            love.graphics.setColor(1,1,1)
        end
    }
end
return Button