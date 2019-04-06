class AddTriggersDefaults < ActiveRecord::Migration[5.2]
  def up
    wf_module = TriggerWorkflowModule.create! do |t|
      t.name = "Default"
      t.comment = "Default module"
      t.is_file = false
      t.helper = 'Rails.logger.info "Trigger workflow module"'
    end

    wf = TriggerWorkflow.create! do |t|
      t.name = "Hello, world"
      t.comment = "Example workflow that adds a comment to issue"
      t.priority = 1
      t.is_file = false
      t.is_enabled = true
      t.on_click = 'Journal.create! journalized: self, notes: "Hello, world"'
      t.after_click_success = 'location.reload()'
      t.after_click_failure = 'alert("Fail :(")'
      t.trigger_workflow_module = wf_module
    end

    Trigger.create! do |t|
      t.title = "Hello, world 1"
      t.position = "details_bottom"
      t.priority = 1
      t.css_classes = "icon icon-edit"
      t.trigger_workflow = wf
    end

    Trigger.create! do |t|
      t.title = "Hello, world 2"
      t.position = "description_bottom"
      t.priority = 1
      t.css_classes = "icon icon-edit"
      t.trigger_workflow = wf
    end
  end

  def down
    Trigger.where(title: "Hello, world 1").destroy_all
    Trigger.where(title: "Hello, world 2").destroy_all
    TriggerWorkflow.where(name: "Hello, world").destroy_all
    TriggerWorkflowModule.where(name: "Default").destroy_all
  end
end
