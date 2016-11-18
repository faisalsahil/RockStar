namespace :load do
  task :defaults do

  end
end

namespace :standalone_passenger do

  desc "Start Standalone Passenger"
  task :start do
    on roles(:app) do
      within "#{current_path}" do
        begin
          execute :passenger, :start
        rescue
          puts "Passenger can not start"
        end
      end
    end
  end

  desc "Start Standalone Passenger"
  task :stop do
    on roles(:app) do
      within "#{current_path}" do
        begin
          execute :passenger, :stop, "--pid-file tmp/pids/passenger.pid"
        rescue
          puts "Passenger can not stop"
        end
      end
    end
  end

  desc 'Restart Standalone Passenger'
  task :restart do
    invoke "standalone_passenger:stop"
    invoke "standalone_passenger:start"
  end


end