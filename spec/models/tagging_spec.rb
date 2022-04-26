require 'rails_helper'
RSpec.describe Tagging, type: :model do
  describe "label_idの確認"do
    it "task_id,label_id,が存在していること" do
      @tagging = Tagging.new( 
        id: 1,
        task_id: 1,
        label_id: 1 
        )
        expect(@tagging.id).to eq 1 
        expect(@tagging.task_id).to eq 1 
        expect(@tagging.label_id).to eq 1
    end
    it "label_nameがない場合、無効であること" do
      @tagging = Tagging.new(label_id: nil)
      @tagging = Tagging.new(task_id: nil)
      expect(@tagging.valid?).to eq(false)
      end
    end
end