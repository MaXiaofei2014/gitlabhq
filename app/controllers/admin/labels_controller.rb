class Admin::LabelsController < Admin::ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  def index
    @labels = Label.templates.page(params[:page])
  end

  def show
  end

  def new
    @label = Label.new
  end

  def edit
  end

  def create
    @label = Label.new(label_params)
    @label.template = true

    if @label.save
      redirect_to admin_labels_url, notice: "标记已创建"
    else
      render :new
    end
  end

  def update
    if @label.update(label_params)
      redirect_to admin_labels_path, notice: '标记更新成功。'
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    @labels = Label.templates

    respond_to do |format|
      format.html do
        redirect_to(admin_labels_path, notice: '标记已删除')
      end
      format.js
    end
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params[:label].permit(:title, :description, :color)
  end
end
