Use this adapted versions of

.vscode/launch.json
.vscode/tasks.json

for projects with multiple binaries that depend each on multiple source files.

You need a Makefile, that specifies all the dependencies, build rules and targets!

#--

The tasks configured in tasks.json will run the Makefile
and will start the binary specified in the task.

Debugging is configured in launch.json and starts the debugger for
the binary specified in the task 

