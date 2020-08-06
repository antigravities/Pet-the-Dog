Mannequin:Import("Event")
Mannequin:Import("UIRoot")
Mannequin:Import("UIButton")
Mannequin:Import("EUIAnchor")
Mannequin:Import("Vector")
Mannequin:Import("UIOverlay")
Mannequin:Import("Emote")

print("Get ready to pet the dog!")

local btn

function pet()
    UIOverlay.SelectedAgent.Body.ShowEmote(Emote("emotes/happy"), 5000)
end

Event.Once("Game", function()
    btn = UIButton("Pet the Dog", pet, EUIAnchor.BottomRight)
    btn.Size = Vector(200, 140)
    UIRoot.AddComponent(btn)
    btn.Visible = false
end)

Event.On("Tick", function(ticks)
   if ticks%10 == 0 and not (btn == nil) then
        local sel = UIOverlay.SelectedAgent
        btn.Visible = not (sel == nil) and sel.IsLiving and sel.Data.ID == "dom_dog"
   end
end)
