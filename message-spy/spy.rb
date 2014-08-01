require 'bunny'

puts "Opening connection to broker..."
conn = Bunny.new
conn.start

ch = conn.create_channel
#q2  = ch.queue("assets", :auto_delete =>false, :passive=>true)
q2 = ch.fanout("assets")
q  = ch.queue("", :auto_delete => true, :exclusive=>true).bind(q2)

q.subscribe do |delivery_info, properties, payload|
    puts "Received #{payload}"
end

while (1)
end

Signal.trap("EXIT") {
puts "CLosing connection."
conn.stop
exit
}

