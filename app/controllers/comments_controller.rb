class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params) 
    @comments = @comment.topic
    respond_to do |format|
      if @comment.save
        format.html{redirect_to topic_path(@topic), notice: "コメントを投稿しました"}
        format.json{render :show, status: :created, location: @comment}
        format.js{render :index}
      else
        format.html{render :new}
        format.json{render json: @comment.errors, status: :unporocessable_entity}
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html{redirect_to topic_path(@comment.topic) }
      format.json{render :show, status: :success, location: @commment}
      format.js{render :edit}
    end
  end

  def update
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html{redirect_to topic_path(@topic), notice: "コメントを編集しました"}
        format.json{render :show, status: :created, location: @comment}
        format.js{render :index}
      else
        format.html{render :new}
        format.json{render json: @comment.errors, status: :unporocessable_entity}
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.destroy
        format.html{redirect_to topic_path(@topic), notice: "コメントを削除しました"}
        format.js{render :index}
      else
        format.html{render :new}
        format.json{render json: @comment.errors, status: unporocessable_entity}
      end
     end
  end


  private
  
  def comment_params
    params.require(:comment).permit(:topic_id, :content)
  end

end
