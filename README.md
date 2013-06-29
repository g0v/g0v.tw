# Introduction

[g0v.tw](http://g0v.tw) 的網頁內容由此專案產生

# Requirements

* jekyll

    目前使用 [jekyll](https://github.com/mojombo/jekyll)，將 markdown 的檔案轉換成靜態的 html 檔。因此你需要安裝 jekyll，詳細的安裝步驟請參考 [Install jekyll](http://jekyllrb.com/docs/installation/)

* rdiscount

    _config.yml 中已經把 markdown engine 換成了 rdiscount，因此還需要安裝 rdiscount

    ```
    $ sudo gem install rdiscount
    ```

# Usage

直接執行指令產生靜態網頁到 _site 目錄

    $ jekyll build

或是讓 jekyll 每逢檔案變動就自動產生靜態網頁到 _site 目錄

    $ jekyll build --watch

還能夠同時跑起一個 local http server，用 http://localhost:4000/ 存取  _site 目錄的內容

    $ jekyll serve --watch

jekyll 的 [Configuration](https://github.com/mojombo/jekyll/wiki/Configuration) 頁面有更詳盡的介紹

# Developer

我們用 gruntjs 來處理 less compile 到 css, 以及把 jade compile 到 html 的流程。

先打

    $ npm install -g grunt-cli

安裝 grunt。

    $ npm install

他會自行去安裝所有需要的 grunt modules。

安裝完之後打

    $ grunt 

這個指令會去 concat 所有的 less 變成一個檔案，然後再把那個檔案從 less compile 成 css，然後再把它壓縮變成 min。

    $ grunt build_jade

會把 `default.jade` compile 成 `_layouts/default.html`

如果你覺得每次更改 less 都要跑一次 grunt 很麻煩。沒關係你就打

    $ grunt watch 

每當你做一次 `less` 資料夾的更動他就會把全部去跑 `grunt` 的指令也就是會去 concat less, compile less, compress css。 

# Usage

現在有兩個 branch 一個是 `source` 一個是 `gh-pages`

分成兩個 branch 的主要原因是因為讓 jekyll 支援 plugin 在 gh-pages。

所以請 developers 要更動任何檔案請在 `source` ，不要再 `gh-pages` 做任何更動。

當更動完 `source` 的時候打

```
make pre_deploy
```

來讓 jekyll build 然後也會讓 git add 所有的檔案。

再來寫 git commit

```
git commit -m <your commit>
```

之後要 deploy 到 repo 的時候就打

``` 
make deploy
```

即可，這個動作會讓 git 去刪掉現有的 `gh-pages` 然後去複製一個新的 `gh-pages` 從 `source` 那個 branch 過來，再 filter 出 `_site` 裡面的資料。

再把兩個 branch 同時 push 到 remote 上。

切記！不要改 `gh-pages` 上的檔案，請改 `source` 上的檔案。然後再用 `make deploy` 來上傳到 remote repo 上。

這裡有個我寫好的 plugin 測試，再 g0v.tw 首頁的 [youtube 影片](https://github.com/chilijung/g0v.tw/blob/source/index.md)即是用 plugin 完成的！


# Writing page

直接產生一個檔案，好比是 foo.md，jekyll 就會解析該檔案並且產生 foo.html 網頁。檔案的語法使用 [Markdown](http://markdown.tw/)，而且最上方的標頭要指定使用的 layout，以下範例使用的 layout 為 default

    ---
    layout: default
    title: the page title you want
    ---

    then, write your content here


