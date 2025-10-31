# Task

I would like to generate LookML code my Looker project based on the different tasks that are described in task files called "task_n_name.md". All task files are located in the folder `<project_name>/tasks/`

I'm going to ask to execute one task at a time. If I ask to execute multiple tasks please ask me to confirm the request.

There is a tracking file `<project_name>/tasks/task_execution_tracker.md` where tasks should be tracked if they are completed or not. So when a task is completed update its status in this file.

When I ask to execute a task from a file check the tracking file if all the tasks before are completed or not. If completed then it's good, if not then confirm with me my request.