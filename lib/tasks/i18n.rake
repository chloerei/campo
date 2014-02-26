namespace :i18n do
  desc 'update locales, remove unused'
  task :update => ['i18n:add_missing', 'i18n:fill:base_value', 'i18n:remove_unused']
end
