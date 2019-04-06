class TriggerWorkflowModule < ActiveRecord::Base
  has_many :trigger_workflows

  def to_s
    name
  end
end
