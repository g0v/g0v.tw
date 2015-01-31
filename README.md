# Introduction

[g0v.tw](http://g0v.tw) 的網頁內容由此專案產生

# Directory structure

 * app: 網頁程式
 * md: 網頁文章

# Required

- Install nodejs
- Install npm

# Developer
[![devDependency Status](https://david-dm.org/g0v/g0v.tw/dev-status.svg)](https://david-dm.org/g0v/g0v.tw#info=devDependencies)

第一次請先執行

    $ npm install

安裝完之後打以下指令跑起 local web server

    $ npm start

然後在 browser 輸入 [http://localhost:3333](http://localhost:3333)

gulp 會自動幫你 compile jade to html, less to css, 合併 javascript, css 等。在更改任何一個檔案 gulp 也會幫你重新 compile。

# Deploy

請打

    $ ./deploy <git remote>
