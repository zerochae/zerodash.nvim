# zerodash.nvim

nvim dashboard manager plugin

## 🖥️ Demo

![스크린샷 2024-04-28 20 37 15](https://github.com/zerochae/zerodash.nvim/assets/84373490/8ab01746-e8fe-4188-9318-16a11a80d146)

## ✨ Features

## 📦 Installation

```lua
-- lazy.nvim
  {
    "zerochae/zerodash.nvim",
    event = "BufEnter",
    config = function()
      require("zerodash").setup()end,
  },
```

## ⚙️ Configuration

```lua
 {
  header = {
    [[     ┏┓╻   ╻ ╻   ╻   ┏┳┓     ]],
    [[     ┃┗┫   ┃┏┛   ┃   ┃┃┃     ]],
    [[     ╹ ╹   ┗┛    ╹   ╹ ╹     ]],
  },
  header_cmd = {},
  buttons = {},
  highlight = {
    header = {
      fg = "#519fdf",
      bg = "none",
    },

    buttons = {
      fg = "#8fc6f4",
      bg = "none",
    },
  },
}
```
