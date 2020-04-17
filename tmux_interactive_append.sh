#!/bin/bash

tmux a -t `tmux ls | fzf -m | awk '{print $1}'`
