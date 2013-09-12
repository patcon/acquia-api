require 'acapi/helpers'

module AcquiaCloudApi
  class Client
    module Tasks
      include AcquiaCloudApi::Helpers

      def tasks
        get "sites/#{site_name}/tasks"
      end
      alias :list_tasks :tasks

      def task(task_id)
        get "sites/#{site_name}/tasks/#{task_id}"
      end

      def task_status(task_id)
        res = task(task_id)

        res['state']
      end

      def task_complete?(task_id)
        task_status(task_id) == "done"
      end
      alias :task_done? :task_complete?

      def poll_task(task_id, timeout = 120)
        time = 0

        fib_n = 6

        until task_complete?(task_id)
          raise if time > timeout

          delay = nth_fib(fib_n)
          sleep(delay)

          fib_n += 1
          time += delay
        end
      end

      def poll_all
      end

    end
  end
end
