module Config
  extend self

  def repository_name
    ENV.fetch("REPOSITORY")
  end

  def log_level
    ENV.fetch("LOG_LEVEL", "error")
  end
end
