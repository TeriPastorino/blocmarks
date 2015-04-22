class BookmarksController < ApplicationController
  # def index
  #   false
  # end

#do we have to authorize? guessing not since we already had them sign in to see anything?
  def show
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.find(params[:id])
    #authorize @topic
    authorize @bookmark
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user
    @bookmark.topic = @topic
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark Saved"
      redirect_to @topic
    else
      flash[:error] = "Error Saving Bookmark"
      render :new
    end
  end


  def update
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

    if @bookmark.update_attributes(bookmark_params)
      flash[:notice] = "Bookmark was updated"
      redirect_to @bookmark
    else
      flash[:error] = "Error updating bookmark"
      render :edit

      respond_to do |format|
      format.html
      format.js
    end
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    #title = @bookmark.title
    authorize @bookmark

    if @bookmark.destroy
      flash[:notice] = "Bookmark was deleted"
      redirect_to edit_topic_bookmark_path @topic
    else
      flash[:error] = "Error deleting bookmark"
      render :show
    end
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:url)
    
  end
end  


