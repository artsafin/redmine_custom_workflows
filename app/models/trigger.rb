class Trigger < ActiveRecord::Base
  belongs_to :trigger_workflow

  scope :positioned_at, ->(pos) { where(position: pos).order(priority: :asc) }
end
