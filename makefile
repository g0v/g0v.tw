pre_deploy: 
	jekyll build
	git add .
	git add -u


deploy:

	git branch -D gh-pages
	git checkout -b gh-pages
	git filter-branch --subdirectory-filter _site/ -f
	git checkout source
	git push --all origin 


prod: 
	grunt
	grunt build_jade


serve:
	jekyll build
	jekyll serve
