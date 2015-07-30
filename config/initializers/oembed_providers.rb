require 'oembed'

OEmbed::Providers.register_all

## Register OSU Mediaspace Provider
mediaspace_provider = OEmbed::Provider.new("https://media.oregonstate.edu/oembed")
mediaspace_provider << "https://media.oregonstate.edu/id*"
mediaspace_provider << "http://media.oregonstate.edu/id*"
mediaspace_provider << "http://media.oregonstate.edu/media/id*"
mediaspace_provider << "https://media.oregonstate.edu/media/id*"
OEmbed::Providers.register(mediaspace_provider)
