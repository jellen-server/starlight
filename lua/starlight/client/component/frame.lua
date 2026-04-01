---@class Starlight_Frame : StarlightBaseObject, DFrame
---@field title string
---@field elevation number
---@field headerHeight number
Starlight.Frame = Starlight.Class.BaseObject:Copy()

local HEADER_HEIGHT = 40

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

---Starlight Frame 초기화
function Starlight.Frame:Init()
    self.baseclass = baseclass.Get("DFrame")
    self:Inherit()

    self.title        = "Frame"
    self.elevation    = 8
    self.headerHeight = HEADER_HEIGHT
    self._iconVisible = false

    -- DFrame 기본 타이틀/닫기버튼 비활성화 (직접 구현)
    self.baseclass.SetTitle(self, "")
    self:ShowCloseButton(false)

    self:SetSize(300, 300)
    self:SetMinimumSize(200, 100)
    self:Center()
    self:SetDraggable(true)
    self:SetSizable(true)
    self:SetScreenLock(true)
    self:MakePopup()

    -- 테마 기반 닫기 버튼 생성
    self._closeBtn = vgui.Create("DButton", self)
    self._closeBtn:SetSize(24, 24)
    self._closeBtn:SetText("")
    self._closeBtn.DoClick = function()
        self:Close()
    end
    self._closeBtn.Paint = function(btn, bw, bh)
        local palette = Starlight.theme.palette[self.mode]
        local br      = Starlight.theme.shape.borderRadius

        if btn:IsDown() then
            draw.RoundedBox(br, 0, 0, bw, bh,
                Color(palette.text.primary.r, palette.text.primary.g, palette.text.primary.b,
                    math.Round(0.12 * 255)))
        elseif btn:IsHovered() then
            draw.RoundedBox(br, 0, 0, bw, bh,
                Color(palette.text.primary.r, palette.text.primary.g, palette.text.primary.b,
                    math.Round(0.08 * 255)))
        end

        -- X 아이콘 (surface.DrawLine 두 개)
        local margin = 6
        local tx = palette.text.secondary
        surface.SetDrawColor(tx.r, tx.g, tx.b, tx.a)
        surface.DrawLine(margin,      margin,      bw - margin, bh - margin)
        surface.DrawLine(bw - margin, margin,      margin,      bh - margin)
    end
end

---레이아웃 계산: 닫기 버튼 위치
---@param w number
---@param h number
function Starlight.Frame:PerformLayout(w, h)
    local margin = math.floor((self.headerHeight - 24) / 2)
    self._closeBtn:SetPos(w - 24 - margin, margin)
end

---DFrame Paint 오버라이드
---@param w number
---@param h number
function Starlight.Frame:Paint(w, h)
    local theme   = Starlight.theme
    local palette = theme.palette[self.mode]
    local r       = theme.shape.borderRadius
    local hh      = self.headerHeight

    -- 쉐도우
    DrawElevationShadow(r, 0, 0, w, h, self.elevation)

    -- 바디 배경 (paper)
    draw.RoundedBox(r, 0, 0, w, h, palette.background.paper)

    -- 헤더 배경: paper 위에 팔레트 색상 tint 오버레이
    local tint
    if self.mode == "light" then
        local p = palette.primary.main
        tint = Color(p.r, p.g, p.b, math.Round(0.15 * 255))
    else
        tint = Color(255, 255, 255, math.Round(0.05 * 255))
    end

    draw.RoundedBoxEx(r, 0, 0, w, hh, palette.background.paper, true, true, false, false)
    draw.RoundedBoxEx(r, 0, 0, w, hh, tint,                     true, true, false, false)

    -- 헤더 하단 구분선
    surface.SetDrawColor(palette.divider.r, palette.divider.g, palette.divider.b, palette.divider.a)
    surface.DrawLine(0, hh, w, hh)

    -- 타이틀 텍스트
    local textX = self._iconVisible and 36 or 12
    draw.SimpleText(
        self.title,
        "Starlight_h6",
        textX,
        math.floor(hh / 2),
        palette.text.primary,
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER
    )
end

---Frame 제목 설정
---@param title string
function Starlight.Frame:SetTitle(title)
    self.title = title
end

---Frame 아이콘 설정
---@param icon string 아이콘 에셋 경로
function Starlight.Frame:SetIcon(icon)
    self.baseclass.SetIcon(self, icon)
    self._iconVisible = (icon ~= nil and icon ~= "")
end

---Frame 테마 모드 설정
---@param variant "light"|"dark"
function Starlight.Frame:SetMode(variant)
    Starlight.Class.BaseObject.SetMode(self, variant)
end

---Frame elevation 설정 (0~24)
---@param n number
function Starlight.Frame:SetElevation(n)
    self.elevation = math.Clamp(math.floor(n), 0, 24)
end

-- Starlight Frame 등록
vgui.Register("Starlight_Frame", Starlight.Frame, "DFrame")
