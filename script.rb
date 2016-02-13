# Weechat TeleIRC Rewrite script
#
# This is a script for weechat that modifies TeleIRC messages to make the
# appear like normal IRC messages in the buffer.
#
# Author::    William Osler (mailto:{firstname}@{lastname}s.us)
# License::   MIT

$script_name = "teleirc"

$defaults = { bot_nick: "`", prefix: "[TG]", enabled: "false"}

def weechat_init
  Weechat.register($script_name, "William Osler <{firstname}@{lastname}s.us>",
                   "0.1", "MIT", "Rewrites TeleIRC messages to appear native",
                   "shutdown", "")

  # Initialize config
  $defaults.each do |key, value|
    if !Weechat.config_is_set_plugin(key.to_s) then
      Weechat.config_set_plugin(key.to_s, value)
    end
  end

  # Register a PRIVMSG modification callback
  Weechat.hook_modifier("irc_in_privmsg", "modify_privmsg_cb", "")

  return Weechat::WEECHAT_RC_OK
end

def shutdown
  Weechat.print("", "#{script_name} shutting down.")
  return Weechat::WEECHAT_RC_OK
end

# Begin actual functionality
def modify_privmsg_cb(data, modifier, modifier_data, string)

  if Weechat.config_get_plugin("bot_nick")
    bot_nick = Weechat.config_get_plugin("bot_nick")
  else
    bot_nick = $defaults[:bot_nick]
  end

  if Weechat.config_get_plugin("prefix")
    prefix = Weechat.config_get_plugin("prefix")
  else
    prefix = $defaults[:prefix]
  end

  # Check for the proper username
  nick = string.split(" ")[0].split("!")[0][1..-1]

  if nick == bot_nick
    # Find location of message text (4th arg)
    index = 0
    3.times do
      index = string.index(" ", index+1)
    end
    index += 2 # consume space and :
    message = string[index..-1]

    # Extract the Telegram name of the sender and remove it from the message
    tgram_name = message.split(":")[0]
    text = message[tgram_name.size+2..-1]
    text.prepend(prefix + " ") unless prefix.empty?

    # Replace command text with new text
    string[index..-1] = text

    # Substitute the bot name with the Telegram name
    string.sub!(":#{bot_nick}", ":#{tgram_name}")
  end

  return string
end
