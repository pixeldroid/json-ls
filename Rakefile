
LIB_NAME = 'Json'
LIB_VERSION_FILE = File.join('lib', 'src', 'pixeldroid', 'json', 'Json.ls')

begin
  load(File.join(ENV['HOME'], '.loom', 'tasks', 'loomlib.rake'))
  load(File.join(ENV['HOME'], '.loom', 'tasks', 'loomlib_demo.rake'))
rescue LoadError
  abort([
    'error: missing loomtasks',
    '  please install loomtasks v1.1.0 or later before running this Rakefile:',
    '  https://github.com/pixeldroid/loomtasks/',
  ].join("\n"))
end

Rake::Task['demo:cli'].clear # no cli demo for this project
