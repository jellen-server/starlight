# Starlight Component Roadmap

Material UI ([mui.com/material-ui/all-components](https://mui.com/material-ui/all-components/)) 전체 컴포넌트 + GMod VGUI 전용 컴포넌트를 포함한 Starlight 구현 로드맵.

총 **~75개 컴포넌트**를 9단계로 나누어 구현한다. 각 단계는 이후 단계의 의존성을 충족한다.

---

## 구현 현황

| 컴포넌트 | 상태 | 파일 |
|---------|------|------|
| Frame | ⬜ 미구현 | `lua/starlight/client/component/frame.lua` |
| Button | ⬜ 미구현 | `lua/starlight/client/component/button.lua` |

> Frame, Button은 처음부터 재구현 진행 중.

---

## Phase 1 — Layout Primitives (레이아웃 기반)

> 모든 컴포넌트의 기반이 되는 레이아웃 도구. 먼저 구현해야 이후 컴포넌트 배치가 가능.

| 컴포넌트 | 출처 | GMod 기반 클래스 | 설명 |
|---------|------|----------------|------|
| **Box** | MUI Layout | DPanel | 범용 레이아웃 컨테이너. padding, margin, sx 스타일 속성 지원 |
| **Stack** | MUI Layout | DPanel | 자식 패널을 수직/수평으로 균일 간격 배치. `direction`, `spacing`, `alignItems` |
| **Container** | MUI Layout | DPanel | 최대 너비 제한 컨테이너. `maxWidth`(sm/md/lg/xl), `disableGutters` |
| **Grid** | MUI Layout | DPanel | 12열 기반 그리드 레이아웃. xs/sm/md/lg 컬럼 수 지정 |
| **Image List** | MUI Layout | DPanel | 이미지 그리드. `cols`, `rowHeight`, `variant`(standard/masonry/quilted) |
| **Masonry** | MUI Layout | DPanel | 가변 높이 그리드 (Pinterest 스타일). `columns`, `spacing` |
| **ScrollView** | GMod DScrollPanel | DScrollPanel | 스크롤 가능한 수직 컨테이너 |
| **HorizontalScroll** | GMod DHorizontalScroller | DHorizontalScroller | 수평 스크롤 컨테이너 |
| **IconGrid** | GMod DIconLayout | DIconLayout | 고정 크기 아이콘 그리드 레이아웃 |
| **TileLayout** | GMod DTileLayout | DTileLayout | 타일 기반 자동 배치 레이아웃 |

---

## Phase 2 — Base Display (기본 표시 요소)

> 텍스트, 구분선, 기본 표면. 이후 모든 컴포넌트에서 재사용.

| 컴포넌트 | 출처 | GMod 기반 클래스 | 설명 |
|---------|------|----------------|------|
| **Typography** | MUI Data Display | DLabel | 테마 폰트 래퍼. `variant`(h1~h6, subtitle1~2, body1~2, caption, button, overline), `color`, `align` |
| **Divider** | MUI Data Display | DPanel | 수평/수직 구분선. `orientation`, `variant`(fullWidth/inset/middle) |
| **Paper** | MUI Surfaces | DPanel | 기본 surface 컨테이너. `elevation`(0~24), `variant`(elevation/outlined), `square` |
| **Image** | GMod DImage | DImage | 이미지 표시 패널. `src`, `keepAspect` |
| **Shape** | GMod DShape | DShape | 기하 도형 렌더링. `shapeType`(rect/circle) |
| **RichText** | GMod RichText | RichText | 멀티 스타일 텍스트. 색상/폰트 인라인 변경, 하이퍼링크 |

---

## Phase 3 — Simple Inputs (단순 입력)

> Button 확장형 + 상태 토글 입력들.

| 컴포넌트 | 출처 | GMod 기반 클래스 | 설명 |
|---------|------|----------------|------|
| **Button Group** | MUI Inputs | DPanel + Button | 버튼 묶음. `orientation`, `variant`, `size`, 구분선 자동 |
| **Floating Action Button** | MUI Inputs | DPanel | 원형 플로팅 버튼. `variant`(circular/extended), `size`(small/medium/large) |
| **Toggle Button** | MUI Inputs | DPanel | 토글 버튼. ToggleButtonGroup으로 단일/다중 선택 |
| **Checkbox** | MUI Inputs | DCheckBox | 테마 체크박스. `color`, `size`, `indeterminate` |
| **Radio Group** | MUI Inputs | DPanel + DCheckBox | 단일 선택 라디오 그룹. `row`, `defaultValue` |
| **Switch** | MUI Inputs | DPanel | 슬라이딩 토글 스위치. `color`, `size`(small/medium) |
| **FormControlLabel** | GMod DCheckBoxLabel | DCheckBoxLabel | 체크박스/라디오 + 인라인 레이블 복합 위젯 |

---

## Phase 4 — Complex Inputs (복잡한 입력)

> 텍스트 입력, 선택, 범위 등 더 복잡한 입력 패턴.

| 컴포넌트 | 출처 | GMod 기반 클래스 | 설명 |
|---------|------|----------------|------|
| **Text Field** | MUI Inputs | DTextEntry | 텍스트 입력. `variant`(outlined/filled/standard), `label`, `multiline`, `error` |
| **Select** | MUI Inputs | DComboBox | 드롭다운 선택. `multiple`, `size`, MenuItem 통합 |
| **Autocomplete** | MUI Inputs | DTextEntry + DPanel | 입력 + 자동완성 목록. `freeSolo`, `multiple`, `groupBy` |
| **Slider** | MUI Inputs | DNumSlider | 수치/범위 슬라이더. `min`/`max`/`step`, `marks`, `track` |
| **Rating** | MUI Inputs | DPanel | 별점 입력/표시. `max`, `precision`(0.5), `readOnly`, `size` |
| **Transfer List** | MUI Inputs | DPanel | 두 목록 간 항목 이동 UI |
| **KeyBinder** | GMod DBinder | DBinder | 키 바인딩 입력 패널 |
| **NumberInput** | GMod DNumberWang | DNumberWang | 스피너 숫자 입력 (위/아래 화살표) |
| **ColorPalette** | GMod DColorPalette | DColorPalette | 색상 스와치 선택 그리드 |
| **ColorPicker** | GMod DColorCombo | DColorCombo | 통합 색상 선택기 (큐브 + 색조 + 알파 + 헥스) |
| **FormLayout** | GMod DForm | DForm | 레이블-입력 행 형태의 폼 레이아웃 컨테이너 |
| **InlineEdit** | GMod DLabelEditable | DLabelEditable | 클릭 시 편집 가능한 인라인 레이블 |

---

## Phase 5 — Data Display (데이터 표시)

> 정보 시각화 — 리스트, 테이블, 뱃지 등.

| 컴포넌트 | 출처 | GMod 기반 클래스 | 설명 |
|---------|------|----------------|------|
| **Avatar** | MUI Data Display | DPanel | 원형 이미지/이니셜. `src`, `variant`(circular/rounded/square) |
| **Badge** | MUI Data Display | DPanel (오버레이) | 다른 컴포넌트 위 뱃지. `badgeContent`, `color`, `variant`(standard/dot), `max` |
| **Chip** | MUI Data Display | DPanel | 태그/필터 pill. `variant`(filled/outlined), `onDelete`, `avatar`, `icon` |
| **List** | MUI Data Display | DScrollPanel | 스크롤 항목 목록. ListItem/ListItemButton/ListItemIcon/ListItemText 서브컴포넌트 |
| **Table** | MUI Data Display | DPanel | 데이터 테이블. TableHead/Body/Row/Cell 서브컴포넌트, `stickyHeader`, `size` |
| **Tooltip** | MUI Data Display | DPanel (Think) | 호버 툴팁. `placement`(top/bottom/left/right), `arrow` |
| **Icons** | MUI Data Display | — | Material Icons 폰트 또는 커스텀 아이콘 렌더링 시스템 |
| **Skeleton** | MUI Feedback | DPanel | 로딩 플레이스홀더. `variant`(text/circular/rectangular/rounded), `animation` |
| **CategoryList** | GMod DCategoryList | DCategoryList | 접기/펼치기 카테고리 항목 목록 |

---

## Phase 6 — Surfaces (표면 컴포넌트)

> 카드, 아코디언 등 콘텐츠 컨테이너. Phase 2의 Paper에 의존.

| 컴포넌트 | 출처 | GMod 기반 클래스 | 설명 |
|---------|------|----------------|------|
| **Card** | MUI Surfaces | Paper 기반 | 콘텐츠 카드. CardHeader/CardMedia/CardContent/CardActions 서브컴포넌트 |
| **Accordion** | MUI Surfaces | DPanel | 접기/펼치기 섹션. AccordionSummary/AccordionDetails, `defaultExpanded` |
| **App Bar** | MUI Surfaces | DPanel | 상단 네비게이션 바. `position`(fixed/absolute/sticky/static), `color`, Toolbar 서브컴포넌트 |

---

## Phase 7 — Feedback (피드백 컴포넌트)

> 상태 알림, 오버레이, 로딩.

| 컴포넌트 | 출처 | GMod 기반 클래스 | 설명 |
|---------|------|----------------|------|
| **Alert** | MUI Feedback | Paper 기반 | 메시지 박스. `severity`(error/warning/info/success), `variant`(filled/outlined/standard) |
| **Progress** | MUI Feedback | DPanel | LinearProgress + CircularProgress. `value`, `variant`(determinate/indeterminate/buffer) |
| **Dialog** | MUI Feedback | DFrame 기반 | 모달 대화상자. DialogTitle/Content/Actions 서브컴포넌트, `maxWidth`, `fullScreen` |
| **Snackbar** | MUI Feedback | DPanel (애니메이션) | 일시적 알림. `autoHideDuration`, `anchorOrigin`, `action` |
| **Backdrop** | MUI Feedback | DPanel (반투명) | 모달 뒤 어두운 오버레이. `invisible` |
| **BubbleContainer** | GMod DBubbleContainer | DBubbleContainer | 말풍선 팝업 컨테이너 (채팅 UI용) |
| **NotificationStack** | GMod DNotify | DNotify | 코너에 쌓이는 타이머 알림 목록 |

---

## Phase 8 — Navigation (네비게이션 컴포넌트)

> 화면 전환 및 탐색. 가장 복잡한 컴포넌트들.

| 컴포넌트 | 출처 | GMod 기반 클래스 | 설명 |
|---------|------|----------------|------|
| **Tabs** | MUI Navigation | DPanel | 탭 전환. Tab/TabPanel 서브컴포넌트, `variant`(standard/scrollable/fullWidth) |
| **Menu** | MUI Navigation | DMenu 기반 | 컨텍스트/드롭다운 메뉴. MenuItem/MenuList, `dense` |
| **Drawer** | MUI Navigation | DPanel (슬라이드) | 측면 슬라이드 패널. `anchor`(left/right/top/bottom), `variant`(temporary/persistent/permanent) |
| **Breadcrumbs** | MUI Navigation | DPanel | 경로 탐색. `separator`, `maxItems` |
| **Pagination** | MUI Navigation | DPanel | 페이지 컨트롤. `count`, `shape`(circular/rounded), `variant`(outlined/text) |
| **Bottom Navigation** | MUI Navigation | DPanel | 하단 탭 바. BottomNavigationAction 서브컴포넌트, `showLabels` |
| **Stepper** | MUI Navigation | DPanel | 단계 진행 UI. Step/StepLabel/StepContent 서브컴포넌트, `orientation` |
| **Speed Dial** | MUI Navigation | DPanel (애니메이션) | 플로팅 다중 액션 버튼. SpeedDialAction, `direction`(up/down/left/right) |
| **Link** | MUI Navigation | DLabel | 클릭 가능 텍스트 링크. `color`, `underline`(always/hover/none) |
| **MenuBar** | GMod DMenuBar | DMenuBar | 상단 메뉴 바 (File/Edit/View 패턴). AppBar와 별개 |
| **ColumnNav** | GMod DColumnSheet | DColumnSheet | 측면 탭 네비게이션 레이아웃 |

---

## Phase 9 — Advanced & Game-Specific (고급 / GMod 전용)

> 특수한 용도의 레이아웃 컴포넌트 및 GMod 게임 엔진 전용 컴포넌트.

| 컴포넌트 | 출처 | GMod 기반 클래스 | 설명 |
|---------|------|----------------|------|
| **Timeline** | MUI Layout | DPanel | 시간순 이벤트 표시. TimelineItem/Separator/Dot/Content 서브컴포넌트 |
| **ModelViewer** | GMod DModelPanel | DModelPanel | 3D 모델 실시간 렌더링 패널 |
| **ModelImage** | GMod ModelImage | ModelImage | 3D 모델을 정적 이미지로 렌더링 |
| **SpawnIcon** | GMod SpawnIcon | SpawnIcon | 게임 엔티티/무기 스폰 아이콘 표시 |
| **FileBrowser** | GMod DFileBrowser | DFileBrowser | 파일/디렉토리 트리 브라우저 |
| **WebView** | GMod DHTML | DHTML | 임베디드 HTML/Chromium 패널. 로딩 인디케이터 통합 |
| **SplitPane** | GMod DVerticalDivider | DVerticalDivider | 드래그로 크기 조절 가능한 분할 패널 |
| **PropertyGrid** | GMod DProperties | DProperties | 키-값 테이블 형태의 프로퍼티 편집기 |

---

## 전체 현황 요약

| Phase | 카테고리 | 컴포넌트 수 | 누적 |
|-------|---------|-----------|------|
| 진행 중 | — | 2 (Frame, Button) | **2 / 75** |
| Phase 1 | Layout Primitives | 10 | 12 / 75 |
| Phase 2 | Base Display | 6 | 18 / 75 |
| Phase 3 | Simple Inputs | 7 | 25 / 75 |
| Phase 4 | Complex Inputs | 12 | 37 / 75 |
| Phase 5 | Data Display | 9 | 46 / 75 |
| Phase 6 | Surfaces | 3 | 49 / 75 |
| Phase 7 | Feedback | 7 | 56 / 75 |
| Phase 8 | Navigation | 11 | 67 / 75 |
| Phase 9 | Advanced / GMod | 8 | **75 / 75** |

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
    draw.RoundedBox(Starlight.theme.shape.borderRadius, 0, 0, w, h, palette.main)
end

-- 4. VGUI 등록
vgui.Register("Starlight_MyComponent", Starlight.MyComponent, "DPanel")
```

신규 컴포넌트 파일은 반드시 `lua/autorun/starlight_init.lua`에 `AddCSLuaFile` + `include` 추가 (의존성 순서 준수).

### 주요 규칙

- VGUI 내장 메서드(`SetSize`, `SetText` 등)와 이름 충돌 시 `Set[Prop]_SL` 또는 의미적으로 구분된 이름 사용 (예: `SetButtonSize`)
- Alpha 색상은 반드시 `opacityColor(r, g, b, 0~1)` 패턴 사용 — `Color()` 직접 분수 전달 금지
- `theme.spacing(n)` = `n * 8px`
- elevation shadow는 `theme.shadows[0..24]` 참조
- 서브컴포넌트(CardHeader 등)도 별도 `vgui.Register` 등록
