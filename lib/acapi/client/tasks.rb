module AcquiaCloudApi
  class Client
    module Tasks

      def tasks
        get "sites/#{@site_name}/tasks"
      end
      alias :list_tasks :tasks

      def task_status(task_id)
        res = get "tasks/#{task_id}"

        res['state']
      end

      def task_complete?(task_id)
        task_status == "done"
      end

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
