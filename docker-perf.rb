require "net/http"
require "formula"

class DockerPerf < Formula
  depends_on 'docker'

  def install
    Dir.cd "~/Library/Containers/com.docker.docker/Data/database/" do
      filename = "com.docker.driver.amd64-linux/disk/full-sync-on-flush"
      system 'git reset --hard'
      File.open(filename, "a"){ |file| file.write "true\n" }
      system "git add #{filename}"
      system 'git commit -s -m "Disable flushing"'
    end
  end
end
