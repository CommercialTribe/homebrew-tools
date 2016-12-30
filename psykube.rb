require "formula"

class PsyKube < Formula
  VERSION = "0.1.0-beta1"

  version VERSION
  homepage "https://github.com/commercialtribe/psykube"
  head "https://github.com/commercialtribe/psykube.git", branch: "master"
  url "https://github.com/commercialtribe/psykube.git", using: :git, tag: "v#{VERSION}"

  depends_on "crystal" => :build

  def install
    system "shards install"
    system "crystal build"
    bin.install "psykube"
  end
  
end
