class TriggerButtonsController < ApplicationController

  layout 'admin'
  before_action :require_admin
  before_action :find_model, only: [:edit, :update, :destroy]

  def index
    @triggers = Trigger.ordered
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html {redirect_to edit_trigger_button_path}
    end
  end

  def edit
  end

  def new
    @button = Trigger.new
    @button.priority = 1
    respond_to do |format|
      format.html
    end
  end

  def destroy
    @button.destroy
    respond_to do |format|
      flash[:notice] = l(:notice_successful_delete)
      format.html {redirect_to(trigger_buttons_path)}
    end
  end


  def create
    respond_to do |format|
      @button = apply_to_model Trigger.new, :create

      if params.has_key?(:commit) && @button.save
        flash[:notice] = l(:notice_successful_create)
        format.html {redirect_to(edit_trigger_button_path(@button))}
      else
        format.html {render action: :new}
      end
    end
  end

  def update
    respond_to do |format|
      @button = apply_to_model @button, :update

      if params.has_key?(:commit) && @button.save
        flash[:notice] = l(:notice_successful_update)
        format.html {redirect_to(trigger_button_path(@button))}
      else
        format.html {render action: :edit}
      end
    end
  end

  def find_model
    @button = Trigger.find(params[:id])
    @workflow = @button.trigger_workflow
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def apply_to_model(model, scenario)
    model.trigger_workflow_id = params[:trigger][:trigger_workflow_id]
    model.title = params[:trigger][:title]
    model.position = params[:trigger][:position]
    model.priority = params[:trigger][:priority]
    model.css_classes = params[:trigger][:css_classes]
    model
  end
end
