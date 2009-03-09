class Admin::BooksController < AdminController
  
  def index
    @books=Book.find(:all, :order=>"created_at DESC")
  end

  def new
    @book=Book.new
  end

  def create
    @book=Book.new(params[:book])
    if  @book.save!
      flash[:notice]="Книга добавлена."
      redirect_to admin_books_path
    else
      render :action => "new"
    end
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if  @book.update_attributes(params[:book])
      flash[:notice]="Книга обновлена"
      redirect_to admin_books_path
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.html { redirect_to(admin_books_url) }
      format.xml  { head :ok }
    end
  end
end
