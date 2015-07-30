class BlacklightConfig
  class Embed
    pattr_initialize :configuration

    def run
      configuration.show.oembed_field = :oembed_ssim
      configuration.show.partials.insert(1, :oembed)
    end
  end
end
