Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '/transactions',
             :headers => :any,
             :methods => [:post, :get]
  end
end