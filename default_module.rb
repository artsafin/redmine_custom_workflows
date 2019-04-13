def subtask_with_suffix(issue, suffix)
  subject = issue.subject + " / " + suffix
  subs = issue.children.where(subject: subject).count

  assign_to = Principal.like(suffix).first

  if subs > 0
    raise WorkflowError, "'#{subject}' is already there, so not creating another one"
  else
    Issue.create!(
        author: User.current,
        project: issue.project,
        tracker: Tracker.named("Task").first,
        assigned_to: assign_to.nil? ? issue.author : assign_to,
        parent_issue_id: issue.id,
        subject: subject
    )
  end
end
