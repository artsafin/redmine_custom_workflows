class TriggerModulesController < ApplicationController

  layout 'admin'
  before_action :require_admin
  before_action :find_model, only: [:edit, :update]

  def index
    @modules = TriggerWorkflowModule.all
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html { redirect_to edit_trigger_workflow_modules_path }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      @module.trigger_workflow_id = params[:trigger][:trigger_workflow_id]
      @module.title = params[:trigger][:title]
      @module.position = params[:trigger][:position]
      @module.priority = params[:trigger][:priority]
      @module.css_classes = params[:trigger][:css_classes]

      if params.has_key?(:commit) && @module.save
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(trigger_workflow_modules_path(@module)) }
      else
        format.html { render action: :edit }
      end
    end
  end

  def find_model
    @module = TriggerWorkflowModule.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
