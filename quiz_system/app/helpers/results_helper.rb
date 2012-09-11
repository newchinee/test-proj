module ResultsHelper
  def convert_status(status, marks)
    #Constants
    # STATUS_STARTED = 0
    # STATUS_PAUSE = 1
    # STATUS_ENDED = 2
    
    if((status == Result::STATUS_STARTED) || (status == Result::STATUS_RESUME))
      raw("<span class=\"label label-default\">Ongoing</span>")
    elsif(status == Result::STATUS_PAUSE)
      raw("<span class=\"label label-warning\">Paused...</span>")
    else
      if(marks >= 100)
        raw("<span class=\"label label-success\">Completed!</span>")
      else
        raw("<span class=\"label label-important\">Failed</span>")
      end
    end
  end
  
  def convert_duration(seconds)
    hours = seconds / 3600
    remaining_secs = seconds % 3600
    minutes = remaining_secs / 60
    seconds = remaining_secs % 60
    "#{hours}:#{minutes}:#{seconds}"
  end
end
