# Introduction

[g0v.tw](http://g0v.tw) 的網頁內容由此專案產生

# Developer

我們用 gruntjs 來處理 less compile 到 css, 以及把 jade compile 到 html 的流程。

先打

    $ npm install -g grunt-cli

安裝 grunt。

    $ npm install

他會自行去安裝所有需要的 grunt modules。

安裝完之後打你更改任何一個檔案 grunt 會幫你重新 compile

    $ grunt 
