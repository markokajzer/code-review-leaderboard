require "ostruct"

module FileFixture
  def json_fixture(path)
    JSON.parse(File.read(path))
  end

  def object_fixture(path)
    JSON.parse(File.read(path), object_class: OpenStruct)
  end
end

RSpec.configure do |config|
  config.include FileFixture
end
