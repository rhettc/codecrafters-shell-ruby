require_relative 'bootstrap'
require_relative 'shell'

Bootstrap.load_dependencies
Shell.new.repl