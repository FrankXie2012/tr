class BooksController < ApplicationController

  def index
    @title = "book list"
    @books = Book.all
  end

  def new

  end

  def edit
    @book = Book.find(params[:id])
  end

  def show

  end

  def create
    @book = Book.new
    @book.storage = params[:storage]
    respond_to do |format|
      if @book.save_upload_file
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
