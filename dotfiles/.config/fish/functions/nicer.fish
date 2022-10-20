function nicer
  renice -n $(math $(nice) + 1) -p $fish_pid > /dev/null
end
