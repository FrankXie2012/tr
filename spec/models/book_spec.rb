require 'spec_helper'

describe Book do
  describe "test the file store" do
    let(:book){create(:book,storage: pdf_file)}
    let(:pdf_file){read_fixture("backbone.pdf")}
    let(:img_file){read_fixture("rails.png")}
    it "pdf file save and delete success" do
      book.storage = pdf_file
      book.save!
      book.storage.url.should eq("#{Rails.root}/spec/support/uploads/book/storage/#{book.id}/backbone.pdf")
      book.storage.identifier.should eq("backbone.pdf")
      book.remove_storage!
    end

    it "image file save failure" do
      book_img = Book.new
      book_img.storage = img_file
      (book_img.valid?).should be_false
    end

    it "when save pdf set book cover" do
      book.cover.should_not be_nil
      book.cover.url.should eq("#{Rails.root}/spec/support/uploads/book/cover/#{book.id}/backbone_1.png")
    end
  end
end
