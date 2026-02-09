if status is-interactive
    # Auto-iniciar/reconectar no tmux ao entrar via SSH *somente* quando WITH_TMUX=1.
    # Exemplos:
    #   - Ativar nesta sessão: `WITH_TMUX=1 ssh ...`
    #   - Forçar desativado:  `NO_TMUX=1 ssh ...`
    if not set -q TMUX; and not set -q NO_TMUX; and set -q WITH_TMUX; and test "$WITH_TMUX" = "1"; and begin
            set -q SSH_CONNECTION; or set -q SSH_TTY
        end
        if type -q tmux
            exec tmux new-session -A -s main
        end
    end
end

# pnpm
set -gx PNPM_HOME "/home/ryster/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
/home/zesmoi/.local/bin/mise activate fish | source

# opencode
fish_add_path /home/zesmoi/.opencode/bin

# Auto-Warpify
status --is-interactive; and printf 'P$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "fish", "uname": "Linux" }}�' 
