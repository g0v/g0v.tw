# Introduction

[g0v.tw](http://g0v.tw) 的網頁內容由此專案產生

# File structure



# Required

- Install nodejs
- Install npm 

# Developer

[gruntjs official site](http://gruntjs.com/)

我們用 gruntjs 來處理 less compile 到 css, 以及把 jade compile 到 html 的流程。

先打

    $ sudo npm install -g grunt-cli

安裝 grunt。

    $ npm install

安裝完之後打 grunt, 會幫你 compile jade to html 也會把 less compile to css，在更改任何一個檔案 grunt 會幫你重新 compile

    $ grunt 


# Deploy

請打

    ./deploy <git remote>
