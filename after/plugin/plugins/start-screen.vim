let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'p1': '~/Documents/codebase/CAS/cas-sec-pam' },
            \ { 'p2': '~/Documents/codebase/CAS/cas-sec-apm' },
            \ { 'p3': '~/Documents/codebase/CAS/cas-sec-alm' },
            \ { 'p4': '~/Documents/codebase/CAS/cas-sec-caa' },
            \ { 'p5': '~/Documents/codebase/CAS/dal-data-interface' },
            \ { 'p6': '~/Documents/codebase/CAS/dal-graphql' },
            \ { 'p7': '~/Documents/codebase/CAS/cas-sec-neo4j-lib' },
            \ { 'p8': '~/Documents/codebase/CAS/cas-sec-cc-mfa' },
            \ { 'p9': '~/Documents/codebase/CAS/dal-graphql' },
			\ { 'p10': '~/Documents/codebase/CAS/cas-sec-compliance' },
            \ { 'i': '~/.config/nvim/init.lua' },
            \ { 'z': '~/.zshrc' }
            \ ]

let g:startify_session_delete_buffers = 1
let g:startify_session_autoload = 1
let g:startify_change_to_vcs_root = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 0

let g:startify_custom_header = [
            \ '         __      __       .__                                __________.__       .__          ___.   .__     ',
            \ '/  \    /  \ ____ |  |   ____  ____   _____   ____   \______   \__| _____|  |__ _____ \_ |__ |  |__  ',
            \ '\   \/\/   // __ \|  | _/ ___\/  _ \ /     \_/ __ \   |       _/  |/  ___/  |  \\__  \ | __ \|  |  \ ',
            \ '\        /\  ___/|  |_\  \__(  <_> )  Y Y  \  ___/   |    |   \  |\___ \|   Y  \/ __ \| \_\ \   Y  \',
            \ ' \__/\  /  \___  >____/\___  >____/|__|_|  /\___  >  |____|_  /__/____  >___|  (____  /___  /___|  /',
            \  '     \/       \/          \/            \/     \/          \/        \/     \/     \/    \/     \/ '
        \]
