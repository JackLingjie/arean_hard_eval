To copy a directory of files from server A to server B, you can use the `scp` command. Here's an example command that copies the `~/Documents/training_results` directory from server A to the `~/training_results` directory on server B:

```ssh
scp -r userA@serverA:~/Documents/training_results userB@serverB:~/training_results
```

Replace `userA` and `serverA` with the username and hostname of server A, and replace `userB` and `serverB` with the username and hostname of server B. This command will prompt you for the password of userA on server A, and then copy the directory to server B.

If you want to copy the files in the opposite direction (from server B to server A), you can use the following command:

```ssh
scp -r userB@serverB:~/training_results userA@serverA:~/Documents/training_results
```

Again, replace `userA` and `serverA` with the username and hostname of server A, and replace `userB` and `serverB` with the username and hostname of server B. This command will prompt you for the password of userB on server B, and then copy the directory to server A.