class Ahoy < Formula
  desc "Ahoy - Create aliases for commands on docker, ssh, and your local machine."
  homepage "https://github.com/devinci-code/ahoy"
  url "https://github.com/devinci-code/ahoy/releases/download/1.0.0/ahoy-release-1-0-0.tar.gz"
  version "1.0.0"
  sha256 "927717589f8e78c706d4e60816f6e49a66dcef925aa73ab91baff7b2c8d3d770"

  def install
    system "mv", "ahoy-darwin-amd64", "ahoy"
    bin.install "ahoy"
  end
end
