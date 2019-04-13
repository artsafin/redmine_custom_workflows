class TriggerWorkflow < ActiveRecord::Base
  belongs_to :trigger_workflow_module
  has_many :triggers

  def to_s
    "#" + id.to_s + " " + name
  end

  def code
    ButtonHelper.load_code self, 'on_click'
  end

  def shown_for(issue)
    show_condition_code = ButtonHelper.load_code self, 'show_condition'
    show_condition_code.add_comment "Condition `#{self.name}`"

    unless show_condition_code.nil?
      show_condition_code.eval issue do |result|
        return result
      end
    end

    true
  end
end
