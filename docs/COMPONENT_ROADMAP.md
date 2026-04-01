# Starlight Component Roadmap

Material UI ([mui.com/material-ui/all-components](https://mui.com/material-ui/all-components/)) 전체 컴포넌트 목록을 기준으로 한 Starlight 구현 로드맵.

총 **49개 컴포넌트**를 9단계로 나누어 구현한다. 각 단계는 이후 단계의 의존성을 충족한다.

---

## 구현 현황

| 컴포넌트 | 상태 | 파일 |
|---------|------|------|
| Frame | ✅ 완료 | `lua/starlight/client/component/frame.lua` |
| Button | ✅ 완료 | `lua/starlight/client/component/button.lua` |

---

## Phase 1 — Layout Primitives (레이아웃 기반)

> 모든 컴포넌트의 기반이 되는 레이아웃 도구. 먼저 구현해야 이후 컴포넌트 배치가 가능.

| 컴포넌트 | MUI 카테고리 | GMod 기반 클래스 | 설명 |
|---------|------------|----------------|------|
| **Box** | Layout | DPanel | 범용 레이아웃 컨테이너. padding, margin, sx 스타일 속성 지원 |
| **Stack** | Layout | DPanel | 자식 패널을 수직/수평으로 균일 간격 배치. `direction`, `spacing`, `alignItems` |
| **Container** | Layout | DPanel | 최대 너비 제한 컨테이너. `maxWidth`(sm/md/lg/xl), `disableGutters` |
| **Grid** | Layout | DPanel | 12열 기반 그리드 레이아웃. xs/sm/md/lg 컬럼 수 지정 |
| **Image List** | Layout | DPanel | 이미지 그리드. `cols`, `rowHeight`, `variant`(standard/masonry/quilted) |
| **Masonry** | Layout | DPanel | 가변 높이 그리드 (Pinterest 스타일). `columns`, `spacing` |

---

## Phase 2 — Base Display (기본 표시 요소)

> 텍스트, 구분선, 기본 표면. 이후 모든 컴포넌트에서 재사용.

| 컴포넌트 | MUI 카테고리 | GMod 기반 클래스 | 설명 |
|---------|------------|----------------|------|
| **Typography** | Data Display | DLabel | 테마 폰트 래퍼. `variant`(h1~h6, subtitle1~2, body1~2, caption, button), `color`, `align` |
| **Divider** | Data Display | DPanel | 수평/수직 구분선. `orientation`, `variant`(fullWidth/inset/middle), `light` |
| **Paper** | Surfaces | DPanel | 기본 surface 컨테이너. `elevation`(0~24), `variant`(elevation/outlined), `square` |

---

## Phase 3 — Simple Inputs (단순 입력)

> Button 확장형 + 상태 토글 입력들.

| 컴포넌트 | MUI 카테고리 | GMod 기반 클래스 | 설명 |
|---------|------------|----------------|------|
| **Button Group** | Inputs | DPanel + Button | 버튼 묶음. `orientation`, `variant`, `size`, 구분선 자동 |
| **Floating Action Button** | Inputs | DPanel | 원형 플로팅 버튼. `variant`(circular/extended), `size`(small/medium/large) |
| **Toggle Button** | Inputs | DPanel | 토글 가능한 버튼. ToggleButtonGroup으로 단일/다중 선택 |
| **Checkbox** | Inputs | DCheckBox | 테마 체크박스. `color`, `size`, `indeterminate` 상태 |
| **Radio Group** | Inputs | DPanel + DCheckBox | 단일 선택 라디오 그룹. `row`(수평 배열), `defaultValue` |
| **Switch** | Inputs | DPanel | 슬라이딩 토글 스위치. `color`, `size`(small/medium) |

---

## Phase 4 — Complex Inputs (복잡한 입력)

> 텍스트 입력, 선택, 범위 등 더 복잡한 입력 패턴.

| 컴포넌트 | MUI 카테고리 | GMod 기반 클래스 | 설명 |
|---------|------------|----------------|------|
| **Text Field** | Inputs | DTextEntry | 텍스트 입력. `variant`(outlined/filled/standard), `label`, `placeholder`, `multiline`, `error` |
| **Select** | Inputs | DComboBox | 드롭다운 선택. `multiple`, `size`, `native`, MenuItem 통합 |
| **Autocomplete** | Inputs | DTextEntry + DPanel | 입력 + 자동완성 목록. `freeSolo`, `multiple`, `groupBy` |
| **Slider** | Inputs | DNumSlider | 수치/범위 슬라이더. `min`/`max`/`step`, `marks`, `track`(normal/inverted/false) |
| **Rating** | Inputs | DPanel | 별점 입력/표시. `max`, `precision`(0.5), `readOnly`, `size` |
| **Transfer List** | Inputs | DPanel | 두 목록 간 항목 이동 UI. 체크박스 + 이동 버튼 조합 |

---

## Phase 5 — Data Display (데이터 표시)

> 정보 시각화 — 리스트, 테이블, 뱃지 등.

| 컴포넌트 | MUI 카테고리 | GMod 기반 클래스 | 설명 |
|---------|------------|----------------|------|
| **Avatar** | Data Display | DPanel | 원형 이미지/이니셜. `src`, `variant`(circular/rounded/square), `sizes` |
| **Badge** | Data Display | DPanel (오버레이) | 다른 컴포넌트 위 뱃지. `badgeContent`, `color`, `variant`(standard/dot), `max` |
| **Chip** | Data Display | DPanel | 태그/필터 pill. `variant`(filled/outlined), `onDelete`, `avatar`, `icon` |
| **List** | Data Display | DScrollPanel | 스크롤 항목 목록. ListItem, ListItemButton, ListItemIcon, ListItemText, ListItemAvatar 서브컴포넌트 |
| **Table** | Data Display | DPanel | 데이터 테이블. TableHead/Body/Row/Cell 서브컴포넌트, `stickyHeader`, `size`(small/medium) |
| **Tooltip** | Data Display | DPanel (Think) | 호버 툴팁. `placement`(top/bottom/left/right), `arrow`, `title` |
| **Icons** | Data Display | — | Material Icons 폰트 또는 커스텀 아이콘 렌더링 시스템 |
| **Skeleton** | Feedback | DPanel | 로딩 플레이스홀더. `variant`(text/circular/rectangular/rounded), `animation`(pulse/wave) |

---

## Phase 6 — Surfaces (표면 컴포넌트)

> 카드, 아코디언 등 콘텐츠 컨테이너. Phase 2의 Paper에 의존.

| 컴포넌트 | MUI 카테고리 | GMod 기반 클래스 | 설명 |
|---------|------------|----------------|------|
| **Card** | Surfaces | Paper 기반 | 콘텐츠 카드. CardHeader/CardMedia/CardContent/CardActions/CardActionArea 서브컴포넌트 |
| **Accordion** | Surfaces | DPanel | 접기/펼치기 섹션. AccordionSummary/AccordionDetails, `defaultExpanded`, `disableGutters` |
| **App Bar** | Surfaces | DPanel | 상단 네비게이션 바. `position`(fixed/absolute/sticky/static), `color`, Toolbar 서브컴포넌트 |

---

## Phase 7 — Feedback (피드백 컴포넌트)

> 상태 알림, 오버레이, 로딩.

| 컴포넌트 | MUI 카테고리 | GMod 기반 클래스 | 설명 |
|---------|------------|----------------|------|
| **Alert** | Feedback | Paper 기반 | 메시지 박스. `severity`(error/warning/info/success), `variant`(filled/outlined/standard), `action` |
| **Progress** | Feedback | DPanel | LinearProgress + CircularProgress. `value`, `variant`(determinate/indeterminate/buffer) |
| **Dialog** | Feedback | DFrame 기반 | 모달 대화상자. DialogTitle/Content/ContentText/Actions 서브컴포넌트, `maxWidth`, `fullScreen` |
| **Snackbar** | Feedback | DPanel (애니메이션) | 일시적 알림. `autoHideDuration`, `anchorOrigin`(vertical/horizontal), `action` |
| **Backdrop** | Feedback | DPanel (반투명) | 모달 뒤 어두운 오버레이. `open`, `invisible` |

---

## Phase 8 — Navigation (네비게이션 컴포넌트)

> 화면 전환 및 탐색. 가장 복잡한 컴포넌트들.

| 컴포넌트 | MUI 카테고리 | GMod 기반 클래스 | 설명 |
|---------|------------|----------------|------|
| **Tabs** | Navigation | DPanel | 탭 전환. Tab/TabPanel 서브컴포넌트, `variant`(standard/scrollable/fullWidth), `indicatorColor` |
| **Menu** | Navigation | DMenu 기반 | 컨텍스트/드롭다운 메뉴. MenuItem, MenuList, `PopoverOrigin`, `dense` |
| **Drawer** | Navigation | DPanel (슬라이드) | 측면 슬라이드 패널. `anchor`(left/right/top/bottom), `variant`(temporary/persistent/permanent) |
| **Breadcrumbs** | Navigation | DPanel | 경로 탐색. `separator`, `maxItems`, `expandText` |
| **Pagination** | Navigation | DPanel | 페이지 컨트롤. `count`, `shape`(circular/rounded), `variant`(outlined/text), `boundaryCount` |
| **Bottom Navigation** | Navigation | DPanel | 하단 탭 바. BottomNavigationAction 서브컴포넌트, `showLabels` |
| **Stepper** | Navigation | DPanel | 단계 진행 UI. Step/StepLabel/StepContent 서브컴포넌트, `orientation`(horizontal/vertical), `alternativeLabel` |
| **Speed Dial** | Navigation | DPanel (애니메이션) | 플로팅 다중 액션 버튼. SpeedDialAction 서브컴포넌트, `direction`(up/down/left/right) |
| **Link** | Navigation | DLabel | 클릭 가능 텍스트 링크. `color`, `underline`(always/hover/none), Typography variant 연동 |

---

## Phase 9 — Advanced Layout (고급 레이아웃)

> 특수한 용도의 레이아웃 컴포넌트.

| 컴포넌트 | MUI 카테고리 | GMod 기반 클래스 | 설명 |
|---------|------------|----------------|------|
| **Timeline** | Layout | DPanel | 시간순 이벤트 표시. TimelineItem/Separator/Dot/Content/Connector 서브컴포넌트, `position`(left/right/alternate) |

---

## 전체 현황 요약

| Phase | 카테고리 | 컴포넌트 수 | 누적 완료 |
|-------|---------|-----------|---------|
| 완료 | — | 2 (Frame, Button) | **2 / 49** |
| Phase 1 | Layout Primitives | 6 | 8 / 49 |
| Phase 2 | Base Display | 3 | 11 / 49 |
| Phase 3 | Simple Inputs | 6 | 17 / 49 |
| Phase 4 | Complex Inputs | 6 | 23 / 49 |
| Phase 5 | Data Display | 8 | 31 / 49 |
| Phase 6 | Surfaces | 3 | 34 / 49 |
| Phase 7 | Feedback | 5 | 39 / 49 |
| Phase 8 | Navigation | 9 | 48 / 49 |
| Phase 9 | Advanced Layout | 1 | **49 / 49** |

---

## 구현 원칙

모든 컴포넌트는 기존 패턴을 준수하여 구현한다.

```lua
-- 1. 클래스 정의 (BaseObject 또는 ColoredObject 기반)
Starlight.MyComponent = Starlight.Class.ColoredObject:Copy()

-- 2. Init에서 부모 모드 상속
function Starlight.MyComponent:Init()
    self:Inherit()
end

-- 3. Paint에서 테마 색상 참조
function Starlight.MyComponent:Paint(w, h)
    local palette = Starlight.theme.palette[self.mode][self.color]
    draw.RoundedBox(5, 0, 0, w, h, palette.main)
end

-- 4. VGUI 등록
vgui.Register("Starlight_MyComponent", Starlight.MyComponent, "DPanel")
```

신규 컴포넌트 파일은 반드시 `lua/autorun/starlight_init.lua` 에 `AddCSLuaFile` + `include` 추가 (의존성 순서 준수).
