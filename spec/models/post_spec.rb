require 'rails_helper'

describe Post do
  describe '#create' do


    it "全ての項目の入力が存在すれば登録できること" do
      post = create(:post)
      expect(post).to be_valid
    end


    it "titleがないと登録できないこと" do
      post = build(:post, title: nil)
      post.valid?
      expect(post.errors[:title]).to include("を入力してください")
    end

    it "bodyがないと登録できないこと" do
      post = build(:post, body: nil)
      # post.valid?
      expect(post.valid?).to eq false
      expect(post.errors[:body]).to include("を入力してください")
    end

    it "imagesがないと登録できないこと" do
      post = build(:post_no_image)
      # post.valid?
      expect(post.valid?).to eq false
      expect(post.errors[:images]).to include("を入力してください")
    end

    # belongs_toの関係性で記述するもの
    describe 'アソシエーションのテスト' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end