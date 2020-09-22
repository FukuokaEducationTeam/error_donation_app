
require "rails_helper"

RSpec.describe UserDonation, type: :model do

  describe "validation" do
    
    before do
      @user_donation = FactoryBot.build(:user_donation)
    end

    context "All clear" do
      it "is valid with all of columns" do
        expect(@user_donation).to be_valid
      end
    end

    context "presence true" do
      it "is invalid without name" do
        @user_donation.name = nil
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Name can't be blank")
      end

      it "is invalid without name_reading" do
        @user_donation.name_reading = nil
        @user_donation.valid?
        expect(@user_donation.errors.full_messages[0]).to include("Name reading can't be blank")
      end

      it "is invalid without description" do
        @user_donation.nickname = nil
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Nickname can't be blank")
      end

      it "is invalid without postal_code" do
        @user_donation.postal_code = nil
        @user_donation.valid?
        expect(@user_donation.errors.full_messages[0]).to include("Postal code can't be blank")
      end

      it "is invalid without price" do
        @user_donation.price = nil
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Price can't be blank")
      end

      it "is invalid without token" do
        @user_donation.token = nil
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Token can't be blank")
      end
    end

    context "format" do
      it "is invalid with name that the format is half-with letter" do
        @user_donation.name = "aaa"
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Name is invalid. Input full-width characters.")
      end

      it "is invalid with name_reading that the format is half-with letter" do
        @user_donation.name_reading = "aaa"
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Name reading is invalid. Input full-width katakana characters.")
      end

      it "is invalid with name_reading that the format is hiragana letter" do
        @user_donation.name_reading = "ああああ"
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Name reading is invalid. Input full-width katakana characters.")
      end

      it "is invalid with postal_code that the format is 121234" do
        @user_donation.postal_code = "121234"
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Postal code is invalid.")
      end

      it "is invalid with upppercase letter" do
        @user_donation.price = "１０００"
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Price is invalid. Input half-width characters.")
      end
    end

    context "amount range" do
      it "is invalid with 1" do
        @user_donation.price = "0"
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Price is out of setting range")
      end

      it "is invalid with 1100000" do
        @user_donation.price = "1100000"
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Price is out of setting range")
      end
    end

    context "other_than" do
      it "is invalid with 0" do
        @user_donation.prefecture_id = "0"
        @user_donation.valid?
        expect(@user_donation.errors.full_messages).to include("Prefecture can't be blank")
      end
    end
  end
end