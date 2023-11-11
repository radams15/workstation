#!/bin/sh

gsettings get org.gnome.Terminal.ProfilesList list | tr -d "[]\',"
