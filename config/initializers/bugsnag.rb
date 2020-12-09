if defined? Bugsnag
  Bugsnag.configure do |config|
    config.api_key = '5f6a7bc3cb003af7e821eb5b3fcccb0d'

    Shikimori::IGNORED_EXCEPTIONS
      .map { |v| v.constantize rescue NameError }
      .reject { |v| v == NameError }
      .each do |klass|
        config.ignore_classes << klass
      end
  end
end
