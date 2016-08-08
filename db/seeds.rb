# seed DB with comics and characters with data from the developer.marvel API
# seed public/images folder with all comic thumbnail images

Rake::Task["marvel:save_comics"].invoke
Rake::Task["marvel:save_characters"].invoke



