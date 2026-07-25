class Icloud < Formula
  desc "JSON-first CLI for iCloud Mail, Calendar, and Contacts automation"
  homepage "https://github.com/AaronFaby/icloud-cli"
  url "https://github.com/AaronFaby/icloud-cli.git",
      tag:      "v1.0.7",
      revision: "83ab89947f7d6131bc8141a9884667ae0aa9e5f9"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"icloud", ldflags: "-s -w"), "./cmd/icloud"
  end

  test do
    ENV["ICLOUD_CLI_LOG"] = "off"
    output = shell_output("#{bin}/icloud services list")
    assert_match '"ok": true', output
    assert_match '"service": "mail"', output
    assert_match '"protocol": "IMAP/SMTP"', output
  end
end
