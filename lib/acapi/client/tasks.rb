module AcquiaCloudApi
  class Client
    module Tasks

      def tasks
        get "sites/#{@site_name}/tasks"
      end
      alias :list_tasks :tasks

      def task(task_id)
        get "sites/#{@site_name}/tasks/#{task_id}"
      end

      def task_status(task_id)
        res = task(task_id)

        res['state']
      end

      def task_complete?(task_id)
        task_status(task_id) == "done"
      end
      alias :task_done? :task_complete?

      def poll_task(task_id)
        time = 0
        delay = 4
        max = 120

        until task_complete?(task_id)
          sleep(delay)
          time += delay

          raise if time > max
        end
      end

      def poll_all

      end

    end
  end
end
