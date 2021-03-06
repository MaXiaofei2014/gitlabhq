class Dashboard::TodosController < Dashboard::ApplicationController
  before_action :find_todos, only: [:index, :destroy, :destroy_all]

  def index
    @todos = @todos.page(params[:page])
  end

  def destroy
    todo.done

    todo_notice = '待办事项已完成。'

    respond_to do |format|
      format.html { redirect_to dashboard_todos_path, notice: todo_notice }
      format.js { head :ok }
      format.json do
        render json: { count: @todos.size, done_count: current_user.todos.done.count }
      end
    end
  end

  def destroy_all
    @todos.each(&:done)

    respond_to do |format|
      format.html { redirect_to dashboard_todos_path, notice: '所有待办事项都已完成。' }
      format.js { head :ok }
      format.json do
        find_todos
        render json: { count: @todos.size, done_count: current_user.todos.done.count }
      end
    end
  end

  private

  def todo
    @todo ||= current_user.todos.find(params[:id])
  end

  def find_todos
    @todos = TodosFinder.new(current_user, params).execute
  end
end
