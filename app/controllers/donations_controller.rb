class DonationsController < ApplicationController
  def index
    @donations = Donation.all
  end

  def new
    @donation = UserDonation.new   #「UserDonation」に編集
  end

  def create
    @donation = UserDonation.new(donation_params)

    if @donation.valid?
      pay
      @donation.save  # バリデーションをクリアした時
      redirect_to root_path
    else
      render "new"    # バリデーションに弾かれた時
    end
  end

  private

  def donation_params
      #「住所」「寄付金」のキーも追加
    params.permit(:name, :name_reading, :nickname, :postal_code, :prefecture_id, :city, :house_number, :building_name, :price , :token)
  end

  def pay
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読みg込む
    customer = Payjp::Customer.create(
      description: 'test', # テストカードであることを説明
      card: @donation.token # 登録しようとしているカード情報
      )
    Payjp::Charge.create(
      amount: @donation.price, # テストカードであることを説明
      customer: customer.id, # 登録しようとしているカード情報
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
