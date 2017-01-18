require "net/http"
require "formula"

class DockerPerf < Formula
  url "https://github.com/CommercialTribe/homebrew-tools/edit/master/docker-perf.rb"
  depends_on 'docker'

  def install
    File.open("docker-perf", "w") do |file|
      file.write <<-BASH
#!/bin/bash
# From: https://gist.github.com/kortina/67ad6e40e40d5199c3507cdad0c9a12c
# Tune fsync perf for docker mac per
# https://github.com/docker/for-mac/issues/668
# NB: You must be on Docker 1.12.2-rc1-beta27 or greater

cd ~/Library/Containers/com.docker.docker/Data/database/
f="com.docker.driver.amd64-linux/disk/full-sync-on-flush"
git reset --hard
cat $f
echo "false" > $f
git add $f && git commit -s -m "Disable flushing"
echo "You should now restart Docker for Mac."
BASH
    end
    bin.install "docker-perf"
  end
end
