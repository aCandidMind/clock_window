require "clock_window/version"
require "clock_window/refinements"
require "clock_window/filters"
require "clock_window/oscommand"
require "clock_window/notify_timer"
require 'neatjson'

module ClockWindow
  class ClockIt

    attr_reader :sleep_length

    # As this will get more sophisticated this class is the UI
    def initialize(**kwargs)
      @os_cmd = OScommand.new(**kwargs)
      @sleep_length = 15
      @notify_timer = ClockWindow::NotifyTimer.new(25 * 60, @sleep_length)
      @hash = {"*---------- WINDOW NAME ----------*" => "minutes"}
    end

    def tick
      x = active_window
      @hash[x] = @hash[x].to_f + sleep_length / 60.0
      handle_notification
    end

    def active_window
      exe, format = @os_cmd.active_window
      format.call(`#{exe}`)
    end

    def handle_notification
      @notify_timer.tick
      if @notify_timer.elapsed?
        filepath = write_report(Time.now, "intervals/%Y-%m", "%d-%H%M.json")
        notify_cmd = @os_cmd.notify_cmd(filepath)
        fork do
          `#{notify_cmd}`
        end
        @notify_timer.reset
      end
    end


    def write_report(time, dir_name, file_name)
      dir = time.strftime(dir_name)
      FileUtils.mkdir_p(dir) unless dir.empty?
      file = time.strftime(file_name)
      filepath = "#{dir}#{File::SEPARATOR unless dir.empty?}#{file}"
      File.open(filepath, "w") do |f|
        f.write(report)
      end
      filepath
    end


    def report
      JSON.neat_generate(@hash, aligned: true, around_colon: 1)
    end

  end
end
