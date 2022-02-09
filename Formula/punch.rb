class Punch < Formula
  desc 'A digital, CLI punchcard app to control the time spent on your tasks'
  homepage 'https://github.com/Gabrielvsm/punch'
  version '0.1'

  url 'https://github.com/Gabrielvsm/punch/archive/main.zip', using: :curl

  def install
    bin.install 'bin/punch'
  end
end