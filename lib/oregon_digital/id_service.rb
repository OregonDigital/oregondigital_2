# -*- coding: utf-8 -*-
# Copyright © 2012 The Pennsylvania State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module OregonDigital
  class IdService
    class << self
      def create(pid)
        new(:pid => pid, :retry => false).result
      end

      def mint
        new.result
      end

      def valid?(pid)
        new(:pid => pid).valid?
      end

    end

    attr_accessor :pid

    def initialize(opts={})
      @pid ||= opts[:pid]
      @retry ||= opts.fetch(:retry, true)
      @retry = false if @pid
    end

    def result
      @pid ||= IdGenerator.next_id
      check_existence! unless retry?
      check_existence
      pid
    end

    def valid?
      minter.valid?(pid)
    end

    private

    def minter
      @minter ||= ::Noid::Minter.new(:template => IdGenerator.noid_template)
    end

    def retry?
      @retry
    end

    def check_existence!
      raise "#{pid} is taken" if ActiveFedora::Base.exists?(pid)
    end

    def check_existence
      begin
        check_existence!
      rescue 
        self.class.mint
      end
    end

    def namespace
      self.class.namespace
    end

  end
  class IdGenerator
    def self.next_id
      # Seed with process id and time in milliseconds to avoid
      # fork-based collisions and pid-based collisions.  Even if
      # server time gets messed up and pid is repeatable over reboots,
      # the odds of a collision with the exact time and process are
      # very low.
      new.generate
    end

    def self.noid_template
      '.reeddeeddk'
    end

    attr_accessor :pid
    def initialize
      @pid = ''
    end

    def generate
      statefile do |yaml|
        minter = ::Noid::Minter.new(yaml)
        @pid = minter.mint
        yaml = YAML::dump(minter.dump)
      end
      return pid
    end

    private

    def statefile
      File.open(statefile_location, File::RDWR|File::CREAT, 0644) do |f|
        f.flock(File::LOCK_EX)
        yaml = YAML::load(f.read)
        yaml = {:template => self.class.noid_template} unless yaml
        yaml = yield yaml
        f.rewind
        f.write yaml
        f.flush
        f.truncate(f.pos)
      end
    end

    def statefile_location
      APP_CONFIG.minter_statefile
    end

  end
end
