require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "review" do
    before(:each) do
      review.validate
    end

    context "when value is present" do
      let(:review) {build(:review , comment: "Awesome work")}
      it "doesnt throw any error" do
        expect(review.errors).to_not include(:comment)
      end
    end

    context "when value is nil" do
        let(:review) {build(:review , comment: nil)}
        it "throws error" do
          expect(review.errors).to include(:comment)
        end
    end

    context "when value is valid" do
        let(:review) {build(:review , comment: "Had great customer servicing")}
        it "doesnt throw any error" do
          expect(review.errors).to_not include(:comment)
        end
    end

    context "when value is invalid" do
      let(:review) {build(:review , comment: "654654578754")}
      it "throws error" do
        expect(review.errors).to include(:comment)
      end
    end

    let(:review) { FactoryBot.build(:review) }
    let(:review_with_limit) { FactoryBot.build(:review, :within_character_limit) }
  
    it "has a valid comment" do
      expect(review.comment.length).to be <= 255
    end
  
    it "has a valid comment within character limit" do
      expect(review_with_limit.comment.length).to be <= 255
    end
  end
end