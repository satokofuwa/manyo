module TasksHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'create'
      confirm_tasks_path
    end
  end
end
