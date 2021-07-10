serve: build
	bundle exec jekyll serve
build:
	bundle exec jekyll build
update_ruby:
	gem update
	gem install bundler
	rm -f ./Gemfile.lock # how to be bad
	bundle
