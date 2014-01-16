# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{app/views/.+\.(slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|coffee|scss|gif|png|jpg))).*}) { |m| "/assets/#{m[3]}" }

  # JS testing
  watch(%r{test/javascripts/(.+\.(js)).*}) { |m| "/assets/#{m[1]}" }
end
