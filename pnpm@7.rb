class PnpmAT7 < Formula
    require "language/node"
  
    desc "📦🚀 Fast, disk space efficient package manager"
    homepage "https://pnpm.io/"
    url "https://registry.npmjs.org/pnpm/-/pnpm-7.32.2.tgz"
    sha256 "f4b40caa0c6368da2f50b8ef891f225c24f14e7d60e42a703c84d3a9db8efede"
    license "MIT"
  
    livecheck do
      url "https://registry.npmjs.org/pnpm"
      regex(/["']latest-7["']:\s*?["']([^"']+)["']/i)
    end
  
    depends_on "node" => :test
  
    conflicts_with "corepack", because: "both installs `pnpm` and `pnpx` binaries"
  
    def install
      libexec.install buildpath.glob("*")
      bin.install_symlink "#{libexec}/bin/pnpm.cjs" => "pnpm"
      bin.install_symlink "#{libexec}/bin/pnpx.cjs" => "pnpx"
    end
  
    def caveats
      <<~EOS
        pnpm requires a Node installation to function. You can install one with:
          brew install node
      EOS
    end
  
    test do
      system "#{bin}/pnpm", "init"
      assert_predicate testpath/"package.json", :exist?, "package.json must exist"
    end
  end