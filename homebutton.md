# Home Button Implementation Plan

## Overview
Transform the existing home button in `BottomButtons.qml` into an interactive button that opens an animated popup menu containing apps like Settings, Media, Climate, and other vehicle controls.

## Current State Analysis
- Home button exists at `qml/bottomBar/BottomButtons.qml:21-29`
- Currently a static image with no functionality
- Located centrally in the bottom bar
- Project uses QML/QtQuick 2.15 for UI
- Similar animation patterns exist in the music bar component

## Design Goals
1. **Smooth animations** - Modern, Tesla-like feel with fluid transitions
2. **App grid layout** - Display multiple app icons in an organized grid
3. **Dismiss on outside click** - Close popup when clicking outside
4. **Visual feedback** - Button press states and hover effects
5. **Scalable structure** - Easy to add new apps later

## Implementation Plan

### Phase 1: Create Home Popup Component
**File:** `qml/HomePopup.qml` (new file)

**Structure:**
```
HomePopup (Item)
├── Popup overlay (Rectangle - semi-transparent background)
├── Main popup container (Rectangle)
│   ├── Header section
│   │   ├── Title text ("Apps")
│   │   └── Close button (X icon)
│   └── Apps grid (GridView or Flow)
│       ├── Settings app tile
│       ├── Climate app tile
│       ├── Media app tile
│       ├── Phone app tile
│       ├── Navigation app tile
│       └── Vehicle Controls app tile
```

**Features:**
- Semi-transparent dark overlay behind popup
- Rounded rectangle popup (300-400px width, auto height)
- Positioned above the home button
- App tiles with icons, labels, and hover states

### Phase 2: Animation System
**Animations to implement:**

1. **Popup Entry Animation:**
   - Scale from 0.7 to 1.0 (spring effect)
   - Opacity from 0 to 1
   - Y-position slide up
   - Duration: 250-300ms
   - Easing: OutBack or OutCubic

2. **Popup Exit Animation:**
   - Scale from 1.0 to 0.8
   - Opacity from 1 to 0
   - Y-position slide down slightly
   - Duration: 200ms
   - Easing: InQuad

3. **App Tile Hover:**
   - Scale up to 1.05
   - Subtle shadow or glow effect
   - Duration: 150ms

4. **Staggered Entry (optional enhancement):**
   - Each app tile animates in with slight delay
   - Creates cascading effect

### Phase 3: Integrate with BottomButtons
**Modifications to:** `qml/bottomBar/BottomButtons.qml`

**Changes needed:**
1. Add MouseArea to homebutton image
2. Add state management property: `property bool homePopupVisible: false`
3. Instantiate HomePopup component
4. Connect click handler to toggle popup
5. Pass close signal from popup back to parent

**Code structure:**
```qml
Image {
    id: homebutton
    // existing properties...
    
    MouseArea {
        anchors.fill: parent
        onClicked: homePopupVisible = !homePopupVisible
    }
}

HomePopup {
    id: homePopup
    visible: homePopupVisible
    anchors.bottom: homebutton.top
    anchors.bottomMargin: 10
    anchors.horizontalCenter: homebutton.horizontalCenter
    onCloseRequested: homePopupVisible = false
}
```

### Phase 4: App Icons and Resources
**Required icons** (create or source):
- settings.png (gear icon)
- climate.png (temperature/AC icon)
- media.png (music note icon)
- phone.png (already exists: phone-call.png)
- navigation.png (map pin icon)
- car-controls.png (car icon, already exists: car-rear.png)

**Add to resources:**
- Update CMakeLists.txt or .qrc file to include new icons
- Place icons in `resources/` directory
- Use consistent size (64x64 or 128x128 px)

### Phase 5: App Tile Component (Reusable)
**File:** `qml/AppTile.qml` (new file)

**Purpose:** Reusable component for each app in the grid

**Properties:**
- `appName` (string) - Display name
- `iconSource` (url) - Path to icon image
- `appId` (string) - Unique identifier
- Signal: `onAppClicked(string appId)`

**Features:**
- Rounded rectangle background
- Icon centered at top
- Label below icon
- Hover state with scale animation
- Click handling

### Phase 6: Connect to Backend (Future)
**Placeholder for app actions:**

For now, apps will show console logs or basic alerts:
```qml
onAppClicked: {
    console.log("App clicked:", appId)
    // Future: Navigate to app view
    // Future: Open settings panel
    // Future: Show climate controls
}
```

**Later integration:**
- Create navigation system to switch main view
- Connect Settings to vehicle parameters
- Link Media to existing MusicController
- Connect Climate to existing Temprature_Controls

## Technical Specifications

### Popup Dimensions
- **Width:** 380px
- **Height:** Auto (based on content, ~320px)
- **Position:** Centered above home button with 10px margin
- **Border radius:** 15px
- **Background:** #2a2a2a with 95% opacity

### App Grid Layout
- **Columns:** 3
- **Rows:** 2 (initially, expandable)
- **Tile size:** 100x100px
- **Spacing:** 15px
- **Padding:** 20px

### Color Scheme (match existing UI)
- **Popup background:** #2a2a2a
- **App tile background:** #3a3a3a
- **App tile hover:** #4a4a4a
- **Text color:** #ffffff
- **Icon tint:** None (full color icons) or #C7C5C5

### Z-Index Management
- HomePopup z-index: 1000 (above all other UI)
- Overlay z-index: 999
- App tiles z-index: inherit from popup

## File Structure Summary

```
TeslaMCU/
├── qml/
│   ├── bottomBar/
│   │   └── BottomButtons.qml (MODIFY)
│   ├── components/ (NEW FOLDER)
│   │   ├── HomePopup.qml (NEW)
│   │   └── AppTile.qml (NEW)
│   └── Main.qml (minor import update)
├── resources/
│   ├── settings.png (NEW)
│   ├── climate.png (NEW)
│   ├── media.png (NEW)
│   └── navigation.png (NEW)
└── CMakeLists.txt (UPDATE if needed)
```

## Implementation Steps (Ordered)

1. **Create AppTile.qml** - Build reusable component first
2. **Create HomePopup.qml** - Build main popup with grid
3. **Add icon resources** - Create or source required icons
4. **Modify BottomButtons.qml** - Add MouseArea and integrate popup
5. **Test animations** - Fine-tune timing and easing
6. **Add app click handlers** - Console logs for testing
7. **Polish hover effects** - Ensure smooth interactions
8. **Test edge cases** - Multiple rapid clicks, outside click dismissal

## Testing Checklist

- [ ] Home button opens popup on click
- [ ] Popup animates smoothly (entry)
- [ ] Popup closes on outside click
- [ ] Popup closes on close button click
- [ ] Popup closes when clicking home button again
- [ ] App tiles show hover effect
- [ ] App clicks are registered (console logs)
- [ ] No visual glitches or flicker
- [ ] Z-index correct (popup above all content)
- [ ] Popup positioned correctly on different screen sizes
- [ ] Animations perform well (no lag)

## Future Enhancements

### Short-term
- Add tooltips on hover
- Quick access toggles (e.g., quick lock/unlock)
- Recent apps section

### Medium-term
- Navigation to full app views
- Settings panel implementation
- Climate control integration
- Notification badges on app icons

### Long-term
- Customizable app grid (drag & drop)
- Third-party app support
- Search functionality
- App folders/categories

## Dependencies

**QML Imports needed:**
```qml
import QtQuick 2.15
import QtQuick.Layouts 1.15  // For GridLayout (alternative to Flow)
```

**No C++ backend changes required initially** - Pure QML implementation

## Notes

- Keep animations lightweight for performance
- Follow existing code style in project (indentation, naming)
- Use existing gradient/color schemes for consistency
- Test on build system before committing
- Consider dark mode compatibility (already dark theme)
- Icons should work at different DPI scales

## Success Criteria

✅ Home button responds to clicks
✅ Popup appears with smooth animation
✅ At least 6 app tiles visible and clickable
✅ Clean dismissal behavior
✅ No performance issues
✅ Matches Tesla UI aesthetic
✅ Code is maintainable and well-commented

---

**Estimated Implementation Time:** 3-4 hours
**Complexity Level:** Medium
**Risk Level:** Low (isolated component, no backend changes)
