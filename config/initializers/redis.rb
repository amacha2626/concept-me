REDIS ||= Redis.new(url: ENV['REDIS_URL'] || 'redis://3.114.216.97:6379')