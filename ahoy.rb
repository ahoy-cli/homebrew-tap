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
      ENV["XC_OS"] = "darwin"
      ENV["XC_ARCH"] = MacOS.prefer_64_bit? ? "amd64" : "386"
      ENV["GOPATH"] = buildpath
      path = buildpath/"src/github.com/ahoy-cli/ahoy"
      path.install Dir["{*,.git}"]
      #Language::Go.stage_deps buildpath/"src"
      cd path do
        system "bash", "build.sh"
        bin.install "ahoy"
      end
    else
      system "mv", "ahoy-darwin-amd64", "ahoy"
      bin.install "ahoy"
    end
  end
end
