# -*- mode: sh; mode: sh-bash -*-
## Basic settings

bleopt input_encoding=UTF-8
bleopt pager=less
bleopt editor=vim
#bleopt vbell_default_message=' Wuff, -- Wuff!! '
#bleopt vbell_duration=2000
#bleopt vbell_align=right
#ble-face vbell='reverse'
#ble-face vbell_erase='bg=252'
#ble-face vbell_flash='fg=green,reverse'

##-----------------------------------------------------------------------------
## Line editor settings

bleopt edit_bell=abell
#bleopt history_lazyload=1
bleopt delete_selection_mode=1
bleopt indent_offset=4
bleopt indent_tabs=1
bleopt undo_point=beg
bleopt edit_forced_textmap=
bleopt edit_line_type=graphical
bleopt edit_magic_expand=history:sabbrev:alias # Expand aliases, etc.
#bleopt edit_magic_opts= # Add a space after auto expansion (enabled)


## This option specifies the expansions performed on accept-line by a
## colon-separated list.  The expansion is performed in a similar way as Bash's
## history expansion.  When "sabbrev", "alias", "autocd", "history", or
## "<name>" as explained in the description of "bleopt edit_magic_expand" is
## specified, the corresponding expansion is attempted on the command line.
## When "verify" is specified, if sabbrev, alias, or autocd expansions changed
## the command line, the execution of the command line is canceled so the user
## can examine or continue to edit the expanded line.  The history expansion
## can be controlled by "shopt -s histverify" in a similar manner.  When
## "verify-syntax" is specified and any expansions change the command string, a
## syntax check is performed.  The command execution is canceled when the
## command string is not syntactically complete.  When "history-line" is
## specified, the history expansion replaces the command line instead of just
## printing the expansion result.  The default value of this option is empty.

#bleopt edit_magic_accept=sabbrev
bleopt info_display=top
#bleopt prompt_ps1_final=
#bleopt prompt_ps1_transient=trim
bleopt prompt_rps1='\w'
#bleopt prompt_rps1_final=
#bleopt prompt_rps1_transient=''
#bleopt prompt_xterm_title=
#bleopt prompt_screen_title=
#bleopt prompt_term_status=
bleopt prompt_status_line=
bleopt prompt_status_align=left
ble-face prompt_status_line='fg=231,bg=240'
# bleopt prompt_eol_mark=$'\e[94m[ble: EOF]\e[m'
bleopt prompt_ruler=            # no ruler (default)
#bleopt prompt_ruler=empty-line  # empty line
#bleopt prompt_ruler=$'\e[94m-'  # blue line


## "prompt_command_changes_layout" specifies whether the commands called from
## the blehook PRECMD or the variable PROMPT_COMMAND output texts to the
## terminal and changes the layout.  When a non-empty value is specified,
## ble.sh resets the layout before running the hooks PRECMD and PROMPT_COMMAND
## and restores the layout after running the hooks.  When a empty value is
## specified, ble.sh assumes that these hooks do not output texts to the
## terminal and do not changes the cursor positions and skip the special
## treatment.

#bleopt prompt_command_changes_layout=   # PRECMD/PROMPT_COMMAND not output
bleopt prompt_command_changes_layout=1  # PRECMD/PROMPT_COMMAND may output

#bleopt exec_restore_pipestatus=1  # restores PIPESTATUS (costly)
#bleopt edit_marker=$'\e[94m[ble: %s]\e[m'
#bleopt edit_marker_error=$'\e[91m[ble: %s]\e[m'
#bleopt exec_errexit_mark=$'\e[91m[ble: exit %d]\e[m'
#bleopt exec_elapsed_mark=$'\e[94m[ble: elapsed %s (CPU %s%%)]\e[m'
#bleopt exec_elapsed_enabled='usr+sys>=10000'
#bleopt exec_exit_mark=$'\e[94m[ble: exit]\e[m'
#bleopt allow_exit_with_jobs= # Don't allow exit with jobs
bleopt history_default_point=auto
bleopt history_share=1
bleopt history_erasedups_limit=-1000 # Efficient
bleopt accept_line_threshold=5 # How many unprocessed inputs required to enter multiline editing
bleopt line_limit_type=none
bleopt line_limit_length=10000
bleopt history_limit_length=1000

##-----------------------------------------------------------------------------
## Terminal state control

bleopt term_stty_restore= # If commands break terminal a lot, enable this
bleopt term_cursor_external=1 # Use DECSCUSR

bleopt term_modifyOtherKeys_external=auto
bleopt term_modifyOtherKeys_internal=auto

##-----------------------------------------------------------------------------
## Rendering options

bleopt tab_width=4
bleopt char_width_mode=auto
bleopt char_width_version=auto
bleopt emoji_width=
#bleopt emoji_version=13.1
#bleopt emoji_opts=ri # Dunno, don't care
bleopt grapheme_cluster= # kmscon not support
bleopt canvas_winch_action=redraw-here

##-----------------------------------------------------------------------------
## User input settings

bleopt default_keymap=vi
bleopt decode_isolated_esc=esc
bleopt decode_abort_char=28 # Press 'C-\' to abort input


## The following settings sets up the behavior for errors while user input
## decoding. "error_char" is the decoding error for the current character
## encoding. "error_cseq" indicates the unrecognized CSI sequences.
## "error_kseq" indicates the unbound key sequences. "abell" and "vbell" turn
## on/off the audible bells and visible bells on errors. If the variable is
## empty the bells are turned off, or otherwise turned on. "discard" controls
## if the chars/sequences will be discarded or processed in later stage. If a
## non-empty value is given, chars/sequences are discarded.

#bleopt decode_error_char_abell=
#bleopt decode_error_char_vbell=1
#bleopt decode_error_char_discard=
#bleopt decode_error_cseq_abell=
#bleopt decode_error_cseq_vbell=1
#bleopt decode_error_cseq_discard=1
#bleopt decode_error_kseq_abell=1
#bleopt decode_error_kseq_vbell=1
#bleopt decode_error_kseq_discard=1


bleopt decode_macro_limit=32 # Macro recursion max depth
bleopt term_bracketed_paste_mode=on # Ignore newlines with pasting

##-----------------------------------------------------------------------------
## Settings for completion

bleopt complete_auto_complete=1
bleopt complete_menu_complete=1
bleopt complete_menu_filter=1
bleopt complete_ambiguous=1
bleopt complete_contract_function_names=1
bleopt complete_allow_reduction=1
bleopt complete_requote_threshold=0
bleopt complete_auto_history=1
bleopt complete_auto_delay=0
ble-face auto_complete='fg=7,bg=238'
bleopt complete_auto_wordbreaks=$' \t\n/'
#bleopt complete_auto_complete_opts=
ble-face menu_filter_fixed='reverse'
ble-face menu_filter_input='fg=16,bg=229'
bleopt complete_auto_menu=50
bleopt complete_polling_cycle=50
bleopt complete_limit=20 # tab-completion
bleopt complete_limit_auto=20 # auto-completion
bleopt complete_limit_auto_menu=20 # auto-menu
bleopt complete_timeout_auto=100
bleopt complete_timeout_compvar=100
bleopt complete_menu_style=dense-nowrap
bleopt complete_skip_matched=1 # Erase text to the right after accepting completion
bleopt complete_menu_complete_opts=insert-selection
bleopt complete_menu_color=on
bleopt complete_menu_color_match=on
#bleopt menu_align_min=4
#bleopt menu_align_max=20
bleopt complete_menu_maxlines=1
#bleopt menu_align= # text before menu completion options
#bleopt menu_align_prefix='\e[1m%d:\e[m '
#bleopt menu_desc_prefix='\e[1m%d.\e[m '
#bleopt menu_linewise_prefix='\e[1;36m%d:\e[m '
#bleopt menu_dense_prefix='\e[1;32m>\e[m '
#bleopt menu_desc_multicolumn_width=65
ble-face menu_complete_match=bold
ble-face menu_complete_selected=reverse


## These faces control graphic styles used in the menu descriptions.  Face
## "menu_desc_default" is used as a default highlighting of the description.
## Face "menu_desc_type" is used for the prefix string "(type) " to indicate
## the type of the menu item.  Face "menu_desc_quote" is used to quote strings
## embedded in the descriptions.

#ble-face menu_desc_default=none
#ble-face menu_desc_type=ref:syntax_delimiter
#ble-face menu_desc_quote=ref:syntax_quoted


bind 'set completion-ignore-case on'
bind 'set visible-stats on' # better output
#bind 'set mark-directories on'
#bind 'set mark-symlinked-directories on'
#bind 'set match-hidden-files on'
#bind 'set menu-complete-display-prefix off' # enable for full filepaths
#bleopt complete_source_sabbrev_ignore= # colon separated list of glob patterns to ignore
#bleopt complete_source_sabbrev_opts=no-empty-completion # uncomment to disable completion on empty


## This is a colon-separated list of options.  When the field `apropos` is
## specified, the candidate descriptions for command names in the completion
## menu is generated by "man -s 1,8 -k .", which outputs an apropos explanation
## for each man entry.

bleopt complete_source_command_opts=apropos

##-----------------------------------------------------------------------------
## Color settings

bleopt term_index_colors=auto # use terminfo
#bleopt term_true_colors=semicolon
bleopt filename_ls_colors="$LS_COLORS"


## The following settings enable or disable the syntax highlighting.  When the
## setting "highlight_syntax" has a non-empty value, the syntax highlighting is
## enabled.  When the setting "highlight_filename" has a non-empty value, the
## highlighting based on the filename and the command name is enabled during
## the process of the syntax highlighting.  Similarly, when the setting
## "highlight_variable" has a non-empty value, the highlighting based on the
## variable type is enabled.  All of these settings have non-empty values by
## default.

#bleopt highlight_syntax=
#bleopt highlight_filename=
#bleopt highlight_variable=


bleopt highlight_timeout_sync=50
bleopt highlight_timeout_async=1000
bleopt syntax_eval_polling_interval=50
bleopt highlight_eval_word_limit=100

#bleopt color_scheme=base16

##-----------------------------------------------------------------------------

#ble-face -s region                    fg=231,bg=60
#ble-face -s region_insert             fg=27,bg=254
#ble-face -s region_match              fg=231,bg=55
#ble-face -s region_target             fg=black,bg=153
#ble-face -s disabled                  fg=242
#ble-face -s overwrite_mode            fg=black,bg=51

#ble-face -s syntax_default            none
#ble-face -s syntax_command            fg=brown
#ble-face -s syntax_quoted             fg=green
#ble-face -s syntax_quotation          fg=green,bold
#ble-face -s syntax_escape             fg=magenta
#ble-face -s syntax_expr               fg=63
#ble-face -s syntax_error              bg=203,fg=231
#ble-face -s syntax_varname            fg=202
#ble-face -s syntax_delimiter          bold
#ble-face -s syntax_param_expansion    fg=133
#ble-face -s syntax_history_expansion  bg=94,fg=231
#ble-face -s syntax_function_name      fg=99,bold
#ble-face -s syntax_comment            fg=gray
#ble-face -s syntax_glob               fg=198,bold
#ble-face -s syntax_brace              fg=37,bold
#ble-face -s syntax_tilde              fg=63,bold
#ble-face -s syntax_document           fg=100
#ble-face -s syntax_document_begin     fg=100,bold
#ble-face -s command_builtin_dot       fg=red,bold
#ble-face -s command_builtin           fg=red
#ble-face -s command_alias             fg=teal
#ble-face -s command_function          fg=99 # fg=133
#ble-face -s command_file              fg=green
#ble-face -s command_keyword           fg=blue
#ble-face -s command_jobs              fg=red,bold
#ble-face -s command_directory         fg=63,underline
#ble-face -s command_suffix            fg=231,bg=28
#ble-face -s command_suffix_new        fg=231,bg=124
#ble-face -s argument_option           fg=teal
#ble-face -s argument_option           fg=black,bg=225
#ble-face -s filename_directory        underline,fg=33
#ble-face -s filename_directory_sticky underline,fg=231,bg=26
#ble-face -s filename_link             underline,fg=teal
#ble-face -s filename_orphan           underline,fg=16,bg=224
#ble-face -s filename_setuid           underline,fg=black,bg=220
#ble-face -s filename_setgid           underline,fg=black,bg=191
#ble-face -s filename_executable       underline,fg=green
#ble-face -s filename_other            underline
#ble-face -s filename_socket           underline,fg=cyan,bg=black
#ble-face -s filename_pipe             underline,fg=lime,bg=black
#ble-face -s filename_character        underline,fg=231,bg=black
#ble-face -s filename_block            underline,fg=yellow,bg=black
#ble-face -s filename_warning          underline,fg=red
#ble-face -s filename_url              underline,fg=blue
#ble-face -s filename_ls_colors        underline
#ble-face -s varname_array             fg=orange,bold
#ble-face -s varname_empty             fg=31
#ble-face -s varname_export            fg=200,bold
#ble-face -s varname_expr              fg=99,bold
#ble-face -s varname_hash              fg=70,bold
#ble-face -s varname_new               fg=34
#ble-face -s varname_number            fg=64
#ble-face -s varname_readonly          fg=200
#ble-face -s varname_transform         fg=29,bold
#ble-face -s varname_unset             fg=245

#ble-face -s cmdinfo_cd_cdpath         fg=26,bg=155

##-----------------------------------------------------------------------------
## Keybindings

#ble-bind -f 'SP' 'self-insert' # uncomment to disable magic space
#ble-bind -f '/' 'self-insert' # uncomment to disable magic thing

ble-bind -f up 'history-search-backward'
ble-bind -f down 'history-search-forward'

ble-bind -m vi_nmap -f 'C-m' 'accept-line'
ble-bind -m vi_nmap -f 'RET' 'accept-line'

ble-bind -m auto_complete -f C-i auto_complete/insert-word
ble-bind -m auto_complete -f TAB auto_complete/insert-word

##-----------------------------------------------------------------------------
## Settings for Vim mode

function blerc/vim-load-hook {
  ((_ble_bash>=40300)) && builtin bind 'set keyseq-timeout 1'

  #----------------------------------------------------------------------------
  bleopt prompt_vi_mode_indicator='\q{keymap:vi/mode-indicator}'
  bleopt keymap_vi_mode_show=1

  bleopt keymap_vi_mode_name_insert=INSERT
  bleopt keymap_vi_mode_name_replace=REPLACE
  bleopt keymap_vi_mode_name_vreplace=VREPLACE
  bleopt keymap_vi_mode_name_visual=VISUAL
  bleopt keymap_vi_mode_name_select=SELECT
  bleopt keymap_vi_mode_name_linewise=LINE
  bleopt keymap_vi_mode_name_blockwise=BLOCK

  bleopt keymap_vi_mode_string_nmap:=$'\e[1m-- NORMAL --\e[m'

  #bleopt keymap_vi_mode_update_prompt= # enable to refresh prompt on mode change

  #----------------------------------------------------------------------------
  # Keybindings

  ble-bind -m vi_imap -f 'C-RET' 'accept-line'

  #ble-bind -m vi_imap -f 'M-C-?' kill-backward-cword
  #ble-bind -m vi_imap -f 'M-DEL' kill-backward-cword
  #ble-bind -m vi_imap -f 'M-C-h' kill-backward-cword
  #ble-bind -m vi_imap -f 'M-BS'  kill-backward-cword

  ble-bind -m vi_imap -f 'C-m' accept-line
  ble-bind -m vi_imap -f 'RET' accept-line
  ble-bind -m vi_nmap -f 'C-m' accept-line
  ble-bind -m vi_nmap -f 'RET' accept-line

  #ble-bind -m vi_imap -f 'C-o' 'accept-and-next' # accept and load previous

  ble-bind -m vi_imap -f 'C-k' 'vi_imap/insert-digraph'

  ble-bind -m vi_nmap -f 'g g' vi-command/first-nol
  ble-bind -m vi_omap -f 'g g' vi-command/first-nol
  ble-bind -m vi_xmap -f 'g g' vi-command/first-nol
  ble-bind -m vi_nmap -f 'G' vi-command/last-line
  ble-bind -m vi_omap -f 'G' vi-command/last-line
  ble-bind -m vi_xmap -f 'G' vi-command/last-line

  #----------------------------------------------------------------------------
  # Cursor shapes and other terminal settings

  ## Cursor settings

  ble-bind -m vi_nmap --cursor 2
  ble-bind -m vi_imap --cursor 5
  ble-bind -m vi_omap --cursor 4
  ble-bind -m vi_xmap --cursor 2
  ble-bind -m vi_smap --cursor 2
  ble-bind -m vi_cmap --cursor 0

  _ble_term_Ss=$'\e[@1 q'

  ## Control sequences that will be output on entering each mode
  #bleopt term_vi_nmap=
  #bleopt term_vi_imap=
  #bleopt term_vi_omap=
  #bleopt term_vi_xmap=
  #bleopt term_vi_smap=
  #bleopt term_vi_cmap=

  #----------------------------------------------------------------------------
  # Miscellaneous settings

  #bleopt keymap_vi_imap_undo=more # uncomment for more frequent undo
  #bleopt keymap_vi_keymodel=
  bleopt keymap_vi_macro_depth=32


  ## This option specifies the operator name when the user input "g@" in normal
  ## mode.  The function "ble/keymap:vi/operator:$value", where "$value" is the
  ## value of this setting, is used as the implementation of the operator.

  #bleopt keymap_vi_operatorfunc=
  #bleopt keymap_vi_search_match_current=

  #----------------------------------------------------------------------------
  # plugins

  #ble-import vim-surround
  #bleopt vim_surround_45:=$'$( \r )'
  #bleopt vim_surround_61:=$'$(( \r ))'

  # ble-import vim-airline
  # bleopt vim_airline_theme=light
  # bleopt vim_airline_section_a='\e[1m\q{lib/vim-airline/mode}'
  # bleopt vim_airline_section_b='\q{lib/vim-airline/gitstatus}'
  # bleopt vim_airline_section_c='\w'
  # bleopt vim_airline_section_x='bash'
  # bleopt vim_airline_section_y='$_ble_util_locale_encoding[unix]'
  # bleopt vim_airline_section_z=' \q{history-percentile} \e[1m!\q{history-index}/\!\e[22m \q{position}'
  # bleopt vim_airline_left_sep=$'\uE0B0'
  # bleopt vim_airline_left_alt_sep=$'\uE0B1'
  # bleopt vim_airline_right_sep=$'\uE0B2'
  # bleopt vim_airline_right_alt_sep=$'\uE0B3'
  # bleopt vim_airline_symbol_branch=$'\uE0A0'
  # bleopt vim_airline_symbol_dirty=$'\u26A1'
}
blehook/eval-after-load keymap_vi blerc/vim-load-hook

##-----------------------------------------------------------------------------
## Internal settings

#bleopt connect_tty=
#bleopt idle_interval='ble_util_idle_elapsed>600000?500:(ble_util_idle_elapsed>60000?200:(ble_util_idle_elapsed>5000?100:20))'
bleopt import_path="${XDG_DATA_HOME:-$HOME/.local/share}/blesh/local"
#bleopt debug_xtrace=~/var/log/blesh.xtrace # uncomment for debug logs (very big files)
#bleopt debug_xtrace_ps4='+ '
#bleopt debug_idle=1 # uncomment to enable debug logs in info panel
#bleopt internal_exec_int_trace=1 # uncomment to output SIGINT to stderr
#bleopt internal_ignoreeof_trap='Use "exit" to leave the shell.'
bleopt internal_stackdump_enabled=0 # enable to output stackdump on ble failed assertions
#bleopt internal_suppress_bash_output=1


## This is a colon-separated list of fields to control the behavior of
## ble/debug/profiler.  When the field "line" and "func" are specified,
## statistics for lines and function calls, respectively, are enabled.  When
## the field "tree" is specified, function-call trees are saved.  Optional
## parameter "html" can be specified to "line" and "func" separated by the
## equal sign, i.e., "line=html" and "func=html".  In such a case, the results
## are also saved in the .html format.

#bleopt debug_profiler_opts=line:func


## This option specifies the threshold time in milliseconds to determine
## whether to include a command in the tree generated by "bleopt
## debug_profiler_opts=tree".  The commands that took less than this time in
## execution will be skipped.  The default value is 5.0 msec.

#bleopt debug_profiler_tree_threshold=5.0
