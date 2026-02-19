---@class StarlightColoredObject: StarlightBaseObject
Starlight.Class.ColoredObject = Starlight.Class.BaseObject:Copy()

---@type "primary"|"secondary"|"error"|"warning"|"info"|"success"
Starlight.Class.ColoredObject.color = "primary"

---@type ("primary"|"secondary"|"error"|"warning"|"info"|"success")[]
Starlight.Class.ColoredObject._colors = { "primary", "secondary", "error", "warning", "info", "success" }

---Starlight 색상 설정
---@param color "primary"|"secondary"|"error"|"warning"|"info"|"success" 색상
function Starlight.Class.ColoredObject:SetColor(color)
    if not table.HasValue(self._colors, color) then
        error("Invalid color: " .. color)
        return
    end

    self.color = color
end
