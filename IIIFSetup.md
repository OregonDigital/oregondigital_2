IIIFSetup
=====

Servers
-----

### IIPImage

[IIP Image](http://iipimage.sourceforge.net/documentation/server/) is the best
option, but for IIIF support you need 1.0 or later.  As of the time of this
writing, 1.0 is not available via `apt-get` on Ubuntu 14.

### RAIS

UO's own [RAIS](https://github.com/uoregon-libraries/rais-image-server) can be
installed from source without too much trouble.  It isn't as performant as IIP,
and requires Go to install, but works well for dev.

(It also requires the imagemagick "magickcore" libraries, but you should have
installed these as a prerequisite to vips)

On Ubuntu 14:

```bash
# Install Go
sudo apt install golang

# Install RAIS
GOPATH=$HOME/go go get -u github.com/uoregon-libraries/rais-image-server/cmd/rais-server

# Run it locally - replace "RAILS_ROOT" with your rails root path, or wherever
# your media directory is located; e.g.; "/home/jechols/oregondigital_2"
~/go/bin/rais-server --address=":8080" --iiif-url="http://localhost:8080/images/iiif" --tile-path="RAILS_ROOT"
```

Note that the `--iiif-url` MUST reflect precisely what you have in your config,
in order for the info.json response to direct openseadragon properly.

Config
-----

Change the config file to point to whatever server you've chosen.  For RAIS,
for instance, you'd need to edit `settings/development.local.yml` and set
`openseadragon`'s `iiif_server` value to `http://localhost:8080/images/iiif`
(assuming `settings.yml` doesn't have what you want).
