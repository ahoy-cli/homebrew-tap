class Ahoy < Formula
  desc "Ahoy - Create aliases for commands on docker, ssh, and your local machine."
  homepage "https://github.com/devinci-code/ahoy"
  url "https://github.com/devinci-code/ahoy/releases/download/1.1.0/ahoy-darwin-amd64"
  version "1.1.0"
  sha256 "8bb1c76e28ca499f2dcadafdec7776ca3bd4e85c45c8d4f9f19220d5d4f233cf"

  def install
    system "mv", "ahoy-darwin-amd64", "ahoy"
    bin.install "ahoy"
  end
end
