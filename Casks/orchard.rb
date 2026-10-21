cask "orchard" do
  version "0.1.0"
  sha256 "53ebd1c974484ac837e0b61570b88119d47779407cac1f2e9711baab4da44ced"

  url "https://github.com/rodpru/orchard/releases/download/v#{version}/Orchard_#{version}_universal.dmg"
  name "Orchard"
  desc "Run coding agents in parallel git worktrees"
  homepage "https://github.com/rodpru/orchard"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Orchard.app"
  binary "#{appdir}/Orchard.app/Contents/MacOS/orchard"

  # The app is not notarized. Remove the quarantine flag so Gatekeeper does not block the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Orchard.app"]
  end

  zap trash: [
    "~/Library/Application Support/io.github.rodpru.orchard",
    "~/Library/Caches/io.github.rodpru.orchard",
    "~/Library/WebKit/io.github.rodpru.orchard",
  ]
end
