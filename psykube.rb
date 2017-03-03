require "net/http"
require "formula"

class Psykube < Formula
  LATEST_RELEASE = JSON.parse(Net::HTTP.get(URI("https://api.github.com/repos/commercialtribe/psykube/releases/latest")))
  FALLBACK_TAG = "v0.9.0-rc2"
  TAG = LATEST_RELEASE["tag_name"] || FALLBACK_TAG

  version TAG.sub /^v/, ''
  homepage 'https://github.com/commercialtribe/psykube'
  head 'https://github.com/commercialtribe/psykube.git', branch: 'master'
  url 'https://github.com/commercialtribe/psykube.git', using: :git, tag: TAG

  depends_on 'crystal-lang' => :build
  depends_on 'openssl' => :build
  depends_on 'npm' => :build
  depends_on 'kubernetes-cli'
  depends_on 'bdw-gc'

  def install
    bin = File.join(prefix, "bin")
    mkdir_p bin
    ln_s "/usr/local/lib/node_modules/npm/bin/npm-cli.js", File.join(bin, "npm")
    ENV["PATH"] = "#{bin}:#{ENV["PATH"]}"
    ENV["TRAVIS_TAG"] = TAG unless build.head?
    system 'shards build --release'
    bin.install "bin/psykube"
  end
end
