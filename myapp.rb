require 'rubygems'
require 'sinatra'

#set :threaded, 'false'

  get '/daemon_response' do
    stream do |out|
      logger.info "Server Got the #{params[:client]} Request."
      out << " Server Is Now Starting A Daemon."
      sleep 5
      fork do
        sleep 60
        logger.info "Into Child, PID = #$$ for #{params[:client]} Request. "
        exit 0 
      end
      pid = Process.wait
      out << " Child Terminated , pid = #{pid}, exit code = #{$? >> 8}"
      out << "Request Completed." 
    end
  end
