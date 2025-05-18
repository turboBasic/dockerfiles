typeset -U FPATH fpath
typeset -U PATH path=( $path ~/.local/bin )
typeset -U MANPATH manpath
typeset -U CDPATH cdpath

export LANG=en_DK.UTF-8
export LC_NUMERIC=en_GB.UTF-8
export EDITOR='nvim'
export LESS="\
--buffers=128 \
--HILITE-UNREAD \
--ignore-case \
--LONG-PROMPT \
--max-back-scroll=15 \
--no-init \
--quiet \
--quit-at-eof \
--quit-if-one-screen \
--RAW-CONTROL-CHARS \
--status-line \
--tabs=4 \
--window=-4\
"
