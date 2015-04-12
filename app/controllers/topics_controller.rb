class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    authorize @topics
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks
    authorize @topic
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def create

    @topic = Topic.new(topic_params)
    authorize @topic

    if @topic.save
      redirect_to @topic, notice: "Topic was Saved"
    else
      flash[:error] = "There was an error creating Topic. Please try again"
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    #authorize @topics
    if @topic.update_attributes(params[:id])
      redirect_to @topic
    else
      flash[:error] = "Error saving, try again"
      render :edit
    end

  end


  #create and destroy from the topics#index view
  def destroy
    @topic = Topic.find(params[:id])
    name = @topic.title
    #authorize @topics
    if @topic.destroy
      flash[:notice] ="\#{name}\" was deleted."
      redirect_to topics_show
    else
      flash[:error] = "There was an error deleting"
      render :show
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:name)
  end
end
