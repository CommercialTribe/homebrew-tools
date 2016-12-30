require "formula"

class Psykube < Formula
  VERSION = "0.1.0-beta3"
  
  version VERSION
  homepage 'https://github.com/commercialtribe/psykube'
  head 'https://github.com/commercialtribe/psykube.git', branch: 'master'
  url 'https://github.com/commercialtribe/psykube.git', using: :git, tag: "v#{VERSION}"

  depends_on 'crystal-lang' => :build

  def install
    ENV["TRAVIS_TAG"] = "v#{VERSION}" unless build.head?
    system 'make build'
    bin.install "psykube"
  end
  
end
