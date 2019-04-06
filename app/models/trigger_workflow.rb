class TriggerWorkflow < ActiveRecord::Base
  belongs_to :trigger_workflow_module
  has_many :triggers

  def to_s
    "#" + id.to_s + " " + name
  end
end
