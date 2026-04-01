---@class Starlight_Button : StarlightColoredObject, DButton
---@field variant "text"|"contained"|"outlined"
---@field size "small"|"medium"|"large"
---@field disabled boolean
Starlight.Button = Starlight.Class.ColoredObject:Copy()

--- elevation 쉐도우 드로우 헬퍼
---@param r number borderRadius
---@param x number
---@param y number
---@param w number
---@param h number
---@param elevation number 0~24
local function DrawElevationShadow(r, x, y, w, h, elevation)
    local shadow = Starlight.theme.shadows[math.Clamp(elevation, 0, 24)]
    if not shadow or shadow.alpha <= 0 then return end
    local blur = math.max(1, math.Round(shadow.blur * 0.3))
    draw.RoundedBox(r + blur, x - blur, y + blur, w + blur * 2, h + blur,
        Color(0, 0, 0, shadow.alpha))
end

---@type ("text"|"contained"|"outlined")[]
Starlight.Button._variants = { "text", "contained", "outlined" }

---@type ("small"|"medium"|"large")[]
Starlight.Button._sizes = { "small", "medium", "large" }

--- size별 폰트 + 패딩 매핑
local sizeMap = {
    small  = { font = "Starlight_caption",   padX = 10, padY = 4 },
    medium = { font = "Starlight_button",    padX = 16, padY = 6 },
    large  = { font = "Starlight_subtitle2", padX = 22, padY = 8 },
}

---Starlight Button 초기화
function Starlight.Button:Init()
    self:Inherit()

    self.variant  = "contained"
    self.size     = "medium"
    self.disabled = false

    -- contained variant의 현재 페인트 색상 (hover/press 상태 반영)
    self._paintColor = Starlight.theme.palette[self.mode][self.color].main

    self:_ApplySize()
end

--- size에 따라 폰트 적용
function Starlight.Button:_ApplySize()
    local s = sizeMap[self.size] or sizeMap["medium"]
    self:SetFont(s.font)
end

---@param w number
---@param h number
function Starlight.Button:Paint(w, h)
    local theme   = Starlight.theme
    local palette = theme.palette[self.mode][self.color]
    local r       = theme.shape.borderRadius

    -- disabled 상태
    if self.disabled then
        local action = theme.palette[self.mode].action
        if self.variant == "contained" then
            draw.RoundedBox(r, 0, 0, w, h, action.disabledBackground)
        elseif self.variant == "outlined" then
            draw.RoundedBox(r,     0, 0, w,     h,     action.disabledBackground)
            draw.RoundedBox(r - 1, 1, 1, w - 2, h - 2, Color(0, 0, 0, 0))
        end
        -- text variant는 배경 없음
        self:SetTextColor(action.disabled)
        return
    end

    if self.variant == "contained" then
        -- elevation: idle=2, hover=4, press=8
        local elev = self:IsDown() and 8 or (self:IsHovered() and 4 or 2)
        DrawElevationShadow(r, 0, 0, w, h, elev)
        draw.RoundedBox(r, 0, 0, w, h, self._paintColor)
        self:SetTextColor(theme.getContrastText(self._paintColor))

    elseif self.variant == "outlined" then
        local tintA = 0
        if self:IsDown() then
            tintA = math.Round(0.12 * 255)
        elseif self:IsHovered() then
            tintA = math.Round(0.08 * 255)
        end

        -- 1px border 시뮬레이션: outer=border 색상, inner=투명
        draw.RoundedBox(r,     0, 0, w,     h,     palette.main)
        draw.RoundedBox(r - 1, 1, 1, w - 2, h - 2, Color(0, 0, 0, 0))

        if tintA > 0 then
            draw.RoundedBox(r - 1, 1, 1, w - 2, h - 2,
                Color(palette.main.r, palette.main.g, palette.main.b, tintA))
        end

        self:SetTextColor(palette.main)

    elseif self.variant == "text" then
        local tintA = 0
        if self:IsDown() then
            tintA = math.Round(0.12 * 255)
        elseif self:IsHovered() then
            tintA = math.Round(0.08 * 255)
        end

        if tintA > 0 then
            draw.RoundedBox(r, 0, 0, w, h,
                Color(palette.main.r, palette.main.g, palette.main.b, tintA))
        end

        self:SetTextColor(palette.main)
    end
end

--- contained variant의 페인트 색상 갱신 (hover/press 상태)
function Starlight.Button:UpdateColours()
    if self.variant ~= "contained" then return end

    local main = Starlight.theme.palette[self.mode][self.color].main
    if self:IsDown() then
        self._paintColor = Starlight.theme.GetDarkColor(main)
    elseif self:IsHovered() then
        self._paintColor = Starlight.theme.GetLightColor(main)
    else
        self._paintColor = main
    end
end

---Button variant 설정
---@param variant "text"|"contained"|"outlined"
function Starlight.Button:SetVariant(variant)
    if not table.HasValue(self._variants, variant) then
        error("Invalid variant: " .. variant)
        return
    end
    self.variant     = variant
    self._paintColor = Starlight.theme.palette[self.mode][self.color].main
end

---Button size 설정 (VGUI SetSize(w,h)와 충돌 방지를 위해 SetButtonSize 사용)
---@param size "small"|"medium"|"large"
function Starlight.Button:SetButtonSize(size)
    if not table.HasValue(self._sizes, size) then
        error("Invalid size: " .. size)
        return
    end
    self.size = size
    self:_ApplySize()
end

---Button 비활성화 상태 설정
---@param state boolean
function Starlight.Button:SetDisabled(state)
    self.disabled = state
    self:SetMouseInputEnabled(not state)
end

-- Starlight Button 등록
vgui.Register("Starlight_Button", Starlight.Button, "DButton")
