class TriggerWorkflowsController < ApplicationController

  layout 'admin'
  before_action :require_admin
  before_action :find_model, only: [:edit, :update, :destroy]

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

  def new
    @workflow = TriggerWorkflow.new
    @workflow.is_enabled = true
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      apply_to_model @workflow, :update

      if params.has_key?(:commit) && @workflow.save
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(edit_trigger_workflow_path(@workflow)) }
      else
        format.html { render action: :edit }
      end
    end
  end

  def create
    respond_to do |format|
      @workflow = apply_to_model TriggerWorkflow.new, :create

      if params.has_key?(:commit) && @workflow.save
        flash[:notice] = l(:notice_successful_create)
        format.html { redirect_to(edit_trigger_workflow_path(@workflow)) }
      else
        format.html { render action: :new }
      end
    end
  end

  def destroy
    @workflow.destroy
    respond_to do |format|
      flash[:notice] = l(:notice_successful_delete)
      format.html { redirect_to(trigger_workflows_path) }
    end
  end

  def find_model
    @workflow = TriggerWorkflow.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def apply_to_model(model, scenario)
    model.trigger_workflow_module_id = params[:trigger_workflow][:trigger_workflow_module]
    model.name = params[:trigger_workflow][:name]
    model.comment = params[:trigger_workflow][:comment]
    model.priority = params[:trigger_workflow][:priority]
    model.is_file = params[:trigger_workflow][:is_file] == '1'
    model.is_enabled = params[:trigger_workflow][:is_enabled] == '1'
    model.on_click = params[:trigger_workflow][:on_click]
    model.after_click_success = params[:trigger_workflow][:after_click_success]
    model.after_click_failure = params[:trigger_workflow][:after_click_failure]
    model
  end
end
