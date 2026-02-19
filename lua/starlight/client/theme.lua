Starlight.theme = {
    palette = {
        light = {
            primary = {
                main = HexToColor("#1976d2"),
                light = HexToColor("#42a5f5"),
                dark = HexToColor("#1565c0")
            },
            secondary = {
                main = HexToColor("#9c27b0"),
                light = HexToColor("#ba68c8"),
                dark = HexToColor("#7b1fa2")
            },
            error = {
                main = HexToColor("#d32f2f"),
                light = HexToColor("#ef5350"),
                dark = HexToColor("#c62828")
            },
            warning = {
                main = HexToColor("#ed6c02"),
                light = HexToColor("#ff9800"),
                dark = HexToColor("#e65100")
            },
            info = {
                main = HexToColor("#0288d1"),
                light = HexToColor("#03a9f4"),
                dark = HexToColor("#01579b")
            },
            success = {
                main = HexToColor("#2e7d32"),
                light = HexToColor("#4caf50"),
                dark = HexToColor("#1b5e20")
            },
            text = {
                primary = Color(0, 0, 0, 221.85),
                secondary = Color(0, 0, 0, 15.3),
                disabled = Color(0, 0, 0, 96.9),
            },
            divider = Color(0, 0, 0, 30.6),
            background = {
                default = HexToColor("#ffffff"),
                paper = HexToColor("#ffffff")
            },
            action = {
                active = Color(0, 0, 0, 137.7),
                hover = Color(0, 0, 0, 10.2),
                hoverOpacity = 0.04,
                selected = Color(0, 0, 0, 204),
                selectedOpacity = 0.08,
                disabled = Color(0, 0, 0, 66.3),
                disabledBackground = Color(0, 0, 0, 30.6),
                disabledOpacity = 0.38,
                focus = Color(0, 0, 0, 30.6),
                focusOpacity = 0.12,
                activatedOpacity = 0.12
            }
        },
        dark = {
            primary = {
                main = HexToColor("#90caf9"),
                light = HexToColor("#e3f2fd"),
                dark = HexToColor("#42a5f5")
            },
            secondary = {
                main = HexToColor("#ce93d8"),
                light = HexToColor("#f3e5f5"),
                dark = HexToColor("#ab47bc")
            },
            error = {
                main = HexToColor("#f44336"),
                light = HexToColor("#e57373"),
                dark = HexToColor("#d32f2f")
            },
            warning = {
                main = HexToColor("#ffa726"),
                light = HexToColor("#ffb74d"),
                dark = HexToColor("#f57c00")
            },
            info = {
                main = HexToColor("#29b6f6"),
                light = HexToColor("#4fc3f7"),
                dark = HexToColor("#0288d1")
            },
            success = {
                main = HexToColor("#66bb6a"),
                light = HexToColor("#81c784"),
                dark = HexToColor("#388e3c")
            },
            text = {
                primary = HexToColor("#ffffff"),
                secondary = Color(255, 255, 255, 178.5),
                disabled = Color(255, 255, 255, 127.5),
            },
            divider = Color(255, 255, 255, 0.12),
            background = {
                default = HexToColor("#121212"),
                paper = HexToColor("#121212")
            },
            action = {
                active = Color(255, 255, 255, 137.7),
                hover = Color(255, 255, 255, 10.2),
                hoverOpacity = 0.04,
                selected = Color(255, 255, 255, 204),
                selectedOpacity = 0.08,
                disabled = Color(255, 255, 255, 66.3),
                disabledBackground = Color(255, 255, 255, 30.6),
                disabledOpacity = 0.38,
                focus = Color(255, 255, 255, 30.6),
                focusOpacity = 0.12,
                activatedOpacity = 0.12
            }
        }
    },
    typography = {
        font = "DermaDefault",
        fontSize = 16,
        fontWeightLight = 300,
        fontWeightRegular = 400,
        fontWeightMedium = 500,
        fontWeightBold = 700
    },
    shape = {
        borderRadius = 5
    }
}

-- Starlight 폰트 생성
do
    local font = Starlight.theme.typography.font
    local fontSize = Starlight.theme.typography.fontSize
    local fontWeightBold = Starlight.theme.typography.fontWeightBold
    local fontWeightMedium = Starlight.theme.typography.fontWeightMedium
    local fontWeightRegular = Starlight.theme.typography.fontWeightRegular

    surface.CreateFont("Starlight_h1",
        { font = font, size = fontSize * 3.5, weight = fontWeightBold })
    surface.CreateFont("Starlight_h2",
        { font = font, size = fontSize * 2.375, weight = fontWeightBold })
    surface.CreateFont("Starlight_h3",
        { font = font, size = fontSize * 2, weight = fontWeightBold })
    surface.CreateFont("Starlight_h4",
        { font = font, size = fontSize * 1.5625, weight = fontWeightBold })
    surface.CreateFont("Starlight_h5",
        { font = font, size = fontSize * 1.25, weight = fontWeightBold })
    surface.CreateFont("Starlight_h6",
        { font = font, size = fontSize * 1.125, weight = fontWeightBold })
    surface.CreateFont("Starlight_subtitle1",
        { font = font, size = fontSize, weight = fontWeightBold })
    surface.CreateFont("Starlight_subtitle2",
        { font = font, size = fontSize * 0.875, weight = fontWeightMedium })
    surface.CreateFont("Starlight_body1",
        { font = font, size = fontSize, weight = fontWeightRegular })
    surface.CreateFont("Starlight_body2",
        { font = font, size = fontSize * 0.875, weight = fontWeightRegular })
    surface.CreateFont("Starlight_caption",
        { font = font, size = fontSize * 0.75, weight = fontWeightRegular })
    surface.CreateFont("Starlight_button",
        { font = font, size = fontSize * 0.875, weight = fontWeightMedium })
end

---색상의 밝은 버전을 반환하는 함수
---@param color Color 색상 객체
---@return Color Color 밝은 색상 객체
Starlight.theme.GetLightColor = function(color)
    local h, s, v = color:ToHSV()
    print("origin v:", v)
    local v = math.Clamp(v + 0.1, 0, 1)
    return HSVToColor(h, s, v)
end

---색상의 어두운 버전을 반환하는 함수
---@param color Color 색상 객체
---@return Color Color 어두운 색상 객체
Starlight.theme.GetDarkColor = function(color)
    local h, s, v = color:ToHSV()
    local v = math.Clamp(v - 0.1, 0, 1)
    return HSVToColor(h, s, v)
end

---색상과 명암 대비되는 텍스트 색상을 반환하는 함수
---@param color Color 색상 객체
---@return Color Color 명암 대비 색상 객체
Starlight.theme.getContrastText = function(color)
    local r, g, b = color.r, color.g, color.b
    local yiq = (r * 299 + g * 587 + b * 114) / 1000
    return yiq >= 128 and Color(0, 0, 0) or Color(255, 255, 255)
end
