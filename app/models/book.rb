class Book < ActiveRecord::Base
  mount_uploader :storage, StorageUploader
  mount_uploader :cover, CoverUploader

  validates :storage, presence: true

  before_save :set_book_info

  acts_as_taggable

  def book_name
    storage.path.split("/").last.gsub(".pdf","").gsub(/[_|.]/, " ")
  end

  def save_upload_file
    if self.save
      self.cover = ParesPdf.new(self.storage.current_path).get_cover
      self.save
    else
      false
    end
  end

  protected
    def set_book_info
      self.name ||= book_name
    end
end
