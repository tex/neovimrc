return {
-- {
--     "David-Kunz/gen.nvim",
--     opts = {
--         -- model = "mistral", -- The default model to use.
--         -- model = "yi-coder:9b", -- The default model to use.
--         -- model = "qwen2.5-coder:7b", -- The default model to use.
--         -- model = "deepseek-r1:32b", -- The default model to use.
--         model = "mistral-small:24b", -- The default model to use.
--         quit_map = "q", -- set keymap to close the response window
--         retry_map = "<c-r>", -- set keymap to re-send the current prompt
--         accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
--         host = "localhost", -- The host running the Ollama service.
--         port = "11434", -- The port on which the Ollama service is listening.
--         display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
--         show_prompt = false, -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
--         show_model = false, -- Displays which model you are using at the beginning of your chat session.
--         no_auto_close = false, -- Never closes the window automatically.
--         file = false, -- Write the payload to a temporary file to keep the command short.
--         hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
--         init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
--         -- Function to initialize Ollama
--         command = function(options)
--             local body = {model = options.model, stream = true}
--             return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
--         end,
--         -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
--         -- This can also be a command string.
--         -- The executed command must return a JSON object with { response, context }
--         -- (context property is optional).
--         -- list_models = '<omitted lua function>', -- Retrieves a list of model names
--         result_filetype = "markdown", -- Configure filetype of the result buffer
--         debug = false -- Prints errors and the command which is run.
--     }
-- },
 {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      strategies = {
        -- Change the default chat adapter
        chat = {
          adapter = 'qwen',
        },
        inline = {
          adapter = 'qwen',
        },
      },
      adapters = {
        qwen = function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'qwen', -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = 'qwen2.5-coder:7b',
              },
            },
          })
        end,
      },
      opts = {
        log_level = 'DEBUG',
      },
      display = {
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = 'vertical', -- vertical|horizontal split for default provider
          opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
          provider = 'default', -- default|mini_diff
        },
      },
    },
  },
}

