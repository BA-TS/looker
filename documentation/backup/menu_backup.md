<h1>HTML - Menu Widget <img style="color: #ffffff;float: right;height: 40px;" src="https://www.toolstation.com/img/toolstation.svg"></h1>

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

- Create Menu Widgets for:
  -   [x]   Menu
  -   [x]   Sub Menu
  -   [x]   Tertiary Menu
- Documentation

---

# Menu

This HTML element is to be used only in main menu dashboards. This will ensure no spurious links from the uppermost level.

<b> There are no actions required to use this HTML element.</b>

<div style="padding: 20px 0 20px 0; border-radius: 5px; background: #ffe200; height: 80px;">
   <div style="background: #004f9f; height: 40px; width:100%">
      <a href="">
      <img style="color: #ffffff; float: left; height: 40px" src="https://www.toolstation.com/img/toolstation.svg"/>
      </a>
      <nav style="font-size: 18px;">
         <span style="color: #000000;">
         </span>
         <a style="color: #efefef; padding: 0 20px; float: right; line-height: 40px; font-weight: bold; text-decoration: none;"><span style="color: #ffffff;">Main Menu</span></a>
      </nav>
   </div>
</div>

---

# Sub Menu

This HTML element is to be used at all sub menu dashboards. In order to use this:
1. Submenu Name - find and replace '{submenu_name}' with current Dashboard ID e.g. 'Commercial Menu'

<div style="padding:20px 0 20px 0;border-radius:5px;background:#ffe200;height: 80px;">
   <div style="background:#004f9f;height: 40px;width:100%;">
      <a href="https://tpdev.cloud.looker.com/dashboards-next/63" rel="noopener noreferrer">
      <img style="color: #ffffff;float: left;height: 40px;" src="https://www.toolstation.com/img/toolstation.svg">
      </a>
      <nav style="font-size: 18px;">
         <span style="color: #000000;">
         <a style="color: #ffffff;padding:0 20px;float: right;line-height: 40px;font-weight: regular;" href="https://tpdev.cloud.looker.com/dashboards-next/63" rel="noopener noreferrer">Back to Main Menu</a>
         </span>
         <a style="color: #efefef;padding:0 20px;float: right;line-height: 40px;font-weight: bold;text-decoration: none;" rel="noopener noreferrer"><span style="color: #ffffff;">{submenu_name}</span></a>
      </nav>
   </div>
</div>

---

# Tertiary Menu

This HTML element is to be used at all 'end' dashboards (i.e. dashboards with no downward links). In order to use this:
1. Dashboard Name - find and replace '{dashboard_name}' with current Dashboard Name e.g. 'Daily Sales Report'
2. Submenu URL - find and replace '{submenu_id}' with sub menu Dashboard ID e.g. '64' (Commercial)
3. Submenu Name - find and replace '{submenu_name}' with sub menu Dashboard Name e.g. 'Commercial Menu'
4. Menu URL - find and replace '{menu_id}' with main menu Dashboard ID e.g. '63' (Main Menu)
5. Menu Name - find and replace '{menu_name}' with main menu Dashboard ID e.g. 'Commercial Menu'

<div style="padding:20px 0 20px 0;border-radius:5px;background:#ffe200;height: 80px;">
   <div style="background:#004f9f;height: 40px;width:100%;">
      <a href="https://tpdev.cloud.looker.com/dashboards-next/63" rel="noopener noreferrer">
      <img style="color: #ffffff;float: left;height: 40px;" src="https://www.toolstation.com/img/toolstation.svg">
      </a>
      <nav style="font-size: 18px;">
         <span style="color: #000000;">
         <a style="color: #ffffff;padding:0 20px;float: right;line-height: 40px;font-weight: regular;" href="https://tpdev.cloud.looker.com/dashboards-next/{menu_id}" rel="noopener noreferrer">Back to {menu_name}</a>
         <a style="color: #ffffff;padding:0 20px;float: right;line-height: 40px;font-weight: regular;" href="https://tpdev.cloud.looker.com/dashboards-next/{submenu_id}" rel="noopener noreferrer">Back to {submenu_name}</a>
         </span>
         <a style="color: #efefef;padding:0 20px;float: right;line-height: 40px;font-weight: bold;text-decoration: none;" rel="noopener noreferrer"><span style="color: #ffffff;">{dashboard_name}</span></a>
      </nav>
   </div>
</div>
