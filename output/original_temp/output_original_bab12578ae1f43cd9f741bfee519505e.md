**Cron Syntax for Running a Job on Weekdays at 19:00 (New York Time Zone)**

To run a job on weekdays at 19:00 in the New York time zone, use the following cron syntax:

```bash
0 19 * * 1-5 /path/to/your/script.sh
```

**Explanation:**

- **`0 19`**: This specifies the minute and hour of the day. The `0` represents the minute (at the top of the hour), and `19` represents the hour (7 PM).

- **`*`**: This is a wildcard that matches any value. It's used for the day of the month (`* *`) and the month (`*`).

- **`1-5`**: This specifies the days of the week. The numbers represent Monday (1) through Friday (5).

- **`/path/to/your/script.sh`**: Replace this with the actual path to your script.

**Example Use Case:**

Suppose you have a script named `daily_report.sh` located in the `/home/user/scripts` directory. To run this script daily at 19:00, you would use:

```bash
0 19 * * 1-5 /home/user/scripts/daily_report.sh
```

This ensures that the script runs every weekday at 7 PM New York time.