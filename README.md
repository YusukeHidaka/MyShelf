# myshelf
- 読書管理SNSです
- Amazonで本を買ったら勝手に本棚に追加されます

### 【機能】
- googleAPIでのログイン
- AmazonAPIで本をキーワード検索機能
- 本を自分の本棚に追加（ステータスを読んだ、読みたい、積読から選ぶ）
- 本のステータス管理機能（本棚間の移動）
- 本棚の本に対するレビュー機能（いきなりレビューを書くこともできる）
- 他のユーザーの投稿が見れるタイムライン
- 他のユーザーのフォロー機能
- 名前、アドレスによるユーザー検索機能
- 本棚追加数におけるランキング機能


### 【ある程度こだわった点】
- 本の検索ラインナップの充実のため、扱いにくいが蔵書の多いamazonAPIを仕様
- follow, likeのajax
- 本の登録モーダル
- ログイン中のユーザーの本棚に、対象の本が入っているか、レビューを書いているかを常にアイコンの色で表示
- 現在見ているページに対応するナビバーに色付きの下線を引く


### 【問題点、未実装の件】
- レスポンシブ（本当にすみません、不注意で、確認しておらず、PCサイズのweb用に作成してしまいました。D日程までには綺麗にします）
- ポストマンから試してみたが、やはり仕様上、amazonAPIで購入データをfetchすることができなかった。
- なのでgmailのAPIを用いて、購入メールが来たら自動で積読に追加する機能（できるかわからない。）

#### ＋α
- 検索をユーザー、本１つのボタンにし、結果をAjaxで切り替え
- 本のステータスをAjaxで切り替え
- 本の検索APIの追加（Amazonはリクエストを全然飛ばせないし遅い）
	＝＞国立国会図書館と google books
- コメント機能（準備中にしてある）
- 複数ワード検索


## How to build(first time)

`yarn start`

go to `localhost:3000/` on browser
(root path is `welcome/index`)

## Link
- [MyShelfHerokuApp](https://myshelf-web.herokuapp.com/)

## Client Routing (URL List)

```
/ → welcome:index ( only logged out user can visit here like landing page )
│
├── reviews  => Tilme Line (root_path)
│
├── users => User List (pending)
│     │
│     ├── /:id => Profile (One's Shelf)
│     │    │
│     │    ├── /followings => One's Followings
│     │    │
│     │    ├── /followers => One's Followers
│     │    │
│     │    └── /reviews => One's Reviews
│     │
│     └── /search => User Search
│
├── original_books
│     │
│     ├── /:id => Book Detail (pending)
│     │
│     └── /search => Book Search (AmazonAPI)
│
├── original_books_rankings => Ranking
│
└── * => 404
```

## SCSS policy
- using BEM
-

## Main Function
- Search books -> done
- Post/Edit review -> done
- Like/Unlike review -> done
- Ajax of like -> done
- Comment -> pending
- Add book from gmail by amazon -> pending
- Change book status by Ajax -> pending

## Structure

### OriginalBooks
#### association
- has_many :shelved_books
#### columns
- title            :string
- author           :string
- image_url        :text
- publisher        :string
- publication_date :date
- isbn             :string
- read_amount      :integer
- tsundoku_amount  :integer
- with_amount      :integer
- url              :string


### ShelvedlBooks
#### association
- belongs_to :original_book, optional: true
- has_one :review
#### columns
- original_book_id :integer
- status           :references, foreign_key :true
- user_id          :references, foreign_key :true


### Reviews
#### association
- belongs_to :user
- belongs_to :shelved_book
- has_many   :likes
- has_many   :comments
#### columns
- content         :text
- shelved_book_id :integer


### Comments
#### association
- belongs_to :review, dependent: :destroy
#### columns
- content   :text
- user_id   :integer
- review_id :integer


### Likes
#### association
- belongs_to :review, dependent: :destroy
#### columns
- user_id   :integer
- review_id :integer

## Comming Soon
- user follow, unfollow
