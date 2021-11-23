#!/bin/bash
pmset -g batt | grep -Eo "\d+%" | cut -d% -f1
