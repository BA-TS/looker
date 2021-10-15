<h1>HTML - Widget <img style="color: #ffffff;float: right;height: 40px;" src="https://www.toolstation.com/img/toolstation.svg"></h1>

This documentation file contains the core 'how-to' for including and editing the Menu Widgets housed within the Looker dashboards. To use any of the below, please follow the following steps:
1. Press  and navigate to 'Edit Dashboard' (or press Ctrl + Shift + E)
2. Press 'Add Tile'
3. From the dropdown, select 'Text'
4. Copy-Paste the relevant menu HTML below into the 'Body'
5. Complete 'in order to use' actions
6. Press 'Save'
7. Resize widget to desired size

### NOTE: In order to access the HTML, please 'edit' this document. ###

---

# Status

- Create Widgets for:
  -   [x]   Menu's
- Documentation

---

# Widget

This HTML element is to be used in both main menu and sub menu dashboards. This widget allows for access to lower level menus / dashboards. In order to use this:
1. Target Name - find and replace '{target_name}' with target Dashboard Name e.g. "Daily Sales Report"
2. Target URL - find and replace '{target_id}' with target Dashboard ID e.g. '41'

<div style="cursor: pointer; display: block; width: 100%; height: 100%; border-radius: 20px; border: 3px solid black; background-color: #CAEAD0" >
   <a href="https://tpdev.cloud.looker.com/dashboards-next/{target_id}" style="color: black; text-decoration: none">
      <div style="line-height: 250px; font-size: 25px; text-align: center; vertical-align: center;">{target_name}</div>
   </a>
</div>

---

## Colour

If you want to change the color of the widget, change the HEX color after 'background-color'. For random colors, use:
- Pastel: [https://mdigi.tools/random-pastel-color/](https://mdigi.tools/random-pastel-color/)
- Material: [https://mdigi.tools/random-material-color/](https://mdigi.tools/random-material-color/)
- Bright: [https://mdigi.tools/random-bright-color/](https://mdigi.tools/random-bright-color/)
- Dull: [https://mdigi.tools/random-dull-color/](https://mdigi.tools/random-dull-color/)
- Gray: [https://mdigi.tools/random-gray-color/](https://mdigi.tools/random-gray-color/)
- Any: [https://mdigi.tools/random-color/](https://mdigi.tools/random-color/)
