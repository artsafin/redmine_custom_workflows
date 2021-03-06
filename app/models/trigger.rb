class Trigger < ActiveRecord::Base
  belongs_to :trigger_workflow

  scope :positioned_at, ->(pos) { where(position: pos).order(priority: :asc) }
  scope :ordered, -> { order(trigger_workflow_id: :asc, priority: :asc) }

  def to_s
    title
  end

  def shown_for(issue)
    trigger_workflow.shown_for issue
  end
end
