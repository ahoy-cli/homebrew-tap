require "language/go"

class Ahoy < Formula
  desc "Ahoy - Create aliases for commands on docker, ssh, and your local machine."
  homepage "http://www.ahoycli.com/"
  url "https://github.com/ahoy-cli/ahoy/releases/download/1.1.0/ahoy-darwin-amd64"
  version "1.1.0"
  sha256 "8bb1c76e28ca499f2dcadafdec7776ca3bd4e85c45c8d4f9f19220d5d4f233cf"

  head "https://github.com/ahoy-cli/ahoy.git",
    :branch => "master"

  depends_on "go" => :build

  def install
    # Build from the latest verison of ahoy.
    if build.head?
      ENV["GOPATH"] = buildpath
      path = buildpath/"src/github.com/ahoy-cli/ahoy"
      path.install Dir["*"]
      Language::Go.stage_deps resources, buildpath/"src"
      system "go", "build", "-o", "bin/ahoy", "github.com/ahoy-cli/ahoy"
      bin.install "bin/ahoy"
    else
      system "mv", "ahoy-darwin-amd64", "ahoy"
      bin.install "ahoy"
    end
  end
end
