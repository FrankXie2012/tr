class Book < ActiveRecord::Base
  mount_uploader :storage, StorageUploader
  mount_uploader :cover, CoverUploader

  validates :storage, presence: true

  before_save :set_book_info

  protected
    def set_book_info
      self.name = storage.identifier
    end
end
