require 'pathname'
require 'acapi/client'
require 'acapi/default'

module AcquiaCloudApi
  def self.source_root
    @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
  end
end
