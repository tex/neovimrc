require('nvim-rooter').setup {
  rooter_patterns = { '.git', '.hg', '.svn' },  -- To specify a concrete directory as root folder do this '=src'
  trigger_patterns = { '*' },
  manual = false,
}
