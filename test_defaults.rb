dep 'test greeting', :greeting_message, :message do
  greeting_message.default("Hello")
  message.default("Hello")

  met? {
    "~/.babushka/test/greeting".p.exists?
  }
  meet {
    log "Greeting: #{greeting_message}", :as => :stderr
    log "Message: #{message}", :as => :stderr
    shell "echo '#{greeting_message} (#{message})' > ~/.babushka/test/greeting"
  }
end

dep 'test farewell', :farewell_message, :message do
  requires 'test greeting'

  farewell_message.default("Goodbye")
  message.default("Goodbye")

  met? {
    "~/.babushka/test/farewell".p.exists?
  }
  meet {
    log "Farewell: #{farewell_message}", :as => :stderr
    log "Message: #{message}", :as => :stderr
    shell "echo '#{farewell_message} (#{message})' > ~/.babushka/test/farewell"
  }
end
