all:
	jade -O _layouts default.jade
	lessc less/bootstrap.less less/compiled.css
