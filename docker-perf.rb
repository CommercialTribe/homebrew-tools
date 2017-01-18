require "net/http"
require "formula"

class DockerPerf < Formula
  url "https://github.com/CommercialTribe/homebrew-tools/edit/master/docker-perf.rb"
  depends_on 'docker'

  def install
    Dir.chdir "~/Library/Containers/com.docker.docker/Data/database/" do
      filename = "com.docker.driver.amd64-linux/disk/full-sync-on-flush"
      system 'git reset --hard'
      File.open(filename, "w"){ |file| file.write "true\n" }
      system "git add #{filename}"
      system 'git commit -s -m "Disable flushing"'
    end
  end
end
