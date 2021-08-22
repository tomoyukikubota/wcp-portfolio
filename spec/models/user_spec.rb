require 'rails_helper'

describe User do
  describe '#create' do
    # 入力されている場合のテスト ▼

    it "全ての項目の入力が存在すれば登録できること" do # テストしたいことの内容
      user = FactoryBot.build(:user)  # 変数userにbuildメソッドを使用して、factory_botのダミーデータを代入
      expect(user).to be_valid # 変数userの情報で登録がされるかどうかのテストを実行
    end
    # nul:false, presence: true のテスト ▼

    it "nameがない場合は登録できないこと" do # テストしたいことの内容
      user = FactoryBot.build(:user, name: nil) # 変数userにbuildメソッドを使用して、factory_botのダミーデータを代入(今回の場合は意図的にnameの値をからに設定)
      user.valid? #バリデーションメソッドを使用して「バリデーションにより保存ができない状態であるか」をテスト
      expect(user.errors[:name]).to include("を入力してください") # errorsメソッドを使用して、「バリデーションにより保存ができない状態である場合なぜできないのか」を確認し、.to include("を入力してください")でエラー文を記述(今回のRailsを日本語化しているのでエラー文も日本語)
    end

    it "emailがない場合は登録できないこと" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordがない場合は登録できないこと" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "encrypted_passwordがない場合は登録できないこと" do
      user = FactoryBot.build(:user, encrypted_password: nil)
      user.valid?
      expect(user.errors[:encrypted_password]).to include("を入力してください")
    end

    # email 一意性制約のテスト ▼

    it "重複したemailが存在する場合登録できないこと" do
        user = FactoryBot.create(:user) # createメソッドを使用して変数userとデータベースにfactory_botのダミーデータを保存
        another_user = FactoryBot.build(:user, email: user.email) # 2人目のanother_userを変数として作成し、buildメソッドを使用して、意図的にemailの内容を重複させる
        another_user.valid? # another_userの「バリデーションにより保存ができない状態であるか」をテスト
        expect(another_user.errors[:email]).to include("はすでに存在します") # errorsメソッドを使用して、emailの「バリデーションにより保存ができない状態である場合なぜできないのか」を確認し、その原因のエラー文を記述
    end

    # 確認用パスワードが必要であるテスト ▼

    it "passwordが存在してもencrypted_passwordがない場合は登録できないこと" do
        user = FactoryBot.build(:user, encrypted_password: "") # 意図的に確認用パスワードに値を空にする
        user.valid?
        expect(user.errors[:encrypted_password]).to include("を入力してください", "は6文字以上で入力してください")
    end

    # パスワードの文字数テスト ▼

    it "passwordが6文字以上であれば登録できること" do
        user = FactoryBot.build(:user, password: "111111", encrypted_password: "111111") # buildメソッドを使用して6文字のパスワードを設定
        expect(user).to be_valid
    end

    it "passwordが6文字以下であれば登録できないこと" do
      user = FactoryBot.build(:user, password: "11111", encrypted_password: "11111") # 意図的に5文字のパスワードを設定してエラーが出るかをテスト
      user.valid?
      expect(user.errors[:encrypted_password]).to include("は6文字以上で入力してください")
    end

    it "nameが2文字以上であれば登録できること" do
      user = FactoryBot.build(:user, name: "広島")
      user.valid?
      expect(user).to be_valid
    end

    it "nameが2文字以下であれば登録できないこと" do
      user = FactoryBot.build(:user, name: "広")
      user.valid?
      expect(user.errors[:name]).to include("は2文字以上で入力してください")
    end
  end
end