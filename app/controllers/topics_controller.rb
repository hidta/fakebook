class TopicsController < ApplicationController

  prepend_before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all.order(updated_at: :desc)
    #raise
    #@users = User.all.order(updated_at: :desc)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    if params[:name]
      @comment = @topic.comments
      @comments = @topic.comments
    else
      @comment = @topic.comments.build
      @comments = @topic.comments
    end
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    respond_to do |format|
      @topics = Topic.all.order(updated_at: :desc)
      if @topic.save
        format.html { redirect_to root_path, notie: '新規作成しました' }
      else
        format.html { render 'index'}
       format.js { render :new}
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
   @topic.update(topic_params) 
   @topics = Topic.all.order(updated_at: :desc)
   redirect_to topics_path
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, alert: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :content, :icon_url, :icon_url_cache, :topic_img, :topic_img_cache)
    end

end
