module BusinessLogic
##
## Module that contain all the business logic associated with tasks
##
## For each new task we need to:
## 1 - Add a description of the task to DESCRIPTIONS hash
## 2 - Create a function inside ClassMethods module called new_[name]_task
##      where name is the descriptive name of the new task
##
##
## If we need to overload the assign method for the event "my_event"
## 1 - Add a function in InstanceMethods called that looks like this:
##     def assign_my_event person
##         assign_default person, 'no_events'
##         # your code here
##     end
##   The 'no_events' tell the function to not set events for this specific task.
##   Remove that if you want an event to be set, or you can set the event for this task in this method.
##
## If we need to overload the work_in_progress method for the event "my_event"
## 1 - Add a function in InstanceMethods called that looks like this:
##     def wip_my_event task
##         wip_default task 'no_events'
##         # your code here
##     end
##   The 'no_events' tell the function to not set events for this specific task.
##   Remove that if you want an event to be set, or you can set the event for this task in this method.
##
## If we need to overload the complete method for the event "my_event"
## 1 - Add a function in InstanceMethods called that looks like this:
##     def done_my_event task
##         done_default task 'no_events'
##         # your code here
##     end
##   The 'no_events' tell the function to not set events for this specific task.
##   Remove that if you want an event to be set, or you can set the event for this task in this method.
##

  DESCRIPTIONS = {:need_job_developer => 'Job Seeker has no assigned Job Developer',
                  :need_case_manager  => 'Job Seeker has no assigned Case Manager'}

  module ClassMethods
    def new_js_registration_task jobseeker, agency
      [new_js_unassigned_jd_task(jobseeker, agency),
       new_js_unassigned_cm_task(jobseeker, agency)]
    end
    def new_js_unassigned_jd_task jobseeker, agency
      create_task({:agency => {agency: agency, role: :AA}}, :need_job_developer, jobseeker)
    end
    def new_js_unassigned_cm_task jobseeker, agency
      create_task({:agency => {agency: agency, role: :AA}}, :need_case_manager, jobseeker)
    end
  end
  module InstanceMethods

  end

  def description
    DESCRIPTIONS[task_type.to_sym]
  end

  private
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
end