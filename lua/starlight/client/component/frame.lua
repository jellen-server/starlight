---@class Starlight_Frame : DFrame
Starlight.Frame = {}

---Starlight Frame 객체 정의
function Starlight.Frame:Init()
    self.title = "Frame"
    self.variant = "light"
    self._variants = { "light", "dark" }
    self.titleOffset = 5
    self.baseclass = baseclass.Get("DFrame")

    self.baseclass.SetTitle(self, "")

    self:SetSize(300, 300)
    self:SetMinimumSize(200, 200)
    self:Center()
    self:SetDraggable(true)
    self:SetSizable(true)
    self:ShowCloseButton(true)
    self:SetScreenLock(true)
    self:MakePopup()
end

---DFrame Paint 메소드 오버라이드
---@param width number 창 너비
---@param height number 창 높이
function Starlight.Frame:Paint(width, height)
    local borderRadius = Starlight.theme.shape.borderRadius

    local backgroundColor = Starlight.theme.palette[self.variant].background.default
    local headerColor = self.variant == "light" and HexToColor("#d3e3fd") or HexToColor("#1f2125")
    local textColor = Starlight.theme.palette[self.variant].text.primary

    draw.RoundedBox(borderRadius, 0, 0, width, height, backgroundColor)
    draw.RoundedBoxEx(borderRadius, 0, 0, width, 25, headerColor, true, true, false, false)
    draw.SimpleText(self.title, "Starlight_subtitle1", self.titleOffset, 12, textColor, TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER)
end

---Frame 제목 설정
---@param title string 창 제목
function Starlight.Frame:SetTitle(title)
    self.title = title
end

---Frame 아이콘 설정
---@param icon string 아이콘 에셋 경로
function Starlight.Frame:SetIcon(icon)
    self.baseclass.SetIcon(self, icon)

    if icon == nil or icon == "" then
        self.titleOffset = 5
    else
        self.titleOffset = 25
    end
end

---Frame 색상 테마 설정
---@param variant "light"|"dark" 색상 테마
function Starlight.Frame:SetVariant(variant)
    if ! table.HasValue(self._variants, variant) then
        error("Invalid variant: " .. variant)
        return
    end
    self.variant = variant
end

-- Starlight Frame 객체 등록
vgui.Register("Starlight_Frame", Starlight.Frame, "DFrame")
