require "net/http"
require "formula"

class Psykube < Formula
  TAG = JSON.parse(Net::HTTP.get(URI("https://api.github.com/repos/commercialtribe/psykube/releases/latest")))["tag_name"]

  version TAG.sub /^v/, ''
  homepage 'https://github.com/commercialtribe/psykube'
  head 'https://github.com/commercialtribe/psykube.git', branch: 'master'
  url 'https://github.com/commercialtribe/psykube.git', using: :git, tag: TAG

  depends_on 'crystal-lang' => :build

  def install
    ENV["TRAVIS_TAG"] = TAG unless build.head?
    system 'shards build'
    bin.install "bin/psykube"
  end

end
