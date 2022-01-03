class JobsController < ApplicationController
  before_action :authenticate_user!
  def index
    jobs = Job.all
    render json: jobs
  end

  def create
    puts "hogehoge"
    BatchJob.perform_later(current_user.id, job_params)
    render json: { message: "started" }, status: 200
  end

  private

  def job_params
    params.require(:job).permit(:id, :title)
  end
end
