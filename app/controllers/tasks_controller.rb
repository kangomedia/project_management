class TasksController < ApplicationController
	
	before_action :find_project
	before_action :find_task, only: [:complete, :destroy]
	
	def create
		@task = @project.tasks.create(task_params)
			redirect_to @project
	end
	
	def complete
		@task.update_attribute(:completed_at, Time.now)
		redirect_to @project, notice: "Task Completed"
	end
	
	def destroy
		if @task.destroy
			flash[:success] = "Task was deleted."
		else
			flash[:error] = "Task was not deleted."
		end
		
		redirect_to @project
	end
	
	private
		def find_project
			@project = Project.find(params[:project_id])
		end
		
		def find_task
			@task = @project.tasks.find(params[:id])
		end
	
		def task_params
			params.require(:task).permit(:content)
		end
		
end
