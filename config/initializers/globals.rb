require 'yaml'

global_info_path = File.join(Rails.root, 'config', 'globals.yml')

if File.exists?(global_info_path)
  global_info = YAML.load_file(global_info_path)
  global_info.each do |name, value|
    Object.const_set(name, value)
  end
end
