---@class StarlightTheme
---@field palette table
---@field typography table
---@field shape table
---@field shadows table
---@field transitions table
---@field zIndex table
---@field breakpoints table
---@field spacing fun(...): number
---@field getContrastText fun(color: Color): Color
---@field GetLightColor fun(color: Color): Color
---@field GetDarkColor fun(color: Color): Color

--- 두 테이블을 깊게 병합. override가 base를 덮어씀.
---@param base table
---@param override table
---@return table
local function deepMerge(base, override)
    local result = {}
    for k, v in pairs(base) do
        if type(v) == "table" and type(override[k]) == "table" then
            result[k] = deepMerge(v, override[k])
        elseif override[k] ~= nil then
            result[k] = override[k]
        else
            result[k] = v
        end
    end
    for k, v in pairs(override) do
        if result[k] == nil then
            result[k] = v
        end
    end
    return result
end

--- 0~1 opacity fraction + RGB → GMod Color (alpha 0~255)
---@param r number
---@param g number
---@param b number
---@param opacity number 0.0 ~ 1.0
---@return Color
local function opacityColor(r, g, b, opacity)
    return Color(r, g, b, math.Round(opacity * 255))
end

--- 기본 팔레트 생성
local function buildDefaultPalette()
    return {
        light = {
            primary = {
                main  = HexToColor("#1976d2"),
                light = HexToColor("#42a5f5"),
                dark  = HexToColor("#1565c0"),
            },
            secondary = {
                main  = HexToColor("#9c27b0"),
                light = HexToColor("#ba68c8"),
                dark  = HexToColor("#7b1fa2"),
            },
            error = {
                main  = HexToColor("#d32f2f"),
                light = HexToColor("#ef5350"),
                dark  = HexToColor("#c62828"),
            },
            warning = {
                main  = HexToColor("#ed6c02"),
                light = HexToColor("#ff9800"),
                dark  = HexToColor("#e65100"),
            },
            info = {
                main  = HexToColor("#0288d1"),
                light = HexToColor("#03a9f4"),
                dark  = HexToColor("#01579b"),
            },
            success = {
                main  = HexToColor("#2e7d32"),
                light = HexToColor("#4caf50"),
                dark  = HexToColor("#1b5e20"),
            },
            text = {
                primary   = opacityColor(0, 0, 0, 0.87),
                secondary = opacityColor(0, 0, 0, 0.60),
                disabled  = opacityColor(0, 0, 0, 0.38),
            },
            divider    = opacityColor(0, 0, 0, 0.12),
            background = {
                default = HexToColor("#ffffff"),
                paper   = HexToColor("#ffffff"),
            },
            action = {
                active             = opacityColor(0, 0, 0, 0.54),
                hover              = opacityColor(0, 0, 0, 0.04),
                hoverOpacity       = 0.04,
                selected           = opacityColor(0, 0, 0, 0.08),
                selectedOpacity    = 0.08,
                disabled           = opacityColor(0, 0, 0, 0.26),
                disabledBackground = opacityColor(0, 0, 0, 0.12),
                disabledOpacity    = 0.38,
                focus              = opacityColor(0, 0, 0, 0.12),
                focusOpacity       = 0.12,
                activatedOpacity   = 0.12,
            },
        },
        dark = {
            primary = {
                main  = HexToColor("#90caf9"),
                light = HexToColor("#e3f2fd"),
                dark  = HexToColor("#42a5f5"),
            },
            secondary = {
                main  = HexToColor("#ce93d8"),
                light = HexToColor("#f3e5f5"),
                dark  = HexToColor("#ab47bc"),
            },
            error = {
                main  = HexToColor("#f44336"),
                light = HexToColor("#e57373"),
                dark  = HexToColor("#d32f2f"),
            },
            warning = {
                main  = HexToColor("#ffa726"),
                light = HexToColor("#ffb74d"),
                dark  = HexToColor("#f57c00"),
            },
            info = {
                main  = HexToColor("#29b6f6"),
                light = HexToColor("#4fc3f7"),
                dark  = HexToColor("#0288d1"),
            },
            success = {
                main  = HexToColor("#66bb6a"),
                light = HexToColor("#81c784"),
                dark  = HexToColor("#388e3c"),
            },
            text = {
                primary   = opacityColor(255, 255, 255, 1.00),
                secondary = opacityColor(255, 255, 255, 0.70),
                disabled  = opacityColor(255, 255, 255, 0.50),
            },
            divider    = opacityColor(255, 255, 255, 0.12),
            background = {
                default = HexToColor("#121212"),
                paper   = HexToColor("#121212"),
            },
            action = {
                active             = opacityColor(255, 255, 255, 0.54),
                hover              = opacityColor(255, 255, 255, 0.04),
                hoverOpacity       = 0.04,
                selected           = opacityColor(255, 255, 255, 0.08),
                selectedOpacity    = 0.08,
                disabled           = opacityColor(255, 255, 255, 0.26),
                disabledBackground = opacityColor(255, 255, 255, 0.12),
                disabledOpacity    = 0.38,
                focus              = opacityColor(255, 255, 255, 0.12),
                focusOpacity       = 0.12,
                activatedOpacity   = 0.12,
            },
        },
    }
end

--- 기본 타이포그래피 설정 생성
local function buildDefaultTypography()
    return {
        font              = "DermaDefault",
        fontSize          = 16,
        fontWeightLight   = 300,
        fontWeightRegular = 400,
        fontWeightMedium  = 500,
        fontWeightBold    = 700,
        lineHeights = {
            h1        = 1.167, h2        = 1.2,   h3       = 1.167,
            h4        = 1.235, h5        = 1.334, h6       = 1.6,
            subtitle1 = 1.75,  subtitle2 = 1.57,
            body1     = 1.5,   body2     = 1.43,
            caption   = 1.66,  button    = 1.75,  overline = 2.66,
        },
        _variants = {
            "h1", "h2", "h3", "h4", "h5", "h6",
            "subtitle1", "subtitle2",
            "body1", "body2",
            "caption", "button", "overline",
        },
    }
end

--- elevation 0~24 shadow 테이블 생성.
--- GMod에 CSS box-shadow가 없으므로 alpha + blur 값으로 근사.
local function buildDefaultShadows()
    local shadows = {}
    shadows[0]  = { alpha = 0,   blur = 0  }
    shadows[1]  = { alpha = 30,  blur = 2  }
    shadows[2]  = { alpha = 35,  blur = 3  }
    shadows[3]  = { alpha = 40,  blur = 4  }
    shadows[4]  = { alpha = 45,  blur = 5  }
    shadows[5]  = { alpha = 50,  blur = 6  }
    shadows[6]  = { alpha = 55,  blur = 7  }
    shadows[7]  = { alpha = 58,  blur = 8  }
    shadows[8]  = { alpha = 61,  blur = 9  }
    shadows[9]  = { alpha = 63,  blur = 10 }
    shadows[10] = { alpha = 65,  blur = 11 }
    shadows[11] = { alpha = 67,  blur = 12 }
    shadows[12] = { alpha = 69,  blur = 13 }
    shadows[13] = { alpha = 71,  blur = 14 }
    shadows[14] = { alpha = 73,  blur = 15 }
    shadows[15] = { alpha = 75,  blur = 16 }
    shadows[16] = { alpha = 77,  blur = 17 }
    shadows[17] = { alpha = 79,  blur = 18 }
    shadows[18] = { alpha = 81,  blur = 19 }
    shadows[19] = { alpha = 83,  blur = 20 }
    shadows[20] = { alpha = 85,  blur = 21 }
    shadows[21] = { alpha = 87,  blur = 22 }
    shadows[22] = { alpha = 89,  blur = 23 }
    shadows[23] = { alpha = 91,  blur = 24 }
    shadows[24] = { alpha = 93,  blur = 25 }
    return shadows
end

--- typography 설정으로 Starlight_* surface 폰트 등록
---@param typo table
local function RegisterFonts(typo)
    local f  = typo.font
    local fs = typo.fontSize
    local bl = typo.fontWeightBold
    local md = typo.fontWeightMedium
    local rg = typo.fontWeightRegular

    surface.CreateFont("Starlight_h1",        { font = f, size = math.Round(fs * 6.000), weight = bl })
    surface.CreateFont("Starlight_h2",        { font = f, size = math.Round(fs * 3.750), weight = bl })
    surface.CreateFont("Starlight_h3",        { font = f, size = math.Round(fs * 3.000), weight = rg })
    surface.CreateFont("Starlight_h4",        { font = f, size = math.Round(fs * 2.125), weight = rg })
    surface.CreateFont("Starlight_h5",        { font = f, size = math.Round(fs * 1.500), weight = rg })
    surface.CreateFont("Starlight_h6",        { font = f, size = math.Round(fs * 1.250), weight = md })
    surface.CreateFont("Starlight_subtitle1", { font = f, size = math.Round(fs * 1.000), weight = rg })
    surface.CreateFont("Starlight_subtitle2", { font = f, size = math.Round(fs * 0.875), weight = md })
    surface.CreateFont("Starlight_body1",     { font = f, size = math.Round(fs * 1.000), weight = rg })
    surface.CreateFont("Starlight_body2",     { font = f, size = math.Round(fs * 0.875), weight = rg })
    surface.CreateFont("Starlight_caption",   { font = f, size = math.Round(fs * 0.750), weight = rg })
    surface.CreateFont("Starlight_button",    { font = f, size = math.Round(fs * 0.875), weight = md })
    surface.CreateFont("Starlight_overline",  { font = f, size = math.Round(fs * 0.750), weight = rg })
end

--- Starlight 테마를 생성하는 팩토리 함수.
--- options로 기본값을 부분 오버라이드할 수 있음.
---@param options table|nil
---@return StarlightTheme
function Starlight.createTheme(options)
    local defaults = {
        palette    = buildDefaultPalette(),
        typography = buildDefaultTypography(),
        shape      = { borderRadius = 4 },
        shadows    = buildDefaultShadows(),
        transitions = {
            duration = {
                shortest       = 150,
                shorter        = 200,
                short          = 250,
                standard       = 300,
                complex        = 375,
                enteringScreen = 225,
                leavingScreen  = 195,
            },
            easing = {
                easeInOut = "easeInOut",
                easeOut   = "easeOut",
                easeIn    = "easeIn",
                sharp     = "sharp",
            },
        },
        zIndex = {
            mobileStepper = 1000,
            fab           = 1050,
            speedDial     = 1050,
            appBar        = 1100,
            drawer        = 1200,
            modal         = 1300,
            snackbar      = 1400,
            tooltip       = 1500,
        },
        breakpoints = {
            xs = 0,
            sm = 600,
            md = 900,
            lg = 1200,
            xl = 1536,
        },
    }

    local theme = deepMerge(defaults, options or {})

    --- 간격 계산 함수. spacing(n) = n * 8px.
    --- spacing(1, 2) → 8, 16 (두 값 반환)
    ---@vararg number
    ---@return number ...
    function theme.spacing(...)
        local args = { ... }
        if #args == 0 then return 8 end
        local results = {}
        for _, v in ipairs(args) do
            table.insert(results, v * 8)
        end
        return table.unpack(results)
    end

    --- 배경색 기준 가독성 높은 텍스트 색상 반환 (YIQ 공식)
    ---@param color Color
    ---@return Color
    function theme.getContrastText(color)
        local yiq = (color.r * 299 + color.g * 587 + color.b * 114) / 1000
        return yiq >= 128 and Color(0, 0, 0, 255) or Color(255, 255, 255, 255)
    end

    --- HSV value +0.1 밝게
    ---@param color Color
    ---@return Color
    function theme.GetLightColor(color)
        local h, s, v = color:ToHSV()
        return HSVToColor(h, s, math.Clamp(v + 0.1, 0, 1))
    end

    --- HSV value -0.1 어둡게
    ---@param color Color
    ---@return Color
    function theme.GetDarkColor(color)
        local h, s, v = color:ToHSV()
        return HSVToColor(h, s, math.Clamp(v - 0.1, 0, 1))
    end

    RegisterFonts(theme.typography)

    return theme
end

--- 기본 테마 인스턴스
Starlight.theme = Starlight.createTheme({})
