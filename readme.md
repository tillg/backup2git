# backup2git

A tool for storing backups in a git repository.

I use git repositories for backups. This comes with some advantages:

* Automatic historical versioning
* Intelligent use of space, as git does not use space for multiple copies of the same file
* Free space (for example on github or gitlab)
* Easy access of historical backups - if you are fluent in git commands...

Obviously it also has some drawbacks:

* File attributes are not maintained
* Eventually you may run out of space as the free services only offer a limited amount of space.

## How to use backup2git

Actually backup2git is not a full backup tool, it's merely the part that takes a backup and stores it into a git repo. 

The following drawing shows how I use it to store the backups of my Wordpress blog into a GitLab repo:

![Overview](./overview.png)

Here is what happens:

* When `backup.sh`is launched (i.e. via cron) it first calls `prep_backup.sh` and the `push_backup.sh`
* `prep_backup.sh` creates a backup in the `backup` directory. 
* Once this is done, `push_backup.sh` adds/commits/pushed the `backup` directory to the GitLab repo.

`backup2git`only contains the process of pushing the backup to the repo. The `prep_backup.sh` part must be provided by you. 

**Note**: When creating backups, avoid creating different files every time. I.e. do not create files like `2022-01-05_db_dump.sql`. Rather use *stable* files names (i.e. `db_dump.sql`). The versioning bit is done by git.

## Setup & Configuration

In order to setup backup2git, you need to go through the folowing steps:

### Prep the backup dir

* Log into the server that holds the `backup` directory
* Make sure the server has the git cli installed
* Go into the `backup`directory and make sure it's a git maintained directory that points to your backup repository:

```bash
cd backup  # Or wherever your backup dir is
git init -q

# In the line below set your values for the service, the userm, the repo
git remote add origin git@github.com:User/UserRepo.git

git push -u origin master
```

### Configure backup2git

`backup2git` is configured by environment variables:

* BAK2GIT_GIT_REPO
* BAK2GIT_BAK_DIR

### Setting up the cron job

**TODO**

## Restoring backups

**TODO**

## Comparing public git services

All we need in terms of API to use git repos to store backups are the standard git commands. All public services I looked at should provide this.

The major differnece is the amount of space you can store. 

| Service | Max Repo Size (GB) | Max File size (MB) | Other notes |
|---|---|---|
| Github | 100 - not tested | 100 | Pushes are limited to 2GB. About repo size: `less than 5 GB is strongly recommended` |
| GitLab | 10 | Unlimited (up to repo size) |
| Bitbucket | 1 | Unlimited (up to repo size) |

Sources:

* [Stackoverflow, Repo size limits for github, Dec 2019](https://stackoverflow.com/questions/38768454/repository-size-limits-for-github-com)
* [GitHub Follows GitLab and Bitbucket and now offers private repositories for free, Jan 2019](https://www.almtoolbox.com/blog/github-follows-gitlab-and-bitbucket-now-offers-private-repositories-for-free/)