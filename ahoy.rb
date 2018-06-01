class Ahoy < Formula
  desc "Creates self documenting cli programs from commands in yaml files."
  homepage "http://www.ahoycli.com/"
  url "https://github.com/ahoy-cli/ahoy/releases/download/2.0.0/ahoy-bin-darwin-amd64"
  version "2.0.0"
  sha256 "628d239626620ddf0199670a4e91366fa1422ed0cb7c26d2cd0537a8f90937ed"

  head "https://github.com/ahoy-cli/ahoy.git",
    :branch => "master"

  depends_on "go" => :build

  def caveats; <<~EOS

    ===== UPGRADING FROM 1.x TO 2.x =====

    If you are upgrading from ahoy 1.x, note that you'll
    need to upgrade your ahoyapi settings in your .ahoy.yml
    files to 'v2' instead of 'v1'.

    See other changes at:

    https://github.com/ahoy-cli/ahoy

    EOPLIST
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
