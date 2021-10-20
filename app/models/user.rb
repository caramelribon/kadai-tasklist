class User < ApplicationRecord
    #self.email.downcase!は文字をすべて小文字に変換するもの
    before_save { self.email.downcase! }
    #nameのバリデーション
    validates :name, presence: true, length: { maximum: 50 }
    #emailのバリデーション、format:以降では、メールアドレスの形式が正しいものか判断するもの、uniqueness:は重複を許さないバリデーション
    validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
    #パスワードを保存するときに、パスワードを暗号化して保存する設定
    has_secure_password
    
    has_many :tasks
end
