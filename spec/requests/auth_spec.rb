require 'rails_helper'

RSpec.describe "Auths", type: :request do
  let!(:user) { User.create!(:email => "foo@bar.com", :password => "12345678") }
  describe "Post /api/v1/login" do
    it "should not login by email or password(not existing)" do
      post v1_login_path , :email => "foo@bar.com" , :password => "87654321"
      expect(response).to have_http_status(401)
      data = { "message" => "Email or Password is wrong" }
      expect(JSON.parse(response.body)).to eq(data)
    end

    it "should login by email or password(existing)" do
      post v1_login_path , :email => "foo@bar.com" , :password => "12345678"

      # TODO 檢查 http_status
      # expect(response).to have_http_status(___)
      # TODO 完成返回內容
      data = {
      }
      # expect(JSON.parse(response.body)).to eq(data)
    end
  end
end
