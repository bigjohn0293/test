]]

local SimpleLib = {}

-->>: SERVICES
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

function SimpleLib:Window(winName)
    local sliderInUse = false

    local function dragify(Frame)
        local dragToggle = nil
        local dragInput = nil
        local dragStart = nil
        local startPos = nil

        local function updateInput(input)
            local Delta = input.Position - dragStart
            local Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + Delta.X,
                startPos.Y.Scale, startPos.Y.Offset + Delta.Y
            )
            TweenService:Create(Frame, TweenInfo.new(0.15), {Position = Position}):Play()
        end

        Frame.InputBegan:Connect(function(input)
            if sliderInUse then return end

            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) 
            and UIS:GetFocusedTextBox() == nil then
                dragToggle = true
                dragStart = input.Position
                startPos = Frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)

        Frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if input == dragInput and dragToggle then
                updateInput(input)
            end
        end)
    end

    local MainGUI = Instance.new("ScreenGui")
    MainGUI.IgnoreGuiInset = true
    MainGUI.Parent = CoreGui

    local MainBG = Instance.new("Frame")
    MainBG.Name = "MainBG"
    MainBG.Position = UDim2.new(0.18555417656898499, 0, 0.2684144675731659, 0)
    MainBG.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MainBG.Size = UDim2.new(0, 341, 0, 247)
    MainBG.BorderSizePixel = 0
    MainBG.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
    MainBG.Parent = MainGUI

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Rotation = -90
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 88, 88)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    }
    UIGradient.Parent = MainBG

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainBG

    local SectionContainer = Instance.new("Frame")
    SectionContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SectionContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    SectionContainer.BackgroundTransparency = 0.5
    SectionContainer.Position = UDim2.new(0.49933719635009766, 0, 0.5518152713775635, 0)
    SectionContainer.Name = "SectionContainer"
    SectionContainer.Size = UDim2.new(0, 323, 0, 203)
    SectionContainer.BorderSizePixel = 0
    SectionContainer.BackgroundColor3 = Color3.fromRGB(71, 78, 91)
    SectionContainer.Parent = MainBG

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = SectionContainer

    local TabsContainer = Instance.new("Frame")
    TabsContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabsContainer.AnchorPoint = Vector2.new(0.5, 0)
    TabsContainer.BackgroundTransparency = 1
    TabsContainer.Position = UDim2.new(0.5, 0, 0, 0)
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Size = UDim2.new(0, 323, 0, 26)
    TabsContainer.BorderSizePixel = 0
    TabsContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabsContainer.Parent = SectionContainer

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = TabsContainer

    local Divider = Instance.new("Frame")
    Divider.AnchorPoint = Vector2.new(0.5, 1)
    Divider.Name = "Divider"
    Divider.Position = UDim2.new(0.5, 0, 0.15763546526432037, 0)
    Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Divider.Size = UDim2.new(0, 323, 0, 6)
    Divider.BorderSizePixel = 0
    Divider.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
    Divider.Parent = SectionContainer

    local Header = Instance.new("TextLabel")
    Header.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    Header.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    Header.AnchorPoint = Vector2.new(0.5, 0.5)
    Header.TextSize = 14
    Header.Size = UDim2.new(0, 206, 0, 20)
    Header.TextColor3 = Color3.fromRGB(255, 255, 255)
    Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Header.Text = winName
    Header.Name = "Header"
    Header.TextWrapped = true
    Header.BackgroundTransparency = 1
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Position = UDim2.new(0.3281143605709076, 0, 0.07287449389696121, 0)
    Header.BorderSizePixel = 0
    Header.TextScaled = true
    Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Header.Parent = MainBG

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Parent = MainBG

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    CloseBtn.Active = false
    CloseBtn.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    CloseBtn.TextSize = 14
    CloseBtn.Size = UDim2.new(0, 15, 0, 20)
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseBtn.Text = "X"
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Selectable = false
    CloseBtn.TextWrapped = true
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.TextXAlignment = Enum.TextXAlignment.Left
    CloseBtn.Position = UDim2.new(0.9488334655761719, 0, 0.07287449389696121, 0)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.TextScaled = true
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Parent = MainBG

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    MinimizeBtn.Active = false
    MinimizeBtn.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    MinimizeBtn.TextSize = 14
    MinimizeBtn.Size = UDim2.new(0, 15, 0, 20)
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeBtn.Text = "-"
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Selectable = false
    MinimizeBtn.TextWrapped = true
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.TextXAlignment = Enum.TextXAlignment.Left
    MinimizeBtn.Position = UDim2.new(0.8931151032447815, 0, 0.07287449389696121, 0)
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.TextScaled = true
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.Parent = MainBG

    local HeaderBtn = Instance.new("TextButton")
    HeaderBtn.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    HeaderBtn.Active = false
    HeaderBtn.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    HeaderBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    HeaderBtn.TextSize = 14
    HeaderBtn.Size = UDim2.new(0, 206, 0, 20)
    HeaderBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    HeaderBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    HeaderBtn.Text = winName
    HeaderBtn.Name = "Header"
    HeaderBtn.TextWrapped = true
    HeaderBtn.BackgroundTransparency = 1
    HeaderBtn.Position = UDim2.new(0.4999698996543884, 0, 0.8718757629394531, 0)
    HeaderBtn.Selectable = false
    HeaderBtn.BorderSizePixel = 0
    HeaderBtn.TextScaled = true
    HeaderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HeaderBtn.Parent = MainGUI
    HeaderBtn.Visible = false

    CloseBtn.MouseButton1Click:Connect(function()
        MainGUI:Destroy()
    end)

    MinimizeBtn.MouseButton1Click:Connect(function()
        MainBG.Visible = false
        HeaderBtn.Visible = true
    end)

    HeaderBtn.MouseButton1Click:Connect(function()
        HeaderBtn.Visible = false
        MainBG.Visible = true
    end)

    dragify(MainBG)

    local Tabs = {}
    local LoadedSections = {}

    function Tabs:AddSection(SectionName)
        -- Tab Button
        local Tab1 = Instance.new("ImageButton")
        Tab1.Name = SectionName
        Tab1.Size = UDim2.new(0, 73, 0, 26)
        Tab1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Tab1.BackgroundColor3 = Color3.fromRGB(53, 58, 67)
        Tab1.BorderSizePixel = 0
        Tab1.AutoButtonColor = false
        Tab1.Parent = TabsContainer

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = Tab1

        local TabName = Instance.new("TextLabel")
        TabName.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        TabName.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        TabName.AnchorPoint = Vector2.new(0.5, 0.5)
        TabName.ZIndex = 2
        TabName.TextSize = 14
        TabName.Size = UDim2.new(0, 59, 0, 12)
        TabName.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabName.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabName.Text = SectionName
        TabName.Name = "TabName"
        TabName.BackgroundTransparency = 1
        TabName.Position = UDim2.new(0.5, 0, 0.5, 0)
        TabName.TextWrapped = true
        TabName.BorderSizePixel = 0
        TabName.TextScaled = true
        TabName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabName.Parent = Tab1

        local Filler = Instance.new("Frame")
        Filler.Active = true
        Filler.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Filler.AnchorPoint = Vector2.new(0.5, 1)
        Filler.Name = "Filler"
        Filler.Position = UDim2.new(0.5, 0, 1, 0)
        Filler.Size = UDim2.new(0, 73, 0, 13)
        Filler.Selectable = true
        Filler.BorderSizePixel = 0
        Filler.BackgroundColor3 = Color3.fromRGB(53, 58, 67)
        Filler.Parent = Tab1

        local Section = Instance.new("ScrollingFrame")
        Section.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Section.AnchorPoint = Vector2.new(0.5, 1)
        Section.BorderSizePixel = 0
        Section.CanvasSize = UDim2.new(0, 0, 0, 0)
        Section.ScrollBarImageColor3 = Color3.fromRGB(38, 42, 49)
        Section.MidImage = "rbxassetid://3062506202"
        Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Section.ScrollBarThickness = 6
        Section.Name = SectionName
        Section.Size = UDim2.new(0, 315, 0, 157)
        Section.Selectable = false
        Section.TopImage = "rbxassetid://3062506445"
        Section.Position = UDim2.new(0.5, 0, 0.9655172228813171, 0)
        Section.BottomImage = "rbxassetid://3062505976"
        Section.BackgroundTransparency = 1
        Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Section.Parent = SectionContainer
        Section.Visible = false

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Padding = UDim.new(0, 2)
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Parent = Section

        table.insert(LoadedSections, Section)

        Tab1.MouseButton1Click:Connect(function()
            for i, v in pairs(LoadedSections) do
                v.Visible = false
                TabsContainer[v.Name].BackgroundColor3 = Color3.fromRGB(53, 58, 67)
                TabsContainer[v.Name].Filler.BackgroundColor3 = Color3.fromRGB(53, 58, 67)
            end

            Section.Visible = true
            Tab1.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
            Filler.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
        end)

        local Contents = {}

        function Contents:Button(lbltxt, cb)
            local BtnInstance = Instance.new("ImageButton")
            BtnInstance.Name = "BtnInstance"
            BtnInstance.Size = UDim2.new(0, 303, 0, 28)
            BtnInstance.BorderColor3 = Color3.fromRGB(0, 0, 0)
            BtnInstance.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
            BtnInstance.BorderSizePixel = 0
            BtnInstance.AutoButtonColor = false
            BtnInstance.Parent = Section

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.Name = "BtnCorner"
            BtnCorner.CornerRadius = UDim.new(0, 12)
            BtnCorner.Parent = BtnInstance

            local BtnName = Instance.new("TextLabel")
            BtnName.TextWrapped = true
            BtnName.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            BtnName.AnchorPoint = Vector2.new(0.5, 0.5)
            BtnName.ZIndex = 2
            BtnName.TextSize = 14
            BtnName.Size = UDim2.new(0, 255, 0, 14)
            BtnName.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnName.BorderColor3 = Color3.fromRGB(0, 0, 0)
            BtnName.Text = lbltxt
            BtnName.Name = "BtnName"
            BtnName.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            BtnName.BackgroundTransparency = 1
            BtnName.TextXAlignment = Enum.TextXAlignment.Left
            BtnName.Position = UDim2.new(0.5200527906417847, 0, 0.5, 0)
            BtnName.BorderSizePixel = 0
            BtnName.TextScaled = true
            BtnName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BtnName.Parent = BtnInstance

            local BtnStroke = Instance.new("UIStroke")
            BtnStroke.Color = Color3.fromRGB(85, 85, 85)
            BtnStroke.Name = "BtnStroke"
            BtnStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
            BtnStroke.Parent = BtnInstance

            local BtnIco = Instance.new("ImageLabel")
            BtnIco.Name = "BtnIco"
            BtnIco.BorderColor3 = Color3.fromRGB(0, 0, 0)
            BtnIco.ImageRectOffset = Vector2.new(0, 152)
            BtnIco.Size = UDim2.new(0, 16, 0, 16)
            BtnIco.Position = UDim2.new(0.05546887218952179, 0, 0.5, 0)
            BtnIco.AnchorPoint = Vector2.new(0.5, 0.5)
            BtnIco.Image = "rbxassetid://16884178577"
            BtnIco.BackgroundTransparency = 1
            BtnIco.ImageRectSize = Vector2.new(36, 36)
            BtnIco.ZIndex = 2
            BtnIco.BorderSizePixel = 0
            BtnIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BtnIco.Parent = BtnInstance

            BtnInstance.MouseEnter:Connect(function()
                BtnInstance.BackgroundColor3 = Color3.fromRGB(47, 52, 61)
                BtnStroke.Color = Color3.fromRGB(255, 255, 255)
            end)

            BtnInstance.MouseLeave:Connect(function()
                BtnInstance.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
                BtnStroke.Color = Color3.fromRGB(85, 85, 85)
            end)

            BtnInstance.MouseButton1Click:Connect(function()
                pcall(cb)
            end)
        end

        function Contents:Label(lbltxt, cb)
            local LabelInstance = Instance.new("ImageButton")
            LabelInstance.Name = "LabelInstance"
            LabelInstance.Size = UDim2.new(0, 303, 0, 28)
            LabelInstance.BorderColor3 = Color3.fromRGB(0, 0, 0)
            LabelInstance.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
            LabelInstance.BorderSizePixel = 0
            LabelInstance.AutoButtonColor = false
            LabelInstance.Parent = Section

            local LabelCorner = Instance.new("UICorner")
            LabelCorner.Name = "LabelCorner"
            LabelCorner.CornerRadius = UDim.new(0, 12)
            LabelCorner.Parent = LabelInstance

            local LabelName = Instance.new("TextLabel")
            LabelName.TextWrapped = true
            LabelName.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            LabelName.AnchorPoint = Vector2.new(0.5, 0.5)
            LabelName.ZIndex = 2
            LabelName.TextSize = 14
            LabelName.Size = UDim2.new(0, 255, 0, 14)
            LabelName.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelName.BorderColor3 = Color3.fromRGB(0, 0, 0)
            LabelName.Text = lbltxt
            LabelName.Name = "LabelName"
            LabelName.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            LabelName.BackgroundTransparency = 1
            LabelName.TextXAlignment = Enum.TextXAlignment.Left
            LabelName.Position = UDim2.new(0.5200527906417847, 0, 0.5, 0)
            LabelName.BorderSizePixel = 0
            LabelName.TextScaled = true
            LabelName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelName.Parent = LabelInstance

            local LabelStroke = Instance.new("UIStroke")
            LabelStroke.Color = Color3.fromRGB(85, 85, 85)
            LabelStroke.Name = "LabelStroke"
            LabelStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
            LabelStroke.Parent = LabelInstance

            local LabelIco = Instance.new("ImageLabel")
            LabelIco.Name = "LabelIco"
            LabelIco.BorderColor3 = Color3.fromRGB(0, 0, 0)
            LabelIco.ImageRectOffset = Vector2.new(418, 0)
            LabelIco.Size = UDim2.new(0, 16, 0, 16)
            LabelIco.Position = UDim2.new(0.05546887218952179, 0, 0.5, 0)
            LabelIco.AnchorPoint = Vector2.new(0.5, 0.5)
            LabelIco.Image = "rbxassetid://16884178261"
            LabelIco.BackgroundTransparency = 1
            LabelIco.ImageRectSize = Vector2.new(36, 36)
            LabelIco.ZIndex = 2
            LabelIco.BorderSizePixel = 0
            LabelIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelIco.Parent = LabelInstance

            local upd = {}

            function upd:Update(newtxt)
                LabelName.Text = newtxt
            end

            return upd
        end

        function Contents:Toggle(lbltxt, val, cb)
            local ToggleInstance = Instance.new("ImageButton")
            ToggleInstance.Name = "ToggleInstance"
            ToggleInstance.Size = UDim2.new(0, 303, 0, 28)
            ToggleInstance.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleInstance.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
            ToggleInstance.BorderSizePixel = 0
            ToggleInstance.AutoButtonColor = false
            ToggleInstance.Parent = Section

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.CornerRadius = UDim.new(0, 12)
            ToggleCorner.Parent = ToggleInstance

            local ToggleName = Instance.new("TextLabel")
            ToggleName.TextWrapped = true
            ToggleName.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            ToggleName.AnchorPoint = Vector2.new(0.5, 0.5)
            ToggleName.ZIndex = 2
            ToggleName.TextSize = 14
            ToggleName.Size = UDim2.new(0, 255, 0, 14)
            ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleName.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleName.Text = lbltxt
            ToggleName.Name = "ToggleName"
            ToggleName.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            ToggleName.BackgroundTransparency = 1
            ToggleName.TextXAlignment = Enum.TextXAlignment.Left
            ToggleName.Position = UDim2.new(0.5200527906417847, 0, 0.5, 0)
            ToggleName.BorderSizePixel = 0
            ToggleName.TextScaled = true
            ToggleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleName.Parent = ToggleInstance

            local ToggleStroke = Instance.new("UIStroke")
            ToggleStroke.Color = Color3.fromRGB(85, 85, 85)
            ToggleStroke.Name = "ToggleStroke"
            ToggleStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
            ToggleStroke.Parent = ToggleInstance

            local ToggleOff = Instance.new("ImageLabel")
            ToggleOff.Name = "ToggleOff"
            ToggleOff.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleOff.ImageRectOffset = Vector2.new(248, 462)
            ToggleOff.Size = UDim2.new(0, 16, 0, 16)
            ToggleOff.Position = UDim2.new(0.05546887218952179, 0, 0.5, 0)
            ToggleOff.AnchorPoint = Vector2.new(0.5, 0.5)
            ToggleOff.Image = "rbxassetid://16167590639"
            ToggleOff.BackgroundTransparency = 1
            ToggleOff.ImageRectSize = Vector2.new(36, 36)
            ToggleOff.ZIndex = 2
            ToggleOff.BorderSizePixel = 0
            ToggleOff.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleOff.Parent = ToggleInstance
            ToggleOff.Visible = false

            local ToggleOn = Instance.new("ImageLabel")
            ToggleOn.Visible = false
            ToggleOn.Name = "ToggleOn"
            ToggleOn.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleOn.ImageRectOffset = Vector2.new(286, 386)
            ToggleOn.Size = UDim2.new(0, 16, 0, 16)
            ToggleOn.Position = UDim2.new(0.05546887218952179, 0, 0.5, 0)
            ToggleOn.AnchorPoint = Vector2.new(0.5, 0.5)
            ToggleOn.Image = "rbxassetid://16167590639"
            ToggleOn.BackgroundTransparency = 1
            ToggleOn.ImageRectSize = Vector2.new(36, 36)
            ToggleOn.ZIndex = 2
            ToggleOn.BorderSizePixel = 0
            ToggleOn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleOn.Parent = ToggleInstance

            local toggled = val
            if val then
                ToggleOn.Visible = true
                pcall(cb, toggled)
            else
                ToggleOff.Visible = true
            end

            ToggleInstance.MouseEnter:Connect(function()
                ToggleInstance.BackgroundColor3 = Color3.fromRGB(47, 52, 61)
                ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
            end)

            ToggleInstance.MouseLeave:Connect(function()
                ToggleInstance.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
                ToggleStroke.Color = Color3.fromRGB(85, 85, 85)
            end)

            ToggleInstance.MouseButton1Click:Connect(function()
                toggled = not toggled
                if toggled then
                    ToggleOn.Visible = true
                    ToggleOff.Visible = false
                else
                    ToggleOff.Visible = true
                    ToggleOn.Visible = false
                end
                pcall(cb, toggled)
            end)
        end

        function Contents:TextBox(lbltxt, sort, cb)
            local TextBoxInstance = Instance.new("ImageButton")
            TextBoxInstance.Size = UDim2.new(0, 303, 0, 42)
            TextBoxInstance.Name = "TextBoxInstance"
            TextBoxInstance.Position = UDim2.new(0, 0, 0.22167488932609558, 0)
            TextBoxInstance.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBoxInstance.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
            TextBoxInstance.BorderSizePixel = 0
            TextBoxInstance.AutoButtonColor = false
            TextBoxInstance.Parent = Section

            local TextBoxCorner = Instance.new("UICorner")
            TextBoxCorner.Name = "TextBoxCorner"
            TextBoxCorner.CornerRadius = UDim.new(0, 12)
            TextBoxCorner.Parent = TextBoxInstance

            local TextBoxName = Instance.new("TextLabel")
            TextBoxName.TextWrapped = true
            TextBoxName.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxName.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBoxName.ZIndex = 2
            TextBoxName.TextSize = 14
            TextBoxName.Size = UDim2.new(0, 255, 0, 14)
            TextBoxName.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxName.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBoxName.Text = lbltxt
            TextBoxName.Name = "TextBoxName"
            TextBoxName.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextBoxName.BackgroundTransparency = 1
            TextBoxName.TextXAlignment = Enum.TextXAlignment.Left
            TextBoxName.Position = UDim2.new(0.5200527906417847, 0, 0.3333333432674408, 0)
            TextBoxName.BorderSizePixel = 0
            TextBoxName.TextScaled = true
            TextBoxName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxName.Parent = TextBoxInstance

            local TextBoxStroke = Instance.new("UIStroke")
            TextBoxStroke.Color = Color3.fromRGB(85, 85, 85)
            TextBoxStroke.Name = "TextBoxStroke"
            TextBoxStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
            TextBoxStroke.Parent = TextBoxInstance

            local TextBoxIco = Instance.new("ImageLabel")
            TextBoxIco.Name = "TextBoxIco"
            TextBoxIco.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBoxIco.ImageRectOffset = Vector2.new(114, 0)
            TextBoxIco.Size = UDim2.new(0, 16, 0, 16)
            TextBoxIco.Position = UDim2.new(0.05546887218952179, 0, 0.5, 0)
            TextBoxIco.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBoxIco.Image = "rbxassetid://16884178261"
            TextBoxIco.BackgroundTransparency = 1
            TextBoxIco.ImageRectSize = Vector2.new(36, 36)
            TextBoxIco.ZIndex = 2
            TextBoxIco.BorderSizePixel = 0
            TextBoxIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxIco.Parent = TextBoxInstance

            local TextBoxFrame = Instance.new("Frame")
            TextBoxFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBoxFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBoxFrame.Name = "TextBoxFrame"
            TextBoxFrame.BackgroundTransparency = 1
            TextBoxFrame.Position = UDim2.new(0.5199999809265137, 0, 0.7289999723434448, 0)
            TextBoxFrame.Size = UDim2.new(0, 255, 0, 13)
            TextBoxFrame.ZIndex = 2
            TextBoxFrame.BorderSizePixel = 0
            TextBoxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxFrame.Parent = TextBoxInstance

            local TBFCORNER = Instance.new("UICorner")
            TBFCORNER.Name = "TBFCORNER"
            TBFCORNER.CornerRadius = UDim.new(1, 0)
            TBFCORNER.Parent = TextBoxFrame

            local TBFSTROKE = Instance.new("UIStroke")
            TBFSTROKE.Color = Color3.fromRGB(85, 85, 85)
            TBFSTROKE.Name = "TBFSTROKE"
            TBFSTROKE.BorderStrokePosition = Enum.BorderStrokePosition.Inner
            TBFSTROKE.Parent = TextBoxFrame

            local TextBoxInput = Instance.new("TextBox")
            TextBoxInput.CursorPosition = -1
            TextBoxInput.Active = false
            TextBoxInput.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxInput.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBoxInput.PlaceholderText = "Type Here.."
            TextBoxInput.TextSize = 14
            TextBoxInput.Size = UDim2.new(0, 240, 0, 10)
            TextBoxInput.Name = "TextBoxInput"
            TextBoxInput.ZIndex = 2
            TextBoxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBoxInput.Text = ""
            TextBoxInput.Selectable = false
            TextBoxInput.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBoxInput.BorderSizePixel = 0
            TextBoxInput.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
            TextBoxInput.BackgroundTransparency = 1
            TextBoxInput.TextXAlignment = Enum.TextXAlignment.Left
            TextBoxInput.TextWrapped = true
            TextBoxInput.ClearTextOnFocus = false
            TextBoxInput.TextScaled = true
            TextBoxInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxInput.Parent = TextBoxFrame

            TextBoxInstance.MouseEnter:Connect(function()
                TextBoxInstance.BackgroundColor3 = Color3.fromRGB(47, 52, 61)
                TextBoxStroke.Color = Color3.fromRGB(255, 255, 255)
            end)

            TextBoxInstance.MouseLeave:Connect(function()
                TextBoxInstance.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
                TextBoxStroke.Color = Color3.fromRGB(85, 85, 85)
            end)

            if sort == 1 then
                TextBoxInput:GetPropertyChangedSignal("Text"):Connect(function()
                    pcall(cb, TextBoxInput.Text)
                end)
            elseif sort == 2 then
                TextBoxInput.FocusLost:Connect(function()
                    pcall(cb, TextBoxInput.Text)
                end)
            elseif sort == 3 then
                TextBoxInput.FocusLost:Connect(function(ep)
                    if ep then
                        pcall(cb, TextBoxInput.Text)
                    end
                end)
            else
                warn("[SIMPLE LIB]: TextBox requires a valid sort mode: 1 = TextChanged, 2 = FocusLost, 3 = EnterPressed.")
            end
        end

        function Contents:Slider(lbltxt, min, max, norm, cb)
            local SliderInstance = Instance.new("ImageButton")
            SliderInstance.Size = UDim2.new(0, 303, 0, 42)
            SliderInstance.Name = "SliderInstance"
            SliderInstance.Position = UDim2.new(0, 0, 0.22167488932609558, 0)
            SliderInstance.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SliderInstance.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
            SliderInstance.BorderSizePixel = 0
            SliderInstance.AutoButtonColor = false
            SliderInstance.Parent = Section

            local SliderCorner = Instance.new("UICorner")
            SliderCorner.Name = "SliderCorner"
            SliderCorner.CornerRadius = UDim.new(0, 12)
            SliderCorner.Parent = SliderInstance

            local SliderName = Instance.new("TextLabel")
            SliderName.TextWrapped = true
            SliderName.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            SliderName.AnchorPoint = Vector2.new(0.5, 0.5)
            SliderName.ZIndex = 2
            SliderName.TextSize = 14
            SliderName.Size = UDim2.new(0, 255, 0, 14)
            SliderName.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderName.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SliderName.Text = lbltxt
            SliderName.Name = "SliderName"
            SliderName.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            SliderName.BackgroundTransparency = 1
            SliderName.TextXAlignment = Enum.TextXAlignment.Left
            SliderName.Position = UDim2.new(0.5200527906417847, 0, 0.3333333432674408, 0)
            SliderName.BorderSizePixel = 0
            SliderName.TextScaled = true
            SliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderName.Parent = SliderInstance

            local SliderStroke = Instance.new("UIStroke")
            SliderStroke.Color = Color3.fromRGB(85, 85, 85)
            SliderStroke.Name = "SliderStroke"
            SliderStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
            SliderStroke.Parent = SliderInstance

            local SliderIco = Instance.new("ImageLabel")
            SliderIco.Name = "SliderIco"
            SliderIco.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SliderIco.ImageRectOffset = Vector2.new(480, 290)
            SliderIco.Size = UDim2.new(0, 16, 0, 16)
            SliderIco.Position = UDim2.new(0.05546887218952179, 0, 0.5, 0)
            SliderIco.AnchorPoint = Vector2.new(0.5, 0.5)
            SliderIco.Image = "rbxassetid://16167590639"
            SliderIco.BackgroundTransparency = 1
            SliderIco.ImageRectSize = Vector2.new(16, 16)

            SliderIco.ZIndex = 2
            SliderIco.BorderSizePixel = 0
            SliderIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderIco.Parent = SliderInstance

            local SliderBG = Instance.new("Frame")
            SliderBG.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
            SliderBG.Name = "SliderBG"
            SliderBG.BackgroundTransparency = 1
            SliderBG.Position = UDim2.new(0.5199999809265137, 0, 0.7289999723434448, 0)
            SliderBG.Size = UDim2.new(0, 255, 0, 13)
            SliderBG.ZIndex = 2
            SliderBG.BorderSizePixel = 0
            SliderBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderBG.Parent = SliderInstance

            local SFCORNER = Instance.new("UICorner")
            SFCORNER.Name = "SFCORNER"
            SFCORNER.CornerRadius = UDim.new(1, 0)
            SFCORNER.Parent = SliderBG

            local SFSTROKE = Instance.new("UIStroke")
            SFSTROKE.Color = Color3.fromRGB(85, 85, 85)
            SFSTROKE.Name = "SFSTROKE"
            SFSTROKE.BorderStrokePosition = Enum.BorderStrokePosition.Inner
            SFSTROKE.Parent = SliderBG

            local SliderInput = Instance.new("Frame")
            SliderInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SliderInput.AnchorPoint = Vector2.new(0, 0.5)
            SliderInput.Name = "SliderInput"
            SliderInput.Position = UDim2.new(0, 0, 0.5, 0)
            SliderInput.Size = UDim2.new(0, 0, 1, 0)
            SliderInput.ZIndex = 2
            SliderInput.BorderSizePixel = 0
            SliderInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderInput.Parent = SliderBG

            local SICORNER = Instance.new("UICorner")
            SICORNER.Name = "SICORNER"
            SICORNER.CornerRadius = UDim.new(1, 0)
            SICORNER.Parent = SliderInput

            SliderInstance.MouseEnter:Connect(function()
                SliderInstance.BackgroundColor3 = Color3.fromRGB(47, 52, 61)
                SliderStroke.Color = Color3.fromRGB(255, 255, 255)
            end)

            SliderInstance.MouseLeave:Connect(function()
                SliderInstance.BackgroundColor3 = Color3.fromRGB(38, 42, 49)
                SliderStroke.Color = Color3.fromRGB(85, 85, 85)
            end)

            local dragging = false
            local lastValue = 0

            local function setFromAlpha(alpha)
                alpha = math.clamp(alpha, 0, 1)
                local value = math.floor(min + (max - min) * alpha + 0.5)

                SliderInput.Size = UDim2.new(alpha, 0, 1, 0)

                lastValue = value
            end

            local function updateFromInput(x)
                local rel = (x - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X
                setFromAlpha(rel)
            end

            setFromAlpha((norm - min) / (max - min))

            SliderBG.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then

                    dragging = true
                    sliderInUse = true
                    updateFromInput(input.Position.X)
                end
            end)

            UIS.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch) then

                    updateFromInput(input.Position.X)
                end
            end)

            UIS.InputEnded:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch) then

                    dragging = false
                    sliderInUse = false
                    if cb then
                        pcall(cb, lastValue)
                    end
                end
            end)
        end

        return Contents
    end

    return Tabs
end

return SimpleLib
