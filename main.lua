-- MainScript.lua

local function createWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 400, 0, 300)
    window.Position = UDim2.new(0.5, -200, 0.5, -150)
    window.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    window.BackgroundTransparency = 0.5  -- Полупрозрачность
    window.BorderSizePixel = 0  -- Без рамки
    window.Parent = screenGui

    -- Заголовок окна
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 40)
    header.Text = title
    header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.TextSize = 20
    header.TextAlign = Enum.TextXAlignment.Center
    header.Parent = window

    -- Перетаскивание окна
    local dragging, dragInput, startPos, startDragPos

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = window.Position
            startDragPos = input.Position
            input.Consumed = true
        end
    end)

    header.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - startDragPos
            window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return window
end

local function createButton(parent, buttonText, position, size, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.Text = buttonText
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BackgroundTransparency = 0.5  -- Полупрозрачность
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Parent = parent

    -- Обработчик клика
    button.MouseButton1Click:Connect(callback)
    
    return button
end

local function createToggleButton(parent, buttonText, position, size, callback)
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = size
    toggleButton.Position = position
    toggleButton.Text = buttonText
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleButton.BackgroundTransparency = 0.5  -- Полупрозрачность
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 18
    toggleButton.Parent = parent
    
    local isToggled = false
    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        if isToggled then
            toggleButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
        else
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        callback(isToggled)
    end)
    
    return toggleButton
end

-- Основной код
local window = createWindow("Fluent-style Window")

local button = createButton(window, "Click Me", UDim2.new(0.5, -50, 0.4, 0), UDim2.new(0, 100, 0, 50), function()
    print("Button Clicked!")
end)

local toggleButton = createToggleButton(window, "Toggle Me", UDim2.new(0.5, -50, 0.6, 0), UDim2.new(0, 100, 0, 50), function(isToggled)
    if isToggled then
        print("Toggled On")
    else
        print("Toggled Off")
    end
end)
