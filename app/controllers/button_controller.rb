class ButtonController < ApplicationController
  def trigger
    id = params[:id]
    issue_id = params[:issue_id]

    Rails.logger.info "=== Trigger: id=#{id} issue_id=#{issue_id}"
    Rails.logger.flush

    issue = Issue.find(issue_id)
    trigger = Trigger.find(id)

    wf = trigger.trigger_workflow
    mod = wf.trigger_workflow_module

    helper_code = ButtonHelper.load_code mod, 'helper'
    helper_code.add_comment "Module `#{mod.name}` (#{mod.id}) triggered by `#{trigger.title}` (#{trigger.id})"

    wf_code = wf.code
    wf_code.add_comment "Workflow `#{wf.name}` (#{wf.id}) triggered by `#{trigger.title}` (#{trigger.id})"

    res = helper_code.eval issue
    res &= wf_code.eval issue

    after_click = res ? wf.after_click_success : wf.after_click_failure

    respond_to do |format|
      format.json { render json: {success: res, after_click: after_click, errors: issue.errors} }
    end
  end
end
