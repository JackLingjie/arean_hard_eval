To specify which branch you want to look at when there is a tag and branch with the same name, you can use the following syntax in your Git command:

`git checkout -b <new_branch_name> <tag_name>`

This will create a new branch named `<new_branch_name>` based on the specified tag `<tag_name>`. For example, if you want to create a new branch called `my-branch` based on the tag `push-notifications`, you can use the following command:

`git checkout -b my-branch push-notifications`

This will create a new branch called `my-branch` and check it out, allowing you to work on it without affecting the original `push-notifications` branch or tag.