FROM ruby:2.2.0

# dependencies
RUN \
  apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  # git-core \
  libcurl4-openssl-dev \
  libc6-dev \
  libreadline-dev \
  libssl-dev \
  libxslt1-dev \
  libyaml-dev \
  zlib1g-dev \
  imagemagick \
  # git \
  curl \
  autoconf \
  ca-certificates \
  libffi-dev \
  libgdbm-dev \
  libgmp-dev \
  libncurses5-dev \
  libqdbm-dev \
  libreadline6-dev \
  libz-dev \
  systemtap \
  ruby-dev \
  sqlite3 \
  libsqlite3-dev \
  openssh-client \
  openssh-server \
  vim \
  libgtk2.0-dev \
  libvips \
  g++


WORKDIR /tmp
ENV LIBVIPS_VERSION_MAJOR 8
ENV LIBVIPS_VERSION_MINOR 2
ENV LIBVIPS_VERSION_PATCH 3
ENV LIBVIPS_VERSION $LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR.$LIBVIPS_VERSION_PATCH

RUN \

  # Install dependencies
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  automake \
  gobject-introspection gtk-doc-tools libglib2.0-dev \
  libpng12-dev libwebp-dev libtiff5-dev libexif-dev libxml2-dev swig libmagickwand-dev libpango1.0-dev \
  libmatio-dev libopenslide-dev libcfitsio3-dev && \

  # Build libvips
  curl -O http://www.vips.ecs.soton.ac.uk/supported/$LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR/vips-$LIBVIPS_VERSION.tar.gz && \
  tar zvxf vips-$LIBVIPS_VERSION.tar.gz && \
  cd vips-$LIBVIPS_VERSION && \
  ./configure --enable-debug=no --without-python --without-orc --without-fftw --without-gsf $1 && \
  make && \
  make install && \
  ldconfig && \

  # Clean up
  apt-get remove -y curl automake build-essential && \
  apt-get autoremove -y && \
  apt-get autoclean && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y openjdk-7-jdk && \
  rm -rf /var/lib/apt/lists/*

# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Setup git profile
RUN mkdir -p ~/.ssh
COPY docker-key /root/.ssh/id_rsa
COPY docker-key.pub /root/.ssh/id_rsa.pub
RUN chmod 700 ~/.ssh/id_rsa
RUN touch ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/authorized_keys
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN touch ~/.ssh/known_hosts
RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
RUN mkdir /oregondigital_2

WORKDIR /oregondigital_2
COPY Gemfile Gemfile
COPY Rakefile Rakefile
COPY Gemfile.lock Gemfile.lock
COPY . .
RUN bundle install
RUN RAILS_ENV=development bundle exec rake db:migrate
RUN RAILS_ENV=development bundle exec rake jetty:clean
RUN RAILS_ENV=development bundle exec rake jetty:config
RUN RAILS_ENV=development bundle exec rake jetty:start
ADD . /oregondigital_2
WORKDIR /oregondigital_2
# RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
# CMD ["rails","server","-b","0.0.0.0"]
