# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
#Rails.application.config.assets.paths << "#{Rails.root}/app/assets/images"

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( test/wn.css )
Rails.application.config.assets.precompile += %w( css/bootstrap/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( css/font/font-awesome.min.css )
Rails.application.config.assets.precompile += %w( css/iCheck/green.css )
Rails.application.config.assets.precompile += %w( css/bootstrap/bootstrap-progressbar-3.3.4.min.css )
Rails.application.config.assets.precompile += %w( css/jquery/jquery-jvectormap-2.0.3.css )
Rails.application.config.assets.precompile += %w( css/custom.min.css )
Rails.application.config.assets.precompile += %w( css/wn.css )

Rails.application.config.assets.precompile += %w( js/jqury/jquery.min.js )
Rails.application.config.assets.precompile += %w( js/others/fastclick.js )
Rails.application.config.assets.precompile += %w( js/others/nprogress.js )
Rails.application.config.assets.precompile += %w( js/bootstap/bootstrap.min.js )
Rails.application.config.assets.precompile += %w( js/bootstap/bootstrap-progressbar.min.js )
Rails.application.config.assets.precompile += %w( js/others/icheck.min.js )
Rails.application.config.assets.precompile += %w( js/others/skycons.js )
Rails.application.config.assets.precompile += %w( js/custom.min.js )

