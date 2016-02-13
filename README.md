# WeeChat TeleIRC Rewriter

This is a WeeChat script for use with the bot TeleIRC, which bridges an IRC
channel and a Telegram group. Currently, IRC messages from the bot look like
this:

    <LibreWulf> This is a test from IRC
    <`>         LibreWulf: This is a test from Telegram

It looks bad and messes up some things. Instead, the goal of this plugin is to
make it look more like this:

    <LibreWulf> This is a test from IRC
    <LibreWulf> [TG] This is a test from Telegram

## Status

Mostly done? Needs to be bug tested. Feel free to give it a spin and open an
issue if something breaks!
