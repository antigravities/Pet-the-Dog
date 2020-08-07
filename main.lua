Mannequin:Import("Event")
Mannequin:Import("UIRoot")
Mannequin:Import("UIButton")
Mannequin:Import("EUIAnchor")
Mannequin:Import("Vector")
Mannequin:Import("UIOverlay")
Mannequin:Import("Emote")
Mannequin:Import("Job")
Mannequin:Import("EJobResult")

local btn

function p(str)
    print("[Pet the Dog] " .. str)
end

p("Get ready to pet the dog!")

function pet()
    local sel = UIOverlay.SelectedAgent

    p("Petting " .. sel.Name)

    local job = Job("PathToAgent", sel.Scene, sel)
    job:Dispatch(sel.Scene, function(status)
        if status == EJobResult.Success then sel.Body.ShowEmote(Emote("emotes/happy"), 5000)
        else p("path job failed " .. status)
        end
        btn.Enabled = true
    end)

    btn.Enabled = false
end

Event.Once("Game", function()
    btn = UIButton("Pet the Dog", pet, EUIAnchor.BottomRight)
    btn.Size = Vector(200, 50)
    UIRoot.AddComponent(btn)
    btn.Visible = false
end)

Event.On("Overlay_SelectedAgent", function(new)
    if btn == nil then return end
	btn.Visible = not (new == nil) and new.IsLiving and new.Data.ID == "dom_dog"
    return true
end)

Event.On("Unload", function()
    if not (btn == nil) then
        p("Removing button (unloading)")
        UIRoot.RemoveComponent(btn)
    end

    btn = null
    p("Unloaded")
end)
