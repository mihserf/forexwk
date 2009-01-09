class BooksController < ApplicationController
  def index
    @books = Book.paginate(:page => params[:page], :per_page => 10, :order=>"created_at DESC")
  end

  def show
    @book = Book.find(params[:id])
  end
end
