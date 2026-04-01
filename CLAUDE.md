# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Starlight** is a Garry's Mod VGUI implementation of [Material UI](https://github.com/mui/material-ui). The goal is to provide modular, reusable UI components — mirroring Material UI's component model — so other addons can build consistently themed interfaces without reimplementing styling logic. All current code is **client-side only** — no server-side logic is implemented yet.

## Development Workflow

There are no build tools, package managers, or test runners. Development is done by:
1. Editing Lua files directly in the addon directory
2. Loading Garry's Mod and running the game to test
3. Press **F4** in-game to trigger `Starlight.Init()` which opens the test UI (defined in `lua/starlight/client/test.lua`)

`test.lua` is listed in `.gitignore` and is excluded from releases.

## Architecture

### Entry Point

`lua/autorun/starlight_init.lua` bootstraps everything. It sets up the `Starlight` global namespace, calls `AddCSLuaFile()` for all client files, and loads modules in dependency order via `initClient()`. Add new files here when creating new components.

### Module Load Order (important — dependencies must load before dependents)

1. `theme.lua` — color palettes, typography, utility functions
2. `base/baseObject.lua` — base class with theme mode support
3. `base/coloredObject.lua` — extends BaseObject with color property
4. Components (`component/frame.lua`, `component/button.lua`, etc.)
5. `test.lua` — debug UI (excluded from release via `.gitignore`)

### Theme System (`lua/starlight/client/theme.lua`)

`Starlight.theme` is the central configuration object:
- `palette[mode][colorName]` — color variants by `"light"` or `"dark"` mode, with `.main`, `.light`, `.dark`, `.contrastText` sub-properties
- `typography[variant]` — font settings for 12 variants (`h1`–`h6`, `subtitle1`–`2`, `body1`–`2`, `caption`, `button`); fonts are registered via `surface.CreateFont()` on load
- `GetLightColor(color)` / `GetDarkColor(color)` — HSV-based color lightening/darkening
- `getContrastText(color)` — returns black or white for readable text contrast

### Class System

Classes use a **copy-based mixin pattern**:
```lua
Starlight.Class.SomeClass = Starlight.Class.BaseObject:Copy()
```
`Copy()` creates a shallow copy of the class table, allowing method extension without mutating the parent. This is how inheritance is done throughout the codebase — not metatables.

`BaseObject` provides:
- `mode` property (`"light"` / `"dark"`)
- `SetMode(variant)` with validation against `_modes` lookup table
- `Inherit()` — copies mode from VGUI parent panel

`ColoredObject` extends `BaseObject` with:
- `color` property (`"primary"`, `"secondary"`, `"error"`, `"warning"`, `"info"`, `"success"`)
- `SetColor(color)` with validation against `_colors` lookup table

### Components (`lua/starlight/client/component/`)

Components follow the **VGUI Wrapper Pattern**:
- Defined as a class via `Copy()` from a base class
- Registered as a VGUI element: `vgui.Register("Starlight_ComponentName", Starlight.ComponentName, "DParentClass")`
- Override `Paint(width, height)` for custom theming
- Use `self.mode` and `self.color` to index into `Starlight.theme.palette`
- Call `self:Inherit()` in `Init()` to propagate mode from parent

**Frame** (`Starlight.Frame`) — wraps `DFrame`. Adds themed header, rounded borders, mode support.

**Button** (`Starlight.Button`) — wraps `DButton`. Three variants: `"text"`, `"contained"`, `"outlined"`. Overrides `UpdateColours()` to apply hover/press states via `GetLightColor`/`GetDarkColor`.

## Adding a New Component

1. Create `lua/starlight/client/component/mycomponent.lua`
2. Copy from the appropriate base: `Starlight.MyComponent = Starlight.Class.BaseObject:Copy()` (or `ColoredObject` if it needs color)
3. Implement `Init()`, `Paint()`, and any component-specific methods
4. Register: `vgui.Register("Starlight_MyComponent", Starlight.MyComponent, "DParentVGUIClass")`
5. Add `AddCSLuaFile` and `include` calls to `starlight_init.lua` in the correct load order

## Code Conventions

- Comments and variable names may be in Korean (developer's native language)
- EmmyLua-style type annotations (`---@type`, `---@param`) are used for IDE support
- Property validation uses lookup tables (`_modes`, `_colors`) with `table.HasValue()` checks
- Theme data is always accessed via indirection: `Starlight.theme.palette[self.mode][self.color].main`
