require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module OrderAnalysis
  class Application < Rails::Application
    config.load_defaults 7.2

    config.i18n.default_locale = :ja

    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/controllers/concerns)

    # アセットのプリコンパイルを初期化時に行わない
    config.assets.initialize_on_precompile = false
  end
end
