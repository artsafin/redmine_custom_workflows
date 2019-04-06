class TriggerWorkflowsController < ApplicationController

  layout 'admin'
  before_action :require_admin
  before_action :find_workflow, only: [:edit, :update]

  def index
    @workflows = TriggerWorkflow.all
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html { redirect_to edit_trigger_workflow_path }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      @workflow.trigger_workflow_module_id = params[:trigger_workflow][:trigger_workflow_module_id]
      @workflow.name = params[:trigger_workflow][:name]
      @workflow.comment = params[:trigger_workflow][:comment]
      @workflow.priority = params[:trigger_workflow][:priority]
      @workflow.is_file = params[:trigger_workflow][:is_file] == '1'
      @workflow.is_enabled = params[:trigger_workflow][:is_enabled] == '1'
      @workflow.on_click = params[:trigger_workflow][:on_click]
      @workflow.after_click_success = params[:trigger_workflow][:after_click_success]
      @workflow.after_click_failure = params[:trigger_workflow][:after_click_failure]

      if params.has_key?(:commit) && @workflow.save
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(trigger_workflow_path(@workflow)) }
      else
        format.html { render action: :edit }
      end
    end
  end

  def find_workflow
    @workflow = TriggerWorkflow.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
