class LabelsController < ApplicationController
  def index
    @lebels = Label.all
  end

  def new
    @lebel= Label.new
  end
  
  def create
    @label =Label.new(label_params)
    if @label.save
      redirect_to tasks_path,flash[:notice] = 'ラベル作成ができました'
    else
      redirect_to new_task_paht,flash[:notice] = 'ラベル作成に失敗しました'
    end
  end

  def update
    responded_do |format|
    if @label.update(label_params)
      edirect_to tasks_path,flash[:notice] = 'ラベルを更新しました'
    else
      redirect_to new_task_paht,flash[:notice] = 'ラベル更新に失敗しました'
    end
  end

  def desotry
    @label.destroy
    redirect_to tasks_path,flash[:notice] = 'ラベルを削除しました。'
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_label
      @label = Label.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def label_params
      params.require(:label).permit(:label_name)
    end


end
