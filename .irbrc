require "irb/completion"
IRB.conf[:PROMPT_MODE]=:SIMPLE

require "irb/ext/save-history"
IRB.conf[:SAVE_HISTORY]=1000
IRB.conf[:HISTORY_FILE]="#{ENV['HOME']}/.irb_history"

# Fix home and end key, via https://github.com/ruby/irb/issues/330#issuecomment-1132017233
require "reline/ansi"
if defined?(Reline::ANSI::CAPNAME_KEY_BINDINGS)
  Reline::ANSI::CAPNAME_KEY_BINDINGS.merge!({
    "kich1" => :ed_ignore,
    "kdch1" => :key_delete,
    "kpp" => :ed_ignore,
    "knp" => :ed_ignore
  })

  Reline::ANSI.singleton_class.prepend(
    Module.new do
      def set_default_key_bindings(config)
        set_default_key_bindings_comprehensive_list(config)
        key = [239, 157, 134]
        func = :ed_ignore
        config.add_default_key_binding_by_keymap(:emacs, key, func)
        config.add_default_key_binding_by_keymap(:vi_insert, key, func)
        config.add_default_key_binding_by_keymap(:vi_command, key, func)
        super
      end
    end
  )
end
