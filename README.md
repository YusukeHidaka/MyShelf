# myshelf

## How to build(first time)

go to `localhost:3000/` on browser
(root path is `welcome/index`)

## How to develop

## Reference

## Link

## Routing

```
/ → welcome:index (for now it's set as top page like `landing page` )
│
├── users
│
├── original_books
│
├── shelved_books
│
├── comments
│
├── reviews
│
└── *
```

## Structure

### OriginalBooks
#### association
- has_many :shelved_books

#### columns
- title           :string
- author          :string
- image_url       :text
- publisher       :string
- publish_date    :date
- isbn            :string
- read_amount     :integer
- tsundoku_amount :integer
- with_amount     :integer
- 

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
