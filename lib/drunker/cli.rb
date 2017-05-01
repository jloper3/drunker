module Drunker
  class CLI < Thor
    desc "exec", "Run a command on CodeBuild"
    method_option :concurrency, :type => :numeric, :default => 1
    def exec(image, *commands)
      source = Drunker::Source.new(Pathname.pwd)
      artifact = Drunker::Executor.new(source: source, commands: commands, image: image, concurrency: options[:concurrency]).run
      puts artifact.output
      # aggregator
      source.delete
      artifact.delete
    end

    desc "version", "Show version"
    def version
      puts "Drunker #{VERSION}"
    end
  end
end
