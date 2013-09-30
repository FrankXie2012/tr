require 'spec_helper'

describe Book do
  let(:pdf_file){read_fixture("backbone.pdf")}
  describe "test the file store" do
    let(:book){create(:book,storage: pdf_file,name: nil)}
    let(:img_file){read_fixture("rails.png")}
    it "pdf file save and delete success" do
      book.storage = pdf_file
      book.save!
      book.storage.url.should eq("#{Rails.root}/spec/support/uploads/book/storage/#{book.id}/#{book.storage.identifier}")
      book.name.should eq("backbone")
      book.remove_storage!
    end

    it "image file save failure" do
      book_img = Book.new
      book_img.storage = img_file
      (book_img.valid?).should be_false
    end
  end
  describe "save_upload_file" do

    it "success to save upload" do
      book = Book.new
      book.storage = pdf_file
      book.save_upload_file
      book.cover.url.should_not be_nil
      book.storage.url.should_not be_nil
    end
  end
end
