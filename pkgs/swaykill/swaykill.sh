#!/usr/bin/env bash
swayprop | jq .pid | xargs kill "${@}"


