# Punch 📇 ⌛
A simple command line interface app to help you control your hours. It enables you to easily manage the time spent on a task with the use of a few terminal commands.

## Usage 🕥
To use you simply type `punch <command> <task_name>`. The commands being the following:

```bash
❯ punch -h
Usage: punch [options]
    -s, --start TASK                 Starts a new task and logs the time that it begun
    -w, --working TASK               Sinalizes that you resumed working on an existing task
    -p, --pause TASK                 Sinalizes that you paused the work on an existing task and logs the time since the last "--working" punch
    -t, --total TASK                 Shows the total time spent on an existing task
    -l, --list                       Lists all your saved tasks
    -d, --delete TASK                Deletes an existing task
    -h, --help                       Prints this help
```

## Installation 💻
For now installation is only available through Homebrew, but others platforms are on the radar.

### Homebrew 🍺
To install it on Homebrew you first need to add the taps to your Homebrew:

`❯ brew tap Gabrielvsm/taps`

When its complete you simply install the 'punch' app:

`❯ brew install punch`

And now you're good to go and manage the time on your tasks more efficiently.
