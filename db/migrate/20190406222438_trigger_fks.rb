class TriggerFks < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :triggers, :trigger_workflows, on_delete: :nullify
    add_foreign_key :trigger_workflows, :trigger_workflow_modules, on_delete: :restrict
  end
end
