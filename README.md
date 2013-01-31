# Introduction

[g0v.tw](http://g0v.tw) 的網頁內容由此專案產生

# Requirements

* jekyll

    目前使用 [jekyll](https://github.com/mojombo/jekyll)，將 markdown 的檔案轉換成靜態的 html 檔。因此你需要安裝 jekyll，詳細的安裝步驟請參考 [Install jekyll](https://github.com/mojombo/jekyll/wiki/install)

* rdiscount

    _config.yml 中已經把 markdown engine 換成了 rdiscount，因此還需要安裝 rdiscount

    $ sudo gem install rdiscount

# Usage

直接執行指令產生靜態網頁到 _site 目錄

    $ jekyll

或是讓 jekyll 每逢檔案變動就自動產生靜態網頁到 _site 目錄

    $ jekyll --auto

還能夠同時跑起一個 local http server，用 http://localhost:4000/ 存取  _site 目錄的內容

    $ jekyll --auto --server

jekyll 的 [Configuration](https://github.com/mojombo/jekyll/wiki/Configuration) 頁面有更詳盡的介紹

# Writing page

直接產生一個檔案，好比是 foo.md，jekyll 就會解析該檔案並且產生 foo.html 網頁。檔案的語法使用 [Markdown](http://markdown.tw/)，而且最上方的標頭要指定使用的 layout，以下範例使用的 layout 為 default

    ---
    layout: default
    title: the page title you want
    ---

    then, write your content here


