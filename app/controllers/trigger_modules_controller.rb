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
      format.html { redirect_to edit_trigger_module_path }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      @module.name = params[:trigger_workflow_module][:name]
      @module.comment = params[:trigger_workflow_module][:comment]
      @module.is_file = params[:trigger_workflow_module][:is_file] == '1'
      @module.helper = params[:trigger_workflow_module][:helper]

      if params.has_key?(:commit) && @module.save
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(edit_trigger_module_path(@module)) }
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
