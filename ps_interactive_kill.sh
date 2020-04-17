#/bin/bash

ps aux | fzf -m | awk '{print $2}'|xargs  kill -9
