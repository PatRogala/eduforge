# config/initializers/slow_queries.rb
class SlowQuerySubscriber < ActiveSupport::Subscriber
  THRESHOLD = 1.0 # 1 second

  attach_to :active_record do |_name, start, finish, _, payload|
    duration = finish - start
    Rails.logger.warn "🐌 Slow Query (#{duration.round(2)}s): #{payload[:sql]}" if duration > THRESHOLD
  end
end
