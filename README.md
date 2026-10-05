<div align="center">
  <img src="https://github.com/hans-chrstn/neovim-config/blob/main/main.png" alt="Dashboard Screenshot"/>
</div>

<br>

## Keymaps

The leader key is **`<Space>`**.

### General Navigation & Window Management

| Key          | Mode   | Description               |
| :----------- | :----- | :------------------------ |
| `<C-k>`      | Normal | Navigate window up        |
| `<C-j>`      | Normal | Navigate window down      |
| `<C-h>`      | Normal | Navigate window left      |
| `<C-l>`      | Normal | Navigate window right     |
| `<leader>wv` | Normal | Split window vertically   |
| `<leader>ws` | Normal | Split window horizontally |
| `<leader>wc` | Normal | Close current window      |
| `<leader>wo` | Normal | Close other windows       |
| `<leader>w=` | Normal | Equalize window sizes     |

### Buffers (lualine.nvim)

| Key          | Mode   | Description                  |
| :----------- | :----- | :--------------------------- |
| `[b`         | Normal | Previous buffer              |
| `]b`         | Normal | Next buffer                  |
| `<leader>bc` | Normal | Close current buffer         |
| `<leader>bP` | Normal | Pick a buffer                |
| `<leader>be` | Normal | Expand/collapse buffer names |

### Neovim Tab Pages

| Key                  | Mode   | Description            |
| :------------------- | :----- | :--------------------- |
| `<leader><Tab><Tab>` | Normal | Open a new tab page    |
| `<leader><Tab>n`     | Normal | Next tab page          |
| `<leader><Tab>p`     | Normal | Previous tab page      |
| `<leader><Tab>c`     | Normal | Close current tab page |
| `<leader><Tab>o`     | Normal | Close other tab pages  |

### LSP & Diagnostics

| Key           | Mode           | Description                                 |
| :------------ | :------------- | :------------------------------------------ |
| `<leader>dd`  | Normal         | Open diagnostics float                      |
| `<leader>ch`  | Normal         | Check config dependencies                   |
| `<leader>ca`  | Normal, Visual | Code Action                                 |
| `<leader>cr`  | Normal         | Rename Symbol                               |
| `gd`          | Normal         | Go to Definition                            |
| `gD`          | Normal         | Go to Declaration                           |
| `gi`          | Normal         | Go to Implementation                        |
| `gy`          | Normal         | Go to Type Definition                       |
| `gr`          | Normal         | Find References                             |
| `K`           | Normal         | Hover Documentation                         |
| `gK`          | Normal         | Signature Help                              |
| `<leader>cd`  | Normal         | Line Diagnostics                            |
| `<leader>cpd` | Normal         | Preview Definition                          |
| `<leader>cpD` | Normal         | Preview Declaration                         |
| `<leader>cpt` | Normal         | Preview Type Definition                     |
| `<leader>cpi` | Normal         | Preview Implementation                      |
| `<leader>cpr` | Normal         | Preview References                          |
| `<leader>cpc` | Normal         | Close Preview Windows                       |
| `[d`          | Normal         | Previous Diagnostic                         |
| `]d`          | Normal         | Next Diagnostic                             |
| `<leader>th`  | Normal         | Toggle Inlay Hints                          |
| `<leader>xx`  | Normal         | Toggle Diagnostics (Trouble)                |
| `<leader>xX`  | Normal         | Toggle Buffer Diagnostics (Trouble)         |
| `<leader>cs`  | Normal         | Toggle Symbols (Trouble)                    |
| `<leader>cl`  | Normal         | Toggle LSP Definitions/References (Trouble) |
| `<leader>xL`  | Normal         | Toggle Location List (Trouble)              |
| `<leader>xQ`  | Normal         | Toggle Quickfix List (Trouble)              |
| `<leader>xq`  | Normal         | Open native quickfix (nvim-bqf)             |
| `<leader>xt`  | Normal         | Toggle Todo (Trouble)                       |
| `<leader>xT`  | Normal         | Toggle Todo/Fix/Fixme (Trouble)             |

### Debugging (nvim-dap)

| Key                   | Mode   | Description                 |
| :-------------------- | :----- | :-------------------------- |
| `<F5>` / `<leader>dc` | Normal | Start or continue debugging |
| `<F10>`               | Normal | Step over                   |
| `<F11>`               | Normal | Step into                   |
| `<F12>`               | Normal | Step out                    |
| `<leader>db`          | Normal | Toggle breakpoint           |
| `<leader>dB`          | Normal | Set conditional breakpoint  |
| `<leader>dl`          | Normal | Set log point               |
| `<leader>dr`          | Normal | Toggle debug REPL           |
| `<leader>dt`          | Normal | Terminate debugging         |

### Editing & Text

| Key          | Mode           | Description                          |
| :----------- | :------------- | :----------------------------------- |
| `<leader>cf` | Normal, Visual | Format Buffer or Selection (conform) |
| `<leader>cg` | Normal         | Generate annotation (Neogen)         |
| `<leader>uf` | Normal         | Toggle Format Globally (conform)     |
| `<leader>uF` | Normal         | Toggle Format Locally (conform)      |
| `gc`         | Normal, Visual | Comment with an operator             |
| `gcc`        | Normal         | Comment the current line             |
| `]t`         | Normal         | Jump to Next Todo Comment            |
| `[t`         | Normal         | Jump to Previous Todo Comment        |

#### Treesitter Text Objects

| Key         | Mode                     | Description                 |
| :---------- | :----------------------- | :-------------------------- |
| `s`         | Normal, Visual, Operator | Flash jump                  |
| `<C-space>` | Normal, Visual, Operator | Flash Treesitter selection  |
| `<bs>`      | Flash selection          | Shrink syntax selection     |
| `aa` / `ia` | Operator, Visual         | Around / Inside parameter   |
| `af` / `if` | Operator, Visual         | Around / Inside function    |
| `ac` / `ic` | Operator, Visual         | Around / Inside class       |
| `ai` / `ii` | Operator, Visual         | Around / Inside conditional |
| `al` / `il` | Operator, Visual         | Around / Inside loop        |
| `at`        | Operator, Visual         | Around comment              |

#### Treesitter Movement

| Key         | Mode   | Description                        |
| :---------- | :----- | :--------------------------------- |
| `]m` / `[m` | Normal | Go to next/previous function start |
| `]M` / `[M` | Normal | Go to next/previous function end   |
| `]]` / `[[` | Normal | Go to next/previous class start    |
| `][` / `[]` | Normal | Go to next/previous class end      |

#### Treesitter Swap

| Key         | Mode   | Description             |
| :---------- | :----- | :---------------------- |
| `<leader>a` | Normal | Swap next parameter     |
| `<leader>A` | Normal | Swap previous parameter |

#### Folding (Treesitter)

| Key         | Mode   | Description                   |
| :---------- | :----- | :---------------------------- |
| `za`        | Normal | Toggle the fold under cursor  |
| `zo` / `zc` | Normal | Open / close the current fold |
| `zR` / `zM` | Normal | Open / close all folds        |
| `zj` / `zk` | Normal | Jump to next / previous fold  |

#### Useful built-in motions

| Key               | Mode   | Description                        |
| :---------------- | :----- | :--------------------------------- |
| `<C-o>` / `<C-i>` | Normal | Move backward / forward in jumps   |
| `g;` / `g,`       | Normal | Move backward / forward in changes |
| `%`               | Normal | Jump to the matching pair          |
| `*` / `#`         | Normal | Search forward / backward for word |
| `zz`              | Normal | Center the current line            |
| `gv`              | Normal | Reselect the last visual selection |

#### nvim-surround

| Key      | Mode   | Description                          |
| :------- | :----- | :----------------------------------- |
| `ys`     | Normal | Add surround                         |
| `yss`    | Normal | Add surround to current line         |
| `yS`     | Normal | Add surround line                    |
| `ySS`    | Normal | Add surround to current line (alias) |
| `ds`     | Normal | Delete surround                      |
| `cs`     | Normal | Change surround                      |
| `cS`     | Normal | Change surround line                 |
| `S`      | Visual | Add surround to selection            |
| `gS`     | Visual | Add surround to selection line       |
| `<C-g>s` | Insert | Insert surround                      |
| `<C-g>S` | Insert | Insert surround line                 |

### Search (snacks.nvim)

| Key               | Mode   | Description             |
| :---------------- | :----- | :---------------------- |
| `<leader><space>` | Normal | Smart Find Files        |
| `<leader>:`       | Normal | Command History         |
| `<leader>b`       | Normal | Buffers                 |
| `<C-p>`           | Normal | Search Git Files        |
| `<leader>ff`      | Normal | Find Files              |
| `<leader>/`       | Normal | Live Grep               |
| `<leader>fb`      | Normal | Buffers                 |
| `<leader>fr`      | Normal | Resume Picker           |
| `<leader>sh`      | Normal | Help Pages              |
| `<leader>sa`      | Normal | Auto Commands           |
| `<leader>sb`      | Normal | Buffer Lines            |
| `<leader>sc`      | Normal | Command History         |
| `<leader>sC`      | Normal | Commands                |
| `<leader>sD`      | Normal | Workspace Diagnostics   |
| `<leader>sd`      | Normal | Buffer Diagnostics      |
| `<leader>sH`      | Normal | Search Highlight Groups |
| `<leader>sk`      | Normal | Keymaps                 |
| `<leader>sM`      | Normal | Man Pages               |
| `<leader>sm`      | Normal | Jump to Mark            |
| `<leader>sR`      | Normal | Resume Picker           |
| `<leader>st`      | Normal | Search Todo Comments    |
| `<leader>uC`      | Normal | Colorscheme Preview     |

### Breadcrumbs (dropbar.nvim)

| Key          | Mode   | Description                            |
| :----------- | :----- | :------------------------------------- |
| `<leader>ub` | Normal | Show or hide breadcrumbs               |
| `<leader>;`  | Normal | Pick a path or symbol breadcrumb       |
| `[;`         | Normal | Go to the start of the current context |
| `];`         | Normal | Select the next context                |

### Build & Run Tasks (overseer.nvim)

| Key          | Mode   | Description                  |
| :----------- | :----- | :--------------------------- |
| `<leader>or` | Normal | Select and run a task        |
| `<leader>ot` | Normal | Toggle the task list         |
| `<leader>oa` | Normal | Select an action for a task  |
| `<leader>ol` | Normal | Restart the most recent task |

### Terminal (snacks.nvim)

| Key          | Mode                 | Description                |
| :----------- | :------------------- | :------------------------- |
| `<leader>tt` | Normal               | Toggle Terminal (Split)    |
| `<Esc>`      | Terminal             | Enter Normal mode          |
| `q`          | Normal (in terminal) | Hide/Close terminal window |

### Completion (blink.cmp)

| Key                | Mode   | Description                       |
| :----------------- | :----- | :-------------------------------- |
| `<Tab>`            | Insert | Indent                            |
| `<S-Tab>`          | Insert | Unindent                          |
| `<CR>`             | Insert | Accept Completion                 |
| `<C-l>`            | Insert | Jump to Next Snippet Position     |
| `<C-h>`            | Insert | Jump to Previous Snippet Position |
| `<C-Space>`        | Insert | Show Completion/Documentation     |
| `<C-j>` / `<Down>` | Insert | Select Next Item                  |
| `<C-k>` / `<Up>`   | Insert | Select Previous Item              |
| `<C-u>`            | Insert | Scroll Documentation Up           |
| `<C-d>`            | Insert | Scroll Documentation Down         |

### Git (gitsigns.nvim & snacks.nvim)

| Key           | Mode           | Description                             |
| :------------ | :------------- | :-------------------------------------- |
| `<leader>ghb` | Normal         | Blame Line (gitsigns)                   |
| `<leader>ghd` | Normal         | Diff This (gitsigns)                    |
| `<leader>ghp` | Normal         | Preview Hunk (gitsigns)                 |
| `<leader>ghR` | Normal         | Reset Buffer (gitsigns)                 |
| `<leader>ghr` | Normal, Visual | Reset Hunk (gitsigns)                   |
| `<leader>ghs` | Normal, Visual | Stage Hunk (gitsigns)                   |
| `<leader>ghS` | Normal         | Stage Buffer (gitsigns)                 |
| `<leader>ghu` | Normal         | Stage/Unstage Hunk (gitsigns)           |
| `]h`          | Normal         | Next Hunk (gitsigns)                    |
| `[h`          | Normal         | Previous Hunk (gitsigns)                |
| `<leader>gtb` | Normal         | Toggle Line Blame (gitsigns)            |
| `<leader>gtd` | Normal         | Preview Deleted Lines Inline (gitsigns) |
| `<leader>gb`  | Normal         | Open in GitHub/GitLab (snacks)          |
| `<leader>gB`  | Normal         | Git Blame Line (snacks)                 |
| `<leader>gg`  | Normal         | LazyGit (snacks)                        |
| `<leader>gc`  | Normal         | Git Commits (snacks picker)             |
| `<leader>gs`  | Normal         | Git Status (snacks picker)              |
| `<leader>gxl` | Normal         | List merge conflicts in quickfix        |

| Key  | Mode           | Description               |
| :--- | :------------- | :------------------------ |
| `co` | Normal, Visual | Choose our changes        |
| `ct` | Normal, Visual | Choose their changes      |
| `cb` | Normal, Visual | Choose both changes       |
| `c0` | Normal, Visual | Choose neither change     |
| `]x` | Normal         | Jump to next conflict     |
| `[x` | Normal         | Jump to previous conflict |

### Plugin & Session Management

| Key          | Mode   | Description                                  |
| :----------- | :----- | :------------------------------------------- |
| `<leader>e`  | Normal | Open yazi at the current file                |
| `<leader>cw` | Normal | Open yazi at the current working directory   |
| `<c-up>`     | Normal | Resume the last yazi session                 |
| `<leader>qs` | Normal | Restore Session (persistence)                |
| `<leader>ql` | Normal | Restore Last Session (persistence)           |
| `<leader>qd` | Normal | Don't Save Current Session (persistence)     |
| `<leader>?`  | Normal | Show buffer-local keymaps (which-key)        |
| `<leader>z`  | Normal | Toggle Zen Mode (snacks)                     |
| `<leader>rn` | Normal | Rename File (LSP-aware) (snacks)             |
| `<leader>bd` | Normal | Delete Buffer (snacks)                       |
| `<leader>bD` | Normal | Delete All Buffers (snacks)                  |
| `<leader>bo` | Normal | Delete Other Buffers (snacks)                |
| `]r`         | Normal | Next Word Reference (snacks)                 |
| `[r`         | Normal | Previous Word Reference (snacks)             |
| `<leader>un` | Normal | Dismiss All Notifications (snacks)           |
| `<leader>Ct` | Normal | Toggle Discord Presence (cord, when enabled) |
| `<leader>Ci` | Normal | Toggle Idle Status (cord, when enabled)      |

#### Inside Yazi

| Key       | Description                                                   |
| :-------- | :------------------------------------------------------------ |
| `<Enter>` | Open file in the current window                               |
| `<C-v>`   | Open file in a vertical split                                 |
| `<C-x>`   | Open file in a horizontal split                               |
| `<C-t>`   | Open file in a new Neovim tab page                            |
| `<Tab>`   | Move Yazi to the file shown in the next visible Neovim window |
| `<C-o>`   | Choose a window and open the file there                       |
| `<C-y>`   | Copy selected relative paths                                  |
| `<C-q>`   | Send selected files to quickfix                               |
| `<C-\>`   | Change Neovim's working directory                             |
| `<F1>`    | Show Yazi keymap help                                         |
