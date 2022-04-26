require 'rails_helper'
RSpec.describe Label, type: :model do
  describe "label_nameの確認"do
    it "labelがある場合label_nameが存在していること" do
      @label = Label.new( 
        id: 1,
        label_name: "label0"
        )
      expect(@label).to be_valid
    end
    it "label_nameがない場合、無効であること" do
      @label = Label.new(label_name: nil)
      expect(@label.valid?).to eq(false)
      end
    end
end
