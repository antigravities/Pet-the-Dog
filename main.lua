Mannequin:Import("Event")
Mannequin:Import("UIRoot")
Mannequin:Import("UIButton")
Mannequin:Import("EUIAnchor")
Mannequin:Import("Vector")
Mannequin:Import("UIOverlay")
Mannequin:Import("Emote")
Mannequin:Import("Job")
Mannequin:Import("EJobResult")

print("Get ready to pet the dog!")

local btn

function pet()
    local sel = UIOverlay.SelectedAgent

    local job = Job("PathToAgent", sel.Scene, sel)
    job:Dispatch(sel.Scene, function(status)
        if status == EJobResult.Success then sel.Body.ShowEmote(Emote("emotes/happy"), 5000)
        else print("path job failed " .. status)
        end
    end)
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
        if not (sel == nil) then print(sel.Data.ID) end
        btn.Visible = not (sel == nil) and sel.IsLiving and sel.Data.ID == "dom_dog"
   end
end)
