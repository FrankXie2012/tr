class BooksController < ApplicationController

  def index
    @title = "book list"
    @books = Book.all
  end

  def new
  end

  def create
    @book = Book.new
    @book.storage = params[:storage]
    respond_to do |format|
      if @book.save
        @book.cover = ParesPdf.new(@book.storage.current_path).get_cover
        @book.save
        format.json {render json: @book, status: 200}
      else
        format.json {render json: @book.errors[:storage][0], status: 406}
      end
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.remove_storage!
    book.destroy
    render text: "success"
  end
end
