# README
---
# 開発環境　
* Apple M3
* macOS sequoia 15.1.1
---
# 開発言語
* Ruby version 3.3.0 
* Rails version 7.2.2.1
---
# 実行手順
```
$ git clone git@github.com:su1-90/order_analysis.git
$ cd order_analysis
$ bundle install
$ rails db:create && rails db:migrate
$ rails s
```
---
# カタログ設計
https://docs.google.com/spreadsheets/d/1MYK-Xq9TiWdAyoOWqrJhX0jcO-QdpfM7lRy6tlCkGUg/edit?usp=sharing
---
# テーブル定義書
https://docs.google.com/spreadsheets/d/1MYK-Xq9TiWdAyoOWqrJhX0jcO-QdpfM7lRy6tlCkGUg/edit?usp=sharing
---
# ワイヤーフレーム
https://www.figma.com/design/c6RvyDDqYy68EmfK6WMkfl/%E7%B5%82%E5%A3%B2%E7%AE%A1%E7%90%86%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0?node-id=0-1&t=bE4tGquU5HMMYKpc-1
---
# ER図
<img width="817" alt="Image" src="https://github.com/user-attachments/assets/b2c513d5-a781-45f9-b683-a7ff70ab8de9" />
---
# 画面遷移図
<img width="1028" alt="Image" src="https://github.com/user-attachments/assets/782a4406-adfc-496c-8d52-26794318140b" />

# 留意事項
+ ゲストログインデータ
　権限ユーザー：user_code: 'admin02', password: 'password'
　一般ユーザー：user_code: 'user02', password: 'password',
+ 新規でログインできない場合　seedデータを改めて投入する必要があります。
```
heroku run rake db:seed
```

+ データの分析にはCatgptを用いているため正常にデータをインポートしてもうまく予測数量が出力されないことがあります。再度分析を実行するかデータを削除してやり直してみてください。

+ informationは簡易的な使い方しか想定していないので保存できるデータは１つだけです。