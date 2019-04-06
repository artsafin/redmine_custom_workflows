class TriggerButtonsController < ApplicationController

  layout 'admin'
  before_action :require_admin
  before_action :find_model, only: [:edit, :update]

  def index
    @triggers = Trigger.all
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html { redirect_to edit_trigger_button_path }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      @button.trigger_workflow_id = params[:trigger][:trigger_workflow_id]
      @button.title = params[:trigger][:title]
      @button.position = params[:trigger][:position]
      @button.priority = params[:trigger][:priority]
      @button.css_classes = params[:trigger][:css_classes]

      if params.has_key?(:commit) && @button.save
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(trigger_button_path(@button)) }
      else
        format.html { render action: :edit }
      end
    end
  end

  def find_model
    @button = Trigger.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
