require "formula"

class KubeShell < Formula
  url "https://github.com/CommercialTribe/homebrew-tools/edit/master/kube-shell.rb"
  depends_on 'kubernetes-cli'

  def install
    File.open("docker-perf", "w") do |file|
      file.write <<-BASH
#!/bin/bash
#!/usr/bin/env bash
set -e

cmd(){
  echo $@
  $@
}

name="$USER-$(openssl rand -hex 3)"
namespace=${1-"default"}
image=${2-"ubuntu:latest"}
command=${3-"bash"}

shift || true
shift || true
shift || true

cmd kubectl --namespace=$namespace run $name -it --image=$image --command -- $command $@
cmd kubectl --namespace=$namespace delete deployment $name --now
BASH
    end
    bin.install "docker-perf"
  end
end
