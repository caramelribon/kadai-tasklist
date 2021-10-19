class TasksController < ApplicationController
    before_action :require_user_logged_in, only: [:index]
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
        if logged_in?
            @task = current_user.tasks.build
            @pagy, @tasks = pagy(current_user.tasks.order(id: :desc), items:5)
        end
        
        counts(current_user)
    end
    
    def show
    end
    
    def new
        @task = current_user.tasks.build
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "Taskが正常に作成されました"
            redirect_to tasks_url
        else
            @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
            flash.now[:danger] = "Taskが作成されませんでした"
            render :new
        end
    end
    
    def edit
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = "Taskは正常に作成されました"
            redirect_to tasks_url
        else
            flash.now[:danger] = "Taskは作成されませんでした"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = "Taskは正常に削除されました"
        redirect_to tasks_url
    end
    
    private
    def set_task
        @task = current_user.tasks.find(params[:id])
    end
    
    # Strong Parameter
    def task_params
        params.require(:task).permit(:content, :status)
    end
end
