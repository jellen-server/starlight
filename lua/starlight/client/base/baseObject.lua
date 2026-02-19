---@class StarlightBaseObject
Starlight.Class.BaseObject = {}

---@type "light"|"dark"
Starlight.Class.BaseObject.mode = "light"

---@type ("light"|"dark")[]
Starlight.Class.BaseObject._modes = { "light", "dark" }

---부모 객체로부터 속성을 상속 받는 함수 (Init 메소드에서 호출)
---@protected
function Starlight.Class.BaseObject:Inherit()
    ---@diagnostic disable-next-line: undefined-field
    if IsValid(self:GetParent()) then
        ---@diagnostic disable-next-line: undefined-field
        self.mode = self:GetParent().mode or "light"
    end
end

---Starlight 테마 모드 설정
---@param variant "light"|"dark" 테마 모드
function Starlight.Class.BaseObject:SetMode(variant)
    if not table.HasValue(self._modes, variant) then
        error("Invalid variant: " .. variant)
        return
    end

    self.mode = variant
end

---StarlightBaseObject 믹스인
---@return table table 믹스인된 객체
function Starlight.Class.BaseObject:Copy()
    local copy = {}

    for k, v in pairs(self) do
        if type(v) == "table" then
            copy[k] = table.Copy(v)
        else
            copy[k] = v
        end
    end

    return copy
end
