all:
	jade -O _layouts default.jade
	lessc --yui-compress less/bootstrap.less less/compiled.css
