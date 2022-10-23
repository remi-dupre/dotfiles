#!/bin/bash

# Notify the system that it is being locked, this will for example be caught by
# KeyPassXC to lock the database
loginctl lock-session

swaylock
