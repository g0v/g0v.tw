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

> 因為此 project 會需要用到 ajax ，目前的解決方法是啟動一個小型的 server

server 的啟動方式

    $ npm install connect
    $ node server.js

然後在 browser 輸入 [http://localhost:8080](http://localhost:8080)

# Deploy

請打

    ./deploy <git remote>
