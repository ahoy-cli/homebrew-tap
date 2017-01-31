class Ahoy < Formula
  desc "Creates self documenting cli programs from commands in yaml files."
  homepage "http://www.ahoycli.com/"
  url "https://github.com/ahoy-cli/ahoy/releases/download/2.0.0-beta1/ahoy-bin-darwin-amd64"
  version "2.0.0-beta1"
  sha256 "9c06abef1b819f1d67c63d210cb8d232348e13151269d3bffd306d5a26eee148"

  head "https://github.com/ahoy-cli/ahoy.git",
    :branch => "master"

  depends_on "go" => :build

  def message; <<-EOS.udent
    ===== UPGRADING TO 2.x =====
    If you are upgrading from ahoy 1.x, note that you'll
    need to upgrade your ahoyapi settings in your .ahoy.yml
    files to 'v2' instead of 'v1'. See other changes at
    https://github.com/ahoy-cli/ahoy#version-2
    EOS
  end

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
      mv "ahoy-bin-darwin-amd64", "ahoy"
      bin.install "ahoy"
    end
  end

  test do
    system "#{bin}/ahoy", "--version"
  end
end
