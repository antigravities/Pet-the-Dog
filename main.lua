Mannequin:Import("Event")
Mannequin:Import("Game")
Mannequin:Import("EGameStatus")
Mannequin:Import("UIRoot")
Mannequin:Import("UIButton")
Mannequin:Import("EUIAnchor")
Mannequin:Import("UIPanel")
Mannequin:Import("Vector")
Mannequin:Import("UIOverlay")
Mannequin:Import("Emote")

local btn

print("inject...")

function pet()
    UIOverlay.SelectedAgent.Body.ShowEmote(Emote("emotes/happy"), 5000)
end

Event.On("Game", function()
    mon = status == EGameStatus.Game

    if btn == nil then
        print("creating button")
        btn = UIButton("Pet the Dog", pet, EUIAnchor.BottomRight)
        btn.Size = Vector(200, 140)
        UIRoot.AddComponent(btn)
        btn.Visible = false
    end

    if mon then
        UIRoot.AddComponent(btn)
    end
end)

Event.On("Tick", function(ticks)
   if ticks%10 == 0 and not (btn == nil) then
        print("tick")
        local sel = UIOverlay.SelectedAgent

        if not (sel == nil) and sel.IsLiving and sel.Data.ID == "dom_dog" then
            print("pupperoni")
            print(btn)
            btn.Visible = true
        else btn.Visible = false
        end
   end
end)