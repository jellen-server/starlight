---@class Starlight_Button : StarlightColoredObject, DButton
Starlight.Button = Starlight.Class.ColoredObject:Copy()

---Starlight Button 객체 정의
function Starlight.Button:Init()
    self.baseclass = baseclass.Get("DButton")
    self:Inherit()

    self.text = "Button"
    self.variant = "text"
    self._variants = { "text", "contained", "outlined" }
    self.backgroundColor = Starlight.theme.palette[self.mode][self.color].main
    self:SetTextColor(Starlight.theme.getContrastText(self.backgroundColor))
    self:SetFont("Starlight_subtitle1")
end

function Starlight.Button:Paint(width, height)
    local borderRadius = Starlight.theme.shape.borderRadius

    draw.RoundedBox(borderRadius, 0, 0, width, height, self.backgroundColor)
end

---Button 형태 설정
---@param variant "text"|"contained"|"outlined" 버튼 형태
function Starlight.Button:SetVariant(variant)
    if not table.HasValue(self._variants, variant) then
        error("Invalid variant: " .. variant)
        return
    end

    self.variant = variant
end

function Starlight.Button:UpdateColours()
    local color = Starlight.theme.palette[self.mode][self.color].main
    if self:IsDown() then
        self.backgroundColor = Starlight.theme.GetDarkColor(color)
    elseif self:IsHovered() then
        self.backgroundColor = Starlight.theme.GetLightColor(color)
    else
        self.backgroundColor = color
    end
end

-- Starlight Button 객체 등록
vgui.Register("Starlight_Button", Starlight.Button, "DButton")
