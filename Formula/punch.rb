class Punch < Formula
  desc 'A digital, CLI punchcard app to control the time spent on your tasks'
  homepage 'https://github.com/Gabrielvsm/punch'
  url 'https://github.com/Gabrielvsm/punch/archive/main.zip'
  version '0.1'

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
  end
end
