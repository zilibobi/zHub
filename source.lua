------------------------- zHub v. 1.0 ------------------------
------ Creative Commons BY-NC 4.0 International License ------
-- https://creativecommons.org/licenses/by-nc/4.0/legalcode --
-------------- https://github.com/zilibobi/zHub --------------
------------------------- by zilibobi ------------------------

if _G.zHubLoaded then
	return
end

_G.zHubLoaded = true

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local typeData = {}
local reservedKeys = {}
local localPages = {}

local changable = false

local infoPresets = {
	["Default"] = TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
	["DefaultFast"] = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
	["DefaultQuick"] = TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
	["Quint"] = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
}

local mouse = Players.LocalPlayer:GetMouse()
local camera = workspace.CurrentCamera

local function tween(obj, info, goal, yield)
	local tween = TweenService:Create(obj, info, goal)
	tween:Play()

	if yield then
		tween.Completed:Wait()
	end
end

local screen = Instance.new("ScreenGui")
screen.DisplayOrder = math.huge
screen.OnTopOfCoreBlur = true
screen.IgnoreGuiInset = true
screen.ResetOnSpawn = false

local legal = Instance.new("Frame")
legal.Name = "legal"
legal.ZIndex = 2
legal.Size = UDim2.new(1, 0, 0, 445)
legal.BackgroundTransparency = 1
legal.Parent = screen

local title1 = Instance.new("TextLabel")
title1.Name = "title"
title1.AnchorPoint = Vector2.new(0.5, 0)
title1.ZIndex = 2
title1.Size = UDim2.new(1, 0, 0, 14)
title1.BackgroundTransparency = 1
title1.Position = UDim2.new(0.5, 0, 0, 0)
title1.BorderSizePixel = 0
title1.FontSize = Enum.FontSize.Size14
title1.TextSize = 14
title1.TextColor3 = Color3.fromRGB(255, 255, 255)
title1.Text = "License Terms"
title1.Font = Enum.Font.GothamSemibold
title1.Parent = legal

local desc1 = Instance.new("TextLabel")
desc1.Name = "desc"
desc1.AnchorPoint = Vector2.new(0.5, 1)
desc1.ZIndex = 2
desc1.Size = UDim2.new(1, 0, 0, 410)
desc1.BackgroundTransparency = 1
desc1.Position = UDim2.new(0.5, 0, 1, 0)
desc1.BorderSizePixel = 0
desc1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
desc1.FontSize = Enum.FontSize.Size14
desc1.TextSize = 14
desc1.RichText = true
desc1.TextColor3 = Color3.fromRGB(255, 255, 255)
desc1.Text = "zHub is distributed under the <b>Creative Commons BY-NC 4.0 International</b> license.\n\nYou can use the script as long as you provide attribution and don't use it for commercial purposes.\n\n<font size=\"15\">Examples of what you <b>can</b> do:</font>\n\n\u{2022} Use the script for personal use\n\u{2022} Use the script for a non-commercial project (with attribution)\n\u{2022} Modify the script to use for non-commercial purposes (with attribution)\n\n<font size=\"15\">Examples of what you <b>cannot</b> do:</font>\n\n\u{2022} Use the script for commercial purposes\n\u{2022} Distribute the script (without attribution)\n\nThese examples do not replace the actual terms.\n\n<font color=\"#66a9cc\">https://creativecommons.org/licenses/by-nc/4.0/legalcode</font>\n\nIf you have any questions regarding the license and the terms, message me on Discord - zilibobi#8836."
desc1.TextYAlignment = Enum.TextYAlignment.Top
desc1.TextWrap = true
desc1.Font = Enum.Font.GothamSemibold
desc1.TextWrapped = true
desc1.TextXAlignment = Enum.TextXAlignment.Left
desc1.Parent = legal

local split1 = Instance.new("Frame")
split1.Name = "split"
split1.AnchorPoint = Vector2.new(0.5, 0.5)
split1.ZIndex = 2
split1.Size = UDim2.new(1, 0, 0, 2)
split1.Position = UDim2.new(0.5, 0, 0, 21)
split1.BorderSizePixel = 0
split1.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
split1.Parent = legal

local gui = Instance.new("Frame")
gui.Name = "gui"
gui.AnchorPoint = Vector2.new(0.5, 0.5)
gui.ZIndex = 2
gui.Size = UDim2.new(0, 482, 0, 292)
gui.Position = UDim2.new(0.8393939, 0, 0.4263393, 0)
gui.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
gui.Parent = screen

local padding2 = Instance.new("UIPadding")
padding2.Name = "padding"
padding2.PaddingTop = UDim.new(0, 6)
padding2.PaddingBottom = UDim.new(0, 6)
padding2.PaddingLeft = UDim.new(0, 6)
padding2.PaddingRight = UDim.new(0, 6)
padding2.Parent = gui

local corner3 = Instance.new("UICorner")
corner3.Name = "corner"
corner3.CornerRadius = UDim.new(0, 4)
corner3.Parent = gui

local dropShadow2 = Instance.new("Frame")
dropShadow2.Name = "dropShadow"
dropShadow2.AnchorPoint = Vector2.new(0.5, 0.5)
dropShadow2.Size = UDim2.new(1, 20, 1, 20)
dropShadow2.BackgroundTransparency = 1
dropShadow2.Position = UDim2.new(0.5, 0, 0.5, 0)
dropShadow2.Parent = gui

local aimbient2 = Instance.new("ImageLabel")
aimbient2.Name = "aimbient"
aimbient2.Size = UDim2.new(1, 0, 1, 0)
aimbient2.BackgroundTransparency = 1
aimbient2.ScaleType = Enum.ScaleType.Slice
aimbient2.ImageTransparency = 0.7
aimbient2.ImageColor3 = Color3.fromRGB(0, 0, 0)
aimbient2.Image = "rbxassetid://1316045217"
aimbient2.SliceCenter = Rect.new(10, 10, 118, 118)
aimbient2.Parent = dropShadow2

local penumbra2 = Instance.new("ImageLabel")
penumbra2.Name = "penumbra"
penumbra2.Size = UDim2.new(1, 0, 1, 0)
penumbra2.BackgroundTransparency = 1
penumbra2.ScaleType = Enum.ScaleType.Slice
penumbra2.ImageTransparency = 0.7
penumbra2.ImageColor3 = Color3.fromRGB(0, 0, 0)
penumbra2.Image = "rbxassetid://1316045217"
penumbra2.SliceCenter = Rect.new(10, 10, 118, 118)
penumbra2.Parent = dropShadow2

local pages = Instance.new("Frame")
pages.Name = "pages"
pages.AnchorPoint = Vector2.new(1, 1)
pages.ZIndex = 2
pages.Size = UDim2.new(0.686, 0, 1, 0)
pages.ClipsDescendants = true
pages.Position = UDim2.new(1, 0, 1, 0)
pages.BorderSizePixel = 0
pages.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
pages.Parent = gui

local corner4 = Instance.new("UICorner")
corner4.Name = "corner"
corner4.CornerRadius = UDim.new(0, 4)
corner4.Parent = pages

local function fixList(layout, frame)
	frame.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y)
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		frame.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y)
	end)
end

local function createPages(data)
	for index, name in pairs(data) do
		local lc = Instance.new("ScrollingFrame")
		lc.Name = name
		lc.AnchorPoint = Vector2.new(0.5, 0.5)
		lc.ZIndex = 2
		lc.Size = UDim2.new(1, 0, 1, 0)
		lc.BackgroundTransparency = 1
		lc.Position = UDim2.new(0.5, 0, 0.5, 0)
		lc.BorderSizePixel = 0
		lc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		lc.CanvasSize = UDim2.new(0, 0, 0, 400)
		lc.ScrollBarImageColor3 = Color3.fromRGB(189, 189, 189)
		lc.MidImage = "http://www.roblox.com/asset/?id=7101162141"
		lc.ScrollBarThickness = 4
		lc.TopImage = "http://www.roblox.com/asset/?id=7957105897"
		lc.BottomImage = "http://www.roblox.com/asset/?id=7957105101"
		lc.Parent = pages

		local container = Instance.new("Frame")
		container.Name = "container"
		container.ZIndex = 2
		container.Size = UDim2.new(1, -10, 1, 0)
		container.BackgroundTransparency = 1
		container.BorderSizePixel = 0
		container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		container.Parent = lc

		local list = Instance.new("UIListLayout")
		list.Name = "list"
		list.HorizontalAlignment = Enum.HorizontalAlignment.Center
		list.SortOrder = Enum.SortOrder.LayoutOrder
		list.Padding = UDim.new(0, 6)
		list.Parent = container

		fixList(list, lc)
		localPages[name] = lc
	end
end

local function addType(parent, name, titleName, index, default, func)
	if name == "checkbox" then
		local hovering = false
		local checkbox = Instance.new("Frame")
		checkbox.Name = "checkbox"
		checkbox.ZIndex = 2
		checkbox.Size = UDim2.new(1, 0, 0, 35)
		checkbox.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
		checkbox.Parent = parent

		local corner5 = Instance.new("UICorner")
		corner5.Name = "corner"
		corner5.CornerRadius = UDim.new(0, 4)
		corner5.Parent = checkbox

		local padding3 = Instance.new("UIPadding")
		padding3.Name = "padding"
		padding3.PaddingTop = UDim.new(0, 6)
		padding3.PaddingBottom = UDim.new(0, 6)
		padding3.PaddingLeft = UDim.new(0, 10)
		padding3.PaddingRight = UDim.new(0, 6)
		padding3.Parent = checkbox

		local title2 = Instance.new("TextLabel")
		title2.Name = "title"
		title2.ZIndex = 2
		title2.Size = UDim2.new(1, -50, 1, 0)
		title2.BackgroundTransparency = 1
		title2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		title2.FontSize = Enum.FontSize.Size18
		title2.TextSize = 15
		title2.TextColor3 = Color3.fromRGB(255, 255, 255)
		title2.Text = titleName
		title2.Font = Enum.Font.GothamSemibold
		title2.TextXAlignment = Enum.TextXAlignment.Left
		title2.Parent = checkbox

		local check = Instance.new("ImageButton")
		check.Name = "check"
		check.AnchorPoint = Vector2.new(1, 0)
		check.ZIndex = 2
		check.Size = UDim2.new(0, 23, 1, 0)
		check.Position = UDim2.new(1, 0, 0, 0)
		check.BackgroundColor3 = default and Color3.fromRGB(102, 168, 203) or Color3.fromRGB(55, 55, 55)
		check.AutoButtonColor = false
		check.Parent = checkbox

		local corner6 = Instance.new("UICorner")
		corner6.Name = "corner"
		corner6.CornerRadius = UDim.new(0, 4)
		corner6.Parent = check

		typeData[index] = default

		check.MouseEnter:Connect(function()
			hovering = true
			tween(check, infoPresets.DefaultFast, { BackgroundColor3 = typeData[index] == true and Color3.fromRGB(84, 140, 168) or Color3.fromRGB(59, 59, 59) })
		end)

		check.MouseLeave:Connect(function()
			hovering = false
			tween(check, infoPresets.DefaultFast, { BackgroundColor3 = typeData[index] == true and Color3.fromRGB(102, 168, 203) or Color3.fromRGB(55, 55, 55) })
		end)

		check.MouseButton1Click:Connect(function()
			typeData[index] = not typeData[index]

			if not hovering then
				tween(check, infoPresets.DefaultQuick, { BackgroundColor3 = typeData[index] == true and Color3.fromRGB(102, 168, 203) or Color3.fromRGB(59, 59, 59) })
			else
				tween(check, infoPresets.DefaultQuick, { BackgroundColor3 = typeData[index] == true and Color3.fromRGB(84, 140, 168) or Color3.fromRGB(55, 55, 55) })
			end
		end)

		if func then
			pcall(func, check)
		end
	elseif name == "input" then
		if func then
			pcall(func)
		end

		local input = Instance.new("Frame")
		input.Name = "input"
		input.ZIndex = 2
		input.Size = UDim2.new(1, 0, 0, 35)
		input.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
		input.Parent = parent

		local corner7 = Instance.new("UICorner")
		corner7.Name = "corner"
		corner7.CornerRadius = UDim.new(0, 4)
		corner7.Parent = input

		local padding4 = Instance.new("UIPadding")
		padding4.Name = "padding"
		padding4.PaddingTop = UDim.new(0, 6)
		padding4.PaddingBottom = UDim.new(0, 6)
		padding4.PaddingLeft = UDim.new(0, 10)
		padding4.PaddingRight = UDim.new(0, 6)
		padding4.Parent = input

		local title3 = Instance.new("TextLabel")
		title3.Name = "title"
		title3.ZIndex = 2
		title3.Size = UDim2.new(1, -50, 1, 0)
		title3.BackgroundTransparency = 1
		title3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		title3.FontSize = Enum.FontSize.Size18
		title3.TextSize = 15
		title3.TextColor3 = Color3.fromRGB(255, 255, 255)
		title3.Text = titleName
		title3.Font = Enum.Font.GothamSemibold
		title3.TextXAlignment = Enum.TextXAlignment.Left
		title3.Parent = input

		local change = Instance.new("TextButton")
		change.Name = "change"
		change.AnchorPoint = Vector2.new(1, 0)
		change.ZIndex = 2
		change.Size = UDim2.new(0, 100, 1, 0)
		change.Position = UDim2.new(1, 0, 0, 0)
		change.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
		change.AutoButtonColor = false
		change.FontSize = Enum.FontSize.Size12
		change.TextSize = 12
		change.TextColor3 = Color3.fromRGB(255, 255, 255)
		change.Text = default
		change.Font = Enum.Font.GothamSemibold
		change.Parent = input

		local corner8 = Instance.new("UICorner")
		corner8.Name = "corner"
		corner8.CornerRadius = UDim.new(0, 4)
		corner8.Parent = change

		typeData[index] = default
		reservedKeys[default] = index

		change.MouseEnter:Connect(function()
			tween(change, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(59, 59, 59) })
		end)

		change.MouseLeave:Connect(function()
			tween(change, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(55, 55, 55) })
		end)

		change.MouseButton1Click:Connect(function()
			if not changable then
				changable = true
				change.Text = "..."
				reservedKeys[typeData[index]] = nil

				local connection
				connection = UserInputService.InputBegan:Connect(function(input)
					if changable and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name ~= "Unknown" and not reservedKeys[input.KeyCode.Name] then
						connection:Disconnect()

						typeData[index] = input.KeyCode.Name
						reservedKeys[input.KeyCode.Name] = index
						change.Text = input.KeyCode.Name

						task.wait(0.5)
						changable = false
					end
				end)
			end
		end)
	elseif name == "slider" then
		if func then
			pcall(func)
		end

		local down = false
		local queued = false
		local amplitude = default.max - default.min

		local slider = Instance.new("Frame")
		slider.Name = "slider"
		slider.ZIndex = 2
		slider.Size = UDim2.new(1, 0, 0, 35)
		slider.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
		slider.Parent = parent

		local corner9 = Instance.new("UICorner")
		corner9.Name = "corner"
		corner9.CornerRadius = UDim.new(0, 4)
		corner9.Parent = slider

		local padding5 = Instance.new("UIPadding")
		padding5.Name = "padding"
		padding5.PaddingTop = UDim.new(0, 6)
		padding5.PaddingBottom = UDim.new(0, 6)
		padding5.PaddingLeft = UDim.new(0, 10)
		padding5.PaddingRight = UDim.new(0, 6)
		padding5.Parent = slider

		local title4 = Instance.new("TextLabel")
		title4.Name = "title"
		title4.ZIndex = 2
		title4.Size = UDim2.new(1, -150, 1, 0)
		title4.BackgroundTransparency = 1
		title4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		title4.FontSize = Enum.FontSize.Size18
		title4.TextSize = 15
		title4.TextColor3 = Color3.fromRGB(255, 255, 255)
		title4.Text = titleName
		title4.Font = Enum.Font.GothamSemibold
		title4.TextXAlignment = Enum.TextXAlignment.Left
		title4.Parent = slider

		local bar = Instance.new("ImageButton")
		bar.Name = "bar"
		bar.AnchorPoint = Vector2.new(1, 0)
		bar.ZIndex = 2
		bar.Size = UDim2.new(0, 130, 1, 0)
		bar.Position = UDim2.new(1, 0, 0, 0)
		bar.AutoButtonColor = false
		bar.Image = ""
		bar.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
		bar.Parent = slider

		local corner10 = Instance.new("UICorner")
		corner10.Name = "corner"
		corner10.CornerRadius = UDim.new(0, 4)
		corner10.Parent = bar

		local fill = Instance.new("Frame")
		fill.BorderSizePixel = 0
		fill.ZIndex = 2
		fill.Size = UDim2.new(default.start / amplitude, 0, 1, 0)
		fill.BackgroundColor3 = Color3.fromRGB(102, 168, 203)
		fill.Parent = bar

		local corner11 = Instance.new("UICorner")
		corner11.Name = "corner"
		corner11.CornerRadius = UDim.new(0, 4)
		corner11.Parent = fill

		local value = Instance.new("TextLabel")
		value.Name = "value"
		value.ZIndex = 2
		value.Size = UDim2.new(1, 0, 1, 0)
		value.BackgroundTransparency = 1
		value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		value.FontSize = Enum.FontSize.Size18
		value.TextSize = 15
		value.TextColor3 = Color3.fromRGB(255, 255, 255)
		value.Text = default.start
		value.Font = Enum.Font.GothamSemibold
		value.Parent = bar

		typeData[index] = default.start

		RunService.RenderStepped:Connect(function()
			if down then
				local mousePosition = UserInputService:GetMouseLocation()
				local min = bar.AbsolutePosition.X
				local max = bar.AbsolutePosition.X + bar.AbsoluteSize.X

				if mousePosition.X < min then
					fill.Size = UDim2.fromScale(0, 1)
					typeData[index] = 0
				elseif mousePosition.X > max then
					fill.Size = UDim2.fromScale(1, 1)
					typeData[index] = 1 * amplitude
				else
					local size = (mousePosition.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X

					typeData[index] = size * amplitude
					fill.Size = UDim2.fromScale(size, 1)
				end

				value.Text = math.floor(typeData[index])
			end
		end)

		bar.MouseButton1Down:Connect(function()
			down = true
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				down = false
			end
		end)
	elseif name == "dropdown" then
		if func then
			pcall(func)
		end

		local opened = false
		local selected = nil

		local dropdown = Instance.new("Frame")
		dropdown.Name = "dropdown"
		dropdown.ZIndex = 2
		dropdown.Size = UDim2.new(1, 0, 0, 35)
		dropdown.ClipsDescendants = true
		dropdown.Position = UDim2.new(0, 0, 0.3075, 0)
		dropdown.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
		dropdown.Parent = parent

		local corner12 = Instance.new("UICorner")
		corner12.Name = "corner"
		corner12.CornerRadius = UDim.new(0, 4)
		corner12.Parent = dropdown

		local padding6 = Instance.new("UIPadding")
		padding6.Name = "padding"
		padding6.PaddingTop = UDim.new(0, 6)
		padding6.PaddingBottom = UDim.new(0, 6)
		padding6.PaddingLeft = UDim.new(0, 10)
		padding6.PaddingRight = UDim.new(0, 6)
		padding6.Parent = dropdown

		local title5 = Instance.new("TextLabel")
		title5.Name = "title"
		title5.ZIndex = 2
		title5.Size = UDim2.new(0, 134, 0, 23)
		title5.BackgroundTransparency = 1
		title5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		title5.FontSize = Enum.FontSize.Size18
		title5.TextSize = 15
		title5.TextColor3 = Color3.fromRGB(255, 255, 255)
		title5.Text = titleName
		title5.Font = Enum.Font.GothamSemibold
		title5.TextXAlignment = Enum.TextXAlignment.Left
		title5.Parent = dropdown

		local open = Instance.new("TextButton")
		open.Name = "open"
		open.Selectable = false
		open.AnchorPoint = Vector2.new(1, 0)
		open.ZIndex = 2
		open.Size = UDim2.new(0, 23, 0, 23)
		open.Position = UDim2.new(1, 0, 0, 0)
		open.BorderSizePixel = 0
		open.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
		open.AutoButtonColor = false
		open.FontSize = Enum.FontSize.Size18
		open.TextSize = 16
		open.TextColor3 = Color3.fromRGB(255, 255, 255)
		open.Text = "+"
		open.Font = Enum.Font.GothamBold
		open.Parent = dropdown

		local corner = Instance.new("UICorner")
		corner.Name = "corner"
		corner.CornerRadius = UDim.new(0, 4)
		corner.Parent = open

		local options = Instance.new("Frame")
		options.Name = "options"
		options.ZIndex = 2
		options.Size = UDim2.new(1, 0, 0, 50)
		options.BackgroundTransparency = 1
		options.Position = UDim2.new(0, 0, 0, 30)
		options.BorderSizePixel = 0
		options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		options.Parent = dropdown

		typeData[index] = default.starting

		for _, optionName in pairs(default.options) do
			local option = Instance.new("TextButton")
			option.Name = "option"
			option.ZIndex = 2
			option.Size = UDim2.new(1, 0, 0, 25)
			option.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
			option.BorderSizePixel = 0
			option.AutoButtonColor = false
			option.FontSize = Enum.FontSize.Size14
			option.TextSize = 14
			option.TextColor3 = Color3.fromRGB(255, 255, 255)
			option.Text = optionName
			option.Font = Enum.Font.GothamSemibold
			option.Parent = options

			local corner1 = Instance.new("UICorner")
			corner1.Name = "corner"
			corner1.CornerRadius = UDim.new(0, 4)
			corner1.Parent = option

			if optionName == default.starting then
				selected = option
				tween(option, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(80, 80, 80) })
			end

			option.MouseEnter:Connect(function()
				if typeData[index] ~= optionName then
					tween(option, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(70, 70, 70) })
				end
			end)

			option.MouseLeave:Connect(function()
				tween(option, infoPresets.DefaultFast, { BackgroundColor3 = selected ~= option and Color3.fromRGB(63, 63, 63) or Color3.fromRGB(80, 80, 80) })
			end)

			option.MouseButton1Click:Connect(function()
				if selected then
					tween(selected, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(63, 63, 63)})
				end

				selected = option
				typeData[index] = optionName

				tween(option, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(80, 80, 80) })
			end)
		end

		local list1 = Instance.new("UIListLayout")
		list1.Name = "list"
		list1.Padding = UDim.new(0, 6)
		list1.HorizontalAlignment = Enum.HorizontalAlignment.Center
		list1.SortOrder = Enum.SortOrder.LayoutOrder
		list1.Parent = options

		open.MouseEnter:Connect(function()
			tween(open, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(70, 70, 70) })
		end)

		open.MouseLeave:Connect(function()
			tween(open, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(63, 63, 63) })
		end)

		open.MouseButton1Click:Connect(function()
			if opened then
				opened = false
				open.Text = "+"
				tween(dropdown, infoPresets.Quint, { Size = UDim2.new(1, 0, 0, 35) })
			else
				opened = true
				open.Text = "-"
				tween(dropdown, infoPresets.Quint, { Size = UDim2.new(1, 0, 0, 57 + (25 * #default.options)) })
			end
		end)
	end
end

local padding7 = Instance.new("UIPadding")
padding7.Name = "padding"
padding7.PaddingTop = UDim.new(0, 8)
padding7.PaddingBottom = UDim.new(0, 6)
padding7.PaddingLeft = UDim.new(0, 6)
padding7.PaddingRight = UDim.new(0, 6)
padding7.Parent = pages

local pageLayout = Instance.new("UIPageLayout")
pageLayout.Name = "pageLayout"
pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
pageLayout.TouchInputEnabled = false
pageLayout.GamepadInputEnabled = false
pageLayout.ScrollWheelInputEnabled = false
pageLayout.TweenTime = 0.6
pageLayout.Padding = UDim.new(0, 10)
pageLayout.EasingStyle = Enum.EasingStyle.Cubic
pageLayout.Parent = pages

local sidebar = Instance.new("Frame")
sidebar.Name = "sidebar"
sidebar.Selectable = true
sidebar.ZIndex = 2
sidebar.Size = UDim2.new(0.3, 0, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
sidebar.Parent = gui

local corner13 = Instance.new("UICorner")
corner13.Name = "corner"
corner13.CornerRadius = UDim.new(0, 4)
corner13.Parent = sidebar

local padding8 = Instance.new("UIPadding")
padding8.Name = "padding"
padding8.PaddingTop = UDim.new(0, 6)
padding8.PaddingBottom = UDim.new(0, 6)
padding8.PaddingLeft = UDim.new(0, 6)
padding8.PaddingRight = UDim.new(0, 6)
padding8.Parent = sidebar

local navbar = Instance.new("ScrollingFrame")
navbar.Name = "navbar"
navbar.Selectable = false
navbar.AnchorPoint = Vector2.new(0, 1)
navbar.ZIndex = 2
navbar.Size = UDim2.new(1, 0, 0, 200)
navbar.BackgroundTransparency = 1
navbar.Position = UDim2.new(0, 0, 1, 0)
navbar.BorderSizePixel = 0
navbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
navbar.ScrollingDirection = Enum.ScrollingDirection.Y
navbar.CanvasSize = UDim2.new(0, 0, 0, 138)
navbar.ScrollBarImageColor3 = Color3.fromRGB(189, 189, 189)
navbar.MidImage = "http://www.roblox.com/asset/?id=7101162141"
navbar.ScrollBarThickness = 4
navbar.TopImage = "http://www.roblox.com/asset/?id=7957105897"
navbar.BottomImage = "http://www.roblox.com/asset/?id=7957105101"
navbar.Parent = sidebar

local container1 = Instance.new("Frame")
container1.Name = "container"
container1.ZIndex = 2
container1.Size = UDim2.new(1, 0, 1, 0)
container1.BackgroundTransparency = 1
container1.BorderSizePixel = 0
container1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
container1.Parent = navbar

local list2 = Instance.new("UIListLayout")
list2.Name = "list"
list2.HorizontalAlignment = Enum.HorizontalAlignment.Center
list2.SortOrder = Enum.SortOrder.LayoutOrder
list2.Padding = UDim.new(0, 6)
list2.Parent = container1

local currentButton = nil

local function addNavbarButtons(data)
	for index, pageData in pairs(data) do
		local button = Instance.new("TextButton")
		button.Name = "button"
		button.LayoutOrder = 3
		button.ZIndex = 2
		button.Size = UDim2.new(1, 0, 0, 30)
		button.BackgroundColor3 = index == 1 and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(63, 63, 63)
		button.AutoButtonColor = false
		button.FontSize = Enum.FontSize.Size14
		button.TextSize = 13
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.Text = pageData.name
		button.Font = Enum.Font.GothamSemibold
		button.Parent = container1

		if index == 1 then
			currentButton = button
		end

		local corner14 = Instance.new("UICorner")
		corner14.Name = "corner"
		corner14.CornerRadius = UDim.new(0, 4)
		corner14.Parent = button

		button.MouseEnter:Connect(function()
			tween(button, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(70, 70, 70) })
		end)

		button.MouseLeave:Connect(function()
			tween(button, infoPresets.DefaultFast, { BackgroundColor3 = currentButton ~= button and Color3.fromRGB(63, 63, 63) or Color3.fromRGB(80, 80, 80) })
		end)

		button.MouseButton1Click:Connect(function()
			if currentButton then
				tween(currentButton, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(63, 63, 63) })
			end

			currentButton = button
			pageLayout:JumpTo(pageData.page)

			tween(button, infoPresets.DefaultFast, { BackgroundColor3 = Color3.fromRGB(80, 80, 80) })
		end)
	end
end

local title6 = Instance.new("TextLabel")
title6.Name = "title"
title6.AnchorPoint = Vector2.new(0.5, 0)
title6.ZIndex = 2
title6.Size = UDim2.new(1, 0, 0, 25)
title6.BackgroundTransparency = 1
title6.Position = UDim2.new(0.5, 0, 0, 8)
title6.BorderSizePixel = 0
title6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title6.FontSize = Enum.FontSize.Size28
title6.TextSize = 25
title6.TextColor3 = Color3.fromRGB(255, 255, 255)
title6.Text = "zHub"
title6.Font = Enum.Font.GothamSemibold
title6.Parent = sidebar

local vr = Instance.new("TextLabel")
vr.Name = "version"
vr.AnchorPoint = Vector2.new(0.5, 0)
vr.ZIndex = 2
vr.Size = UDim2.new(1, 0, 0, 20)
vr.BackgroundTransparency = 1
vr.Position = UDim2.new(0.5, 0, 0, 32)
vr.BorderSizePixel = 0
vr.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
vr.FontSize = Enum.FontSize.Size24
vr.TextSize = 20
vr.TextColor3 = Color3.fromRGB(106, 106, 106)
vr.Text = "v. 1.0"
vr.Font = Enum.Font.GothamSemibold
vr.Parent = sidebar

screen.Parent = game:GetService("CoreGui")

createPages({
	"character",
	"visual",
	"trolling",
	"settings",
	"license"
})

addNavbarButtons({
	{ name = "Character", page = localPages.character },
	{ name = "Visual", page = localPages.visual },
	{ name = "Trolling", page = localPages.trolling },
	{ name = "Settings", page = localPages.settings },
	{ name = "License", page = localPages.license }
})

legal.Parent = localPages.license.container

----------------------------------------

local function lerp(a, b, t)
	return a + (b - a) * t
end

local dragging
local dragInput
local dragStart
local startPos

local lastMousePos
local lastGoalPos
local speed = 8

RunService.RenderStepped:Connect(function(dt)
	dt *= 3

	if not startPos then return end
	if not dragging and lastGoalPos then
		gui.Position = UDim2.new(startPos.X.Scale, lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * speed), startPos.Y.Scale, lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * speed))
		return
	end

	local delta = lastMousePos - UserInputService:GetMouseLocation()
	local xGoal = startPos.X.Offset - delta.X
	local yGoal = startPos.Y.Offset - delta.Y

	lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
	gui.Position = UDim2.new(startPos.X.Scale, lerp(gui.Position.X.Offset, xGoal, dt * speed), startPos.Y.Scale, lerp(gui.Position.Y.Offset, yGoal, dt * speed))
end)

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		lastMousePos = UserInputService:GetMouseLocation()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

--//--//--//--//--//--//--//--//--//--//--//--//--//--//--//--// Commands | Character

local cc = localPages.character.container
local vc = localPages.visual.container
local tc = localPages.trolling.container
local sc = localPages.settings.container

addType(cc, "checkbox", "Fly", "flying", false, function()
	local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
	local queue = false
	local vl = {}

	local function fly(character)
		if queue then return end

		queue = true
		repeat task.wait() until typeData.flying
		queue = false

		task.wait(1)

		local root = character:FindFirstChild("HumanoidRootPart")
		local humanoid = character:FindFirstChild("Humanoid")

		if #vl > 0 then
			for index, bm in ipairs(vl) do
				bm:Destroy()
			end

			table.clear(vl)
		end

		local bp = Instance.new("BodyVelocity", root)
		bp.Velocity = Vector3.new()
		bp.P = 2e4

		local bg = Instance.new("BodyGyro", root)
		bg.D = 2e5
		bg.MaxTorque = Vector3.new()

		table.insert(vl, bp)
		table.insert(vl, bg)

		while character:IsDescendantOf(workspace) do
			RunService.RenderStepped:Wait()
			local flying = typeData.flying

			if flying and root and bp and bg and humanoid then
				local look = (camera.Focus.Position - camera.CFrame.Position).Unit
				local pos = Vector3.new()

				local directions = {
					[typeData.forward] = camera.CFrame.LookVector * typeData.flySpeed,
					[typeData.left] = camera.CFrame.RightVector * (-typeData.flySpeed),
					[typeData.backward] = camera.CFrame.LookVector * (-typeData.flySpeed),
					[typeData.right] = camera.CFrame.RightVector * typeData.flySpeed,
					[typeData.up] = Vector3.new(0, typeData.flySpeed, 0),
					[typeData.down] = Vector3.new(0, -typeData.flySpeed, 0),
				}

				for key, dir in pairs(directions) do
					if UserInputService:IsKeyDown(key) then
						pos += dir
					end
				end

				root.CFrame = root.CFrame:Lerp(CFrame.new(root.Position, root.Position + look), 0.1)

				bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				bp.Velocity = pos

				humanoid.PlatformStand = true
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			elseif not flying and bp and bg and humanoid then
				bp.MaxForce = Vector3.new()
				bg.MaxTorque = Vector3.new()

				humanoid.PlatformStand = false
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
			end
		end
	end

	task.spawn(fly, char)

	Players.LocalPlayer.CharacterAdded:Connect(function(char1)
		task.spawn(fly, char1)
	end)
end)

addType(cc, "checkbox", "CFrame Fly", "cframeFly", false, function()
	RunService:BindToRenderStep("CFrameFly", Enum.RenderPriority.First.Value, function()
		local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()

		if typeData.cframeFly and not typeData.flying then
			local pos = Vector3.new()

			local directions = {
				[typeData.forward] = Vector3.new(0, 0, -1) * typeData.flySpeed,
				[typeData.left] = Vector3.new(-1, 0, 0) * typeData.flySpeed,
				[typeData.backward] = Vector3.new(0, 0, 1) * typeData.flySpeed,
				[typeData.right] = Vector3.new(1, 0, 0) * typeData.flySpeed,
				[typeData.up] = Vector3.new(0, typeData.flySpeed, 0),
				[typeData.down] = Vector3.new(0, -typeData.flySpeed, 0),
			}

			for key, dir in pairs(directions) do
				if UserInputService:IsKeyDown(key) then
					pos += dir
				end
			end

			local root = char:FindFirstChild("HumanoidRootPart")
			local humanoid = char:FindFirstChild("Humanoid")

			if root and humanoid then
				local look = (camera.Focus.Position - camera.CFrame.Position).Unit

				root.Anchored = true
				root.CFrame = root.CFrame:Lerp(CFrame.new(root.Position, root.Position + look) * CFrame.new(pos * 0.5), 0.1)
			end
		else
			local root = char:FindFirstChild("HumanoidRootPart")
			local humanoid = char:FindFirstChild("Humanoid")

			if root and humanoid then
				root.Anchored = false
			end
		end
	end)
end)

addType(cc, "checkbox", "Noclip", "noclip", false, function()
	RunService.Stepped:Connect(function()
		if typeData.noclip then
			local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()

			for index, part in ipairs(char:GetChildren()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end)
end)

addType(cc, "checkbox", "Invisible", "invisible", false, function(check)
	local touched = false
	local invisible = false
	local loc

	local part = Instance.new("Part")
	part.Anchored = true
	part.Transparency = 1
	part.Size = Vector3.new(10, 1, 10)
	part.Position = Vector3.new(0, 100000, 0)
	part.Parent = workspace

	part.Touched:Connect(function(hit)
		if hit and invisible then
			if hit.Parent.Name == Players.LocalPlayer.Name then
				if not touched then
					touched = true

					if Players.LocalPlayer.Character then
						if Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
							local root = Players.LocalPlayer.Character.HumanoidRootPart:Clone()
							task.wait(0.25)

							Players.LocalPlayer.Character.HumanoidRootPart:Destroy()
							root.Parent = Players.LocalPlayer.Character
							Players.LocalPlayer.Character:MoveTo(loc + Vector3.new(0, 5, 0))

							touched = false
						else
							local root = Players.LocalPlayer.Character.LowerTorso.Root:Clone()
							task.wait(0.25)

							Players.LocalPlayer.Character.LowerTorso.Root:Destroy()
							root.Parent = Players.LocalPlayer.Character
							Players.LocalPlayer.Character:MoveTo(loc + Vector3.new(0, 5, 0))

							touched = false
						end
					end
				end
			end
		end
	end)

	check.MouseButton1Click:Connect(function()
		repeat task.wait() until Players.LocalPlayer.Character
		repeat task.wait() until Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

		local root = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

		if not invisible then
			invisible = true
			loc = Players.LocalPlayer.Character.HumanoidRootPart.Position
			Players.LocalPlayer.Character:MoveTo(part.Position + Vector3.new(0, 5, 0))
		else
			invisible = false
			Players.LocalPlayer.Character:BreakJoints()
		end

		Players.LocalPlayer.CharacterAdded:Connect(function(character)
			repeat task.wait() until character:FindFirstChild("HumanoidRootPart")

			if invisible then
				invisible = true
				loc = Players.LocalPlayer.Character.HumanoidRootPart.Position
				Players.LocalPlayer.Character:MoveTo(part.Position + Vector3.new(0, 5, 0))
			end
		end)
	end)
end)

addType(cc, "checkbox", "CFrame Walk", "cfWalk", false)

addType(cc, "slider", "Fly Speed", "flySpeed", { start = 50, min = 0, max = 150 })

addType(cc, "slider", "CFWalk Speed", "cfWalkSpeed", { start = 16, min = 0, max = 200 }, function()
	RunService:BindToRenderStep("CFWalkSpeed", Enum.RenderPriority.First.Value, function()
		if typeData.cfWalk then
			local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()

			if character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") then
				local position = character.HumanoidRootPart.Position + (character.Humanoid.MoveDirection * (typeData.cfWalkSpeed * 0.01))
				character.HumanoidRootPart.CFrame = CFrame.new(position) * character.HumanoidRootPart.CFrame.Rotation
			end
		end
	end)
end)

addType(cc, "checkbox", "Inf Jump", "infJump", false)

addType(cc, "slider", "Jump Power", "jumpPower", { start = math.floor(workspace.Gravity / 4), min = 0, max = 350 }, function()
	local lastJump = 0

	UserInputService.JumpRequest:Connect(function()
		local ct = tick()
		local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()

		if character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and ct - lastJump >= (typeData.jumpCooldown / 10) then
			lastJump = ct

			if character.Humanoid.FloorMaterial == Enum.Material.Air and not typeData.infJump then return end

			character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
			character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, typeData.jumpPower, 0)
		end
	end)
end)

addType(cc, "slider", "Jump Cooldown", "jumpCooldown", { start = 0, min = 0, max = 20 })

--//--//--//--//--//--//--//--//--//--//--//--//--//--//--//--// Commands | Visual

addType(vc, "checkbox", "AimLock", "lock", false, function()
	local randomData = {}
	local enabled = false
	local diedConnection

	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType.Name == "MouseButton1" and typeData.toggleAimlock == "LeftMouseButton" then
			enabled = true
		elseif input.UserInputType.Name == "MouseButton2" and typeData.toggleAimlock == "RightMouseButton" then
			enabled = true
		elseif input.UserInputType.Name == typeData.toggleAimlock then
			enabled = true
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType.Name == "MouseButton1" and typeData.toggleAimlock == "LeftMouseButton" then
			enabled = false
		elseif input.UserInputType.Name == "MouseButton2" and typeData.toggleAimlock == "RightMouseButton" then
			enabled = false
		elseif input.UserInputType.Name == typeData.toggleAimlock then
			enabled = false
		end
	end)

	RunService:BindToRenderStep("AimLock", Enum.RenderPriority.First.Value, function()
		local s, e = pcall(function()
			if enabled and typeData.lock then
				local target
				local bp
				local magnitude = math.huge

				if diedConnection then
					diedConnection:Disconnect()
					diedConnection = nil
				end

				for index, player in pairs(Players:GetChildren()) do
					local team = Players.LocalPlayer.Team or "team"
					local team2 = player.Team or "team1"

					if player ~= Players.LocalPlayer and team ~= team2 then
						if player.Character and Players.LocalPlayer.Character then
							local mousePos = UserInputService:GetMouseLocation()
							local point = camera:WorldToViewportPoint(player.Character.Head.Position)
							local charPos = Vector2.new(point.X, point.Y)

							if (charPos - mousePos).Magnitude < magnitude and player.Character.Humanoid.Health > 0 then
								magnitude = (charPos - mousePos).Magnitude
								target = player

								diedConnection = player.Character.Humanoid.Died:Connect(function()
									if diedConnection then
										diedConnection:Disconnect()
										diedConnection = nil
									end

									randomData[target] = nil
								end)
							end
						end
					end
				end

				if typeData.aimPart == "Random" then
					if randomData[target] then
						bp = randomData[target]
					else
						bp = math.random(1, 2) == 1 and "Head" or "HumanoidRootPart"
						randomData[target] = bp
					end
				else
					bp = typeData.aimPart
				end

				if magnitude <= typeData.magnitude then
					if target then
						if target.Character then
							if target.Character:FindFirstChild(bp) then
								local charPos = target.Character[bp].CFrame.Position
								local pos = camera.CFrame.Position

								camera.CFrame = camera.CFrame:Lerp(CFrame.new(pos, charPos), math.abs(typeData.smoothness - 9) / 10)			
							end
						end
					end
				end
			end
		end)

		if e then
			warn("[zHub]: AimLock function threw an unexpected error. Details:\n" .. e)
		end
	end)
end)

addType(vc, "dropdown", "Toggle", "toggleAimlock", { starting = "RightMouseButton", options = { "RightMouseButton", "LeftMouseButton", "MouseMovement" } })

addType(vc, "slider", "Smoothness", "smoothness", { start = 4, min = 1, max = 10 })
addType(vc, "slider", "Magnitude", "magnitude", { start = 80, min = 40, max = 200 })

addType(vc, "dropdown", "Aim Part", "aimPart", { starting = "Head", options = { "Head", "HumanoidRootPart", "Random" } })

addType(vc, "checkbox", "ESP", "esp", false, function(check)
	local enabled = false
	local trash = {}

	check.MouseButton1Click:Connect(function()
		if enabled then
			enabled = false

			for index, gui in pairs(trash) do
				if gui:IsDescendantOf(workspace) then
					gui:Destroy()
				else
					trash[index] = nil
				end
			end
		else
			enabled = true

			for index, player in ipairs(Players:GetChildren()) do
				if trash[player] then trash[player] = nil end

				if player.Character and player ~= Players.LocalPlayer then
					local character = player.Character

					if character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") then
						local connection
						local teamCon

						local function respawn(char)
							if teamCon then
								teamCon:Disconnect()
							end

							if connection and not enabled then
								connection:Disconnect()
								connection = nil

								return
							end

							local team = player.Team
							local lTeam = Players.LocalPlayer.Team

							local color = BrickColor.new("White")

							if team then
								color = team.TeamColor
							end

							local gui = Instance.new("BillboardGui")
							local name = Instance.new("TextLabel")
							local size = Instance.new("UISizeConstraint")

							gui.Name = "nametag"
							gui.Size = UDim2.fromScale(1, 1)
							gui.AlwaysOnTop = true
							gui.ResetOnSpawn = false
							gui.ExtentsOffsetWorldSpace = Vector3.new(0, 2, 0)
							gui.Parent = char:WaitForChild("Head")

							name.BackgroundTransparency = 1
							name.TextWrapped = true
							name.TextScaled = true
							name.AnchorPoint = Vector2.new(0.5, 0.5)
							name.Position = UDim2.fromScale(0.5, 0.5)
							name.Size = UDim2.fromScale(10, 1)
							name.Font = Enum.Font.GothamSemibold
							name.TextStrokeTransparency = 0
							name.TextColor = color
							name.Text = player.Name
							name.Parent = gui

							size.MinSize = Vector2.new(1000, 10)
							size.MaxSize = Vector2.new(1000, 20)
							size.Parent = name

							table.insert(trash, gui)

							teamCon = player:GetPropertyChangedSignal("Team"):Connect(function()
								local newTeam = player.Team
								local newLTeam = Players.LocalPlayer.Team
								local newColor = BrickColor.new("White")

								if newTeam then
									newColor = newTeam.TeamColor
								end

								name.TextColor = newColor
							end)
						end

						respawn(character)
						connection = player.CharacterAdded:Connect(respawn)
					end
				end
			end
		end
	end)

	Players.PlayerAdded:Connect(function(player)
		local teamCon

		player.CharacterAdded:Connect(function(char)
			if enabled then
				if teamCon then
					teamCon:Disconnect()
				end

				local team = player.Team
				local lTeam = Players.LocalPlayer.Team

				local color = BrickColor.new("White")

				if team then
					color = team.TeamColor
				end

				local gui = Instance.new("BillboardGui")
				local name = Instance.new("TextLabel")
				local size = Instance.new("UISizeConstraint")

				gui.Name = "nametag"
				gui.Size = UDim2.fromScale(1, 1)
				gui.AlwaysOnTop = true
				gui.ResetOnSpawn = false
				gui.ExtentsOffsetWorldSpace = Vector3.new(0, 2, 0)
				gui.Parent = char:WaitForChild("Head")

				name.BackgroundTransparency = 1
				name.TextWrapped = true
				name.TextScaled = true
				name.AnchorPoint = Vector2.new(0.5, 0.5)
				name.Position = UDim2.fromScale(0.5, 0.5)
				name.Size = UDim2.fromScale(10, 1)
				name.Font = Enum.Font.GothamSemibold
				name.TextStrokeTransparency = 0
				name.TextColor = color
				name.Text = player.Name
				name.Parent = gui

				size.MinSize = Vector2.new(1000, 10)
				size.MaxSize = Vector2.new(1000, 20)
				size.Parent = name

				table.insert(trash, gui)

				teamCon = player:GetPropertyChangedSignal("Team"):Connect(function()
					local newTeam = player.Team
					local newLTeam = Players.LocalPlayer.Team
					local newColor = BrickColor.new("White")

					if newTeam then
						newColor = newTeam.TeamColor
					end

					name.TextColor = newColor
				end)
			end
		end)
	end)
end)

--//--//--//--//--//--//--//--//--//--//--//--//--//--//--//--// Commands | Trolling

addType(tc, "checkbox", "Fling", "fling", false, function(check)
	local oldBv = nil
	local queue = false
	local enabled = false

	local function create(character)
		if queue then return end

		queue = true
		repeat task.wait() until character:FindFirstChild("HumanoidRootPart")
		task.wait(1)
		queue = false

		if not typeData.fling then return end			

		local hrp = character:FindFirstChild("HumanoidRootPart")

		if hrp then
			if oldBv then
				oldBv:Destroy()
			end

			typeData.noclip = true

			local bv = Instance.new("BodyAngularVelocity")
			bv.MaxTorque = Vector3.new(1, 1, 1) * math.huge
			bv.P = math.huge
			bv.AngularVelocity = Vector3.new(0, 9e5, 0)
			bv.Parent = hrp

			oldBv = bv

			for index, part in ipairs(character:GetChildren()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
					part.Massless = true
					part.Velocity = Vector3.new(0, 0, 0)
				end
			end
		end
	end

	Players.LocalPlayer.CharacterAdded:Connect(function(character)
		if typeData.fling then
			create(character)
		end
	end)

	check.MouseButton1Click:Connect(function()
		local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()

		if character:FindFirstChild("Humanoid") then
			if enabled then
				if oldBv then
					oldBv:Destroy()
					enabled = false
					oldBv = nil
				end

				typeData.noclip = false
			else
				enabled = true
				character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
				character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
				create(character)
			end
		end
	end)
end)

--//--//--//--//--//--//--//--//--//--//--//--//--//--//--//--// Commands | Settings

addType(sc, "input", "Fly Forward", "forward", "W")
addType(sc, "input", "Fly Left", "left", "A")
addType(sc, "input", "Fly Backward", "backward", "S")
addType(sc, "input", "Fly Right", "right", "D")
addType(sc, "input", "Fly Down", "down", "Q")
addType(sc, "input", "Fly Up", "up", "Space")
