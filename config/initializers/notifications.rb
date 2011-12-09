rails_events_path = Rails.root.join('tmp','rails_events.log')
rails_event_names_path = Rails.root.join('tmp','rails_event_names.log')
ActiveSupport::Notifications.subscribe do |name, start, finish, id, payload|
  File.open(rails_events_path,'a') { |file| file << "notification: name: '#{name}', from: #{start} to: #{finish}, id: #{id}, payload:#{payload.inspect}\n\n" }
  File.open(rails_event_names_path,'a') { |file| file << "#{name}\n" }
end
