class UserDonation

  include ActiveModel::Model
  attr_accessor :name, :name_reading, :nickname, :postal_code, :city, :house_number, :building_name, :price, :token

  with_options presence: true do
    validates :name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters."}
    validates :name_reading, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters."}
    validates :nickname
    # 「住所」の郵便番号に関するバリデーション
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid."}
    # 「寄付金」に関するバリデーション
    validates :price, format: {with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters."}
  end
  # 「住所」の都道府県に関するバリデーション
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  # 「寄付金」の金額範囲に関するバリデーション
  validates :price, numericality: { greater_than_or_equal_to: 100, less_than_or_equal_to: 1000000, message: "is out of setting range"}

  def save
    # ユーザーの情報を保存し、「user」という変数に入れている
    user = User.create(name: name, name_reading: name_reading, nickname: nickname)
    # 寄付金の情報を保存
    donation = Donation.create(price: price, user_id: user.id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, user_id: user.id)
  end
end