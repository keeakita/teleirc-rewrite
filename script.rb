# Weechat TeleIRC Rewrite script
#
# This is a script for weechat that modifies TeleIRC messages to make the
# appear like normal IRC messages in the buffer.
#
# Author::    William Osler (mailto:{firstname}@{lastname}s.us)
# License::   MIT

$script_name = "teleirc"

$options = { bot_nick: "`", prefix: "[TG]", enabled: "false"}

def weechat_init
  Weechat.register($script_name, "William Osler <{firstname}@{lastname}s.us>",
                   "0.1", "MIT", "Rewrites TeleIRC messages to appear native",
                   "shutdown", "")

  # Initialize config
  $options.each do |key, value|
    if Weechat.config_is_set_plugin(key.to_s) then
      $options[key] = Weechat.config_get_plugin(key.to_s)
    else
      Weechat.config_set_plugin(key.to_s, value)
    end
  end

  # Listen for config changes
  Weechat.hook_config("plugins.var.ruby." + $script_name + ".*", "config_cb", "")

  return Weechat::WEECHAT_RC_OK
end

def shutdown
  Weechat.print("", "#{script_name} shutting down.")
  return Weechat::WEECHAT_RC_OK
end

def config_cb(data, option, value)
  # load options
  $options.each_key do |key|
    if Weechat.config_is_set_plugin(key.to_s) then
      $options[key] = Weechat.config_get_plugin(key.to_s)
    end
  end

  return Weechat::WEECHAT_RC_OK
end
