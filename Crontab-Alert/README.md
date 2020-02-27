# Crontab Alert

## Prerequisites

- Ruby language.
- Bundler gem.
- `bundle install` before running.

## What is this

A very light Crontab task watcher (*~8MB-9MB of ram usage*) that alerts you when a new cron task has been created.

## What is it used for

This was originally intended to deal with [EvilGnome](https://www.intezer.com/blog-evilgnome-rare-malware-spying-on-linux-desktop-users/), which is a new linux malware that targets machines with GNOME desktop environment that achieves persistency through constant re-installations scheduled in cron tasks.

However, this can be used to monitor the creation of cron tasks for whatever reason.

## How it works

Cron jobs are created by typing into a temporary file that's created in `/tmp`.
Once the task is typed out, the temporary file is deleted and the task is appended to the task list.
This program watches for such temporary files, and alerts the user once a new task has been appended.
The original list of tasks is saved to a GDBM database, and when a task is appended the new list of tasks is compared against said database.

## Cron task format

The newly created cron tasks are printed to the screen as is, and are in the following format:

## Example of job definition

```HTML
n .---------------- minute (0 - 59)
n |  .------------- hour (0 - 23)
n |  |  .---------- day of month (1 - 31)
n |  |  |  .------- month (1 - 12) OR jan,feb...
n |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon...
n |  |  |  |  |
n *  *  *  *  * user-name command to be executed
17 *	* * *	root    cd / && run-parts --report /etc/cron.hourly
25 6	* * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6	* * 7	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6	1 * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
```
