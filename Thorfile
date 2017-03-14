class ::Default < Thor
  desc 'start', 'Run the server'
  def start
    exec "rerun 'ruby lib/server.rb'"
  end

  desc 'validate', 'Validates swagger'
  def validate
    exec 'swagger-tools validate http://localhost:4567/swagger'
  end
end
