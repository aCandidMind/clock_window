module ClockWindow
  class NotifyTimer
    def initialize(interval, sleep_length)
      @interval = interval
      @sleep_length = sleep_length
      @elapsed = 0
    end

    def tick
      puts "Tick"
      @elapsed += @sleep_length
      puts "@elapsed: #{@elapsed}"
    end

    def elapsed?
      @elapsed >= @interval
    end

    def reset
      @elapsed = 0
    end

  end
end
