# github-link.nvim

Clipped github link for select line in the currently open file in nvim.

## Requirements

* git

## Installation

### lazy.nvim

```lua
{
  "candy12t/github-link.nvim",
  config = function()
    require("github-link").setup()
  end,
},
```

## Setup

```lua
require("github-link").setup()
```

## Usage

Select line in visual mode and execute the command.

* `:GetCurrentCommitLink`
  * generate `https://github.com/OWNER/REPO/blob/COMMIT_HASH/PATH/TO/FILE#L1-L10`
* `:GetCurrentBranchLink`
  * generate `https://github.com/OWNER/REPO/blob/BRANCH/PATH/TO/FILE#L1-L10`

## License

MIT License

## Author

candy12t
