# Contents
* [Base Page Widget](#base-page-widget)
* [Navigation Bar Page Widget](#navigation-bar-page-widget)
* [Tab Bar Page Widget](#tab-bar-page-widget)

# Base Page Widget
This is the base page widget. It include the base util functions and provide page life cycle events. 
Other page need to extend this base page widget.

### Page Life Cycle Events
Provide the whole page life cycle events like android view page life cycle event. 
Can be overridden to implement the action.

> onCreate, onResume, onPause, onBackground, onForeground, onDestroy

|  Scenario   | Trigger Flow  |
|  ----  | ----  |
| Page A create  | onCreate(A) -> onResume(A) |
| Page A go to Page B  | onCreate(B) -> onResume(B) -> onPause(A) |
| Page B back to Page A  | onResume(A) -> onPause(B) -> onDestroy(B) |
| Page A go to Page B, Page A destroy  | onPause(A) -> onCreate(B) -> onResume(B) -> onDestroy(A) |
| App go to background  | onBackground -> onPause|
| App back to  foreground  | onForeground -> onResume|

### Interfaces
| Name | Params | Description |
| ---- | ---- | ---- |
| getPageName | nil | get the page name you define |
| buildWidget | BuildContext context | build the widgets of the page |

# Navigation Bar Page Widget
This is the navigation bar base page widget with the common navigation bar, which extend from BasePageWidget.

### Interfaces
| Name | Params | Description |
| ---- | ---- | ---- |
| getTitle | nil | get the title of the page, which shown in the navigation bar |
| buildContentWidget | BuildContext context | build the widgets of the page content |

# Tab Bar Page Widget
This is the tab bar base page widget with the common bottom tab bar, which extend from BasePageWidget.

### Attributes
| Name | type | default | Description |
| ---- | ---- | ---- | ---- |
| fixedColor | Color | Colors.black | the fixed(highlight) color of the tab bar |
| selectedFontSize | double | 15.0 | the font size of text in the selected tab item |

### Interfaces
| Name | Params | Description |
| ---- | ---- | ---- |
| List getPageList | nil | BottomNavigationBarItem corresponding to page content |
| List\<BottomNavigationBarItem> getMenuList | nil | get the BottomNavigationBarItem list  |
