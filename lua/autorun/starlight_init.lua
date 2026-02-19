print("Hello, Starlight!")

local basepath = "starlight/"
Starlight = {}
Starlight.Class = {}

---클라이언트 측 lua 파일 초기화
---@param path string
local function initClient(path)
    path = basepath .. path .. ".lua"
    AddCSLuaFile(path)
    if CLIENT then
        include(path)
    end
end

---서버 측 lua 파일 초기화
---@param path string
local function initServer(path)
    path = basepath .. path .. ".lua"
    if SERVER then
        include(path)
    end
end

initClient("client/theme")
initClient("client/test")

-- Base 클래스 로드
initClient("client/base/baseObject")
initClient("client/base/coloredObject")

-- 컴포넌트 로드
initClient("client/component/frame")
initClient("client/component/button")
