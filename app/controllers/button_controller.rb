class ButtonController < ApplicationController
  def trigger
    id = params[:id]
    issue_id = params[:issue_id]

    Rails.logger.info "Trigger WF: id=#{id} issue_id=#{issue_id}"

    trigger = CwfTrigger.find(id)

    if trigger.nil?
      raise ActionController::RoutingError.new("Specified trigger not found: #{id}")
    end

    cwf = CustomWorkflow.find(trigger.cwf_id)

    if cwf.nil?
      raise ActionController::RoutingError.new("Specified workflow not found: #{id}")
    end

    issue = Issue.find(issue_id)

    wf_result = CustomWorkflow.run_custom_workflows(:issue, issue, :after_save)

    respond_to do |format|
      format.json { render json: {sucess: true, wf_result: wf_result} }
    end
  end
end
