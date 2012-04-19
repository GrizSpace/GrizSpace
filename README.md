# Where's My Class?

...where's my code?

# Setup

1. `git clone ...`
2. `cd GrizSpace`
3. `rake db:setup`

# Git

Please see the [Pro Git](http://progit.org/book/) (free) for an overview, or
[GitHub's excellent help](http://help.github.com/).

XCode's Git integration is great, unless you're collaborating with anyone.
Thus, you'll need to use the shell (or try it with GitHub app).

## Branches

- _master_ -- this is stable. Do not push directly to this unless you know
  your commits do not break the build.

- _fix-34-arrow-is-inverted_ -- this is an example of a _topic_ branch. These
  are short-lived branches that are for _bugs_ or _features_. The reason
  behind a short, topic branch is they're easier to merge into _master_ than a
  long-lived, user-specific branch.

## Pulling Changes

1. If you have a "dirty" repo, run `git stash save "My WIP"` to set your
   changes aside
2. `git pull --rebase` to pull changes
3. `git log` to view a log of recent commits
4. `git show <some SHA1 hash>` (or `git show` with no arguments to view
   a diff of the last commit)
5. `git stash pop` to pop your stashed changes off (i.e., make them
   current and visible)

## Committing Changes

A visual tool like GitHub app or GitX is recommended for staging changes
(these let you stage hunks of code instead of whole files).

1. `git status` to see what files are modified or untracked. If it's
   untracked, then Git doesn't know about it. This is important: Committing
   modified files that depend on untracked files _does not_ add the untracked
   files.

2. `git diff` will show your modifications to _tracked_ files. By default,
   this will open it up in a pager program
   ([`less`](http://en.wikipedia.org/wiki/Less_(Unix))). If you'd prefer a
   GUI, Google "git diff opendiff|Filemerge".

3. `git add <filename>`, regardless of whether it's modified or untracked.
   This is referred to as "staging" the commit.

4. `git commit` will open whatever your default `$EDITOR` is (probably `nano`
   -- `^` means press `Control`). Keep the _first_ line of your commit to 50
   characters or less, otherwise your message will be garbled on GitHub and in
   the CLI. Leave a blank line, and then make your next line as long as 72
   characters.

        My descriptive commit SUBJECT

        This explains more about my commit. You do not need to specify your name
        or date since that is metadata associated with the commit.

        If you are having a hard time writing a succinct subject line (50
        chars), chances are your commit is doing too much. Break it into smaller
        commits.

## Pushing Changes

You do not have to push after every commit. In fact, it is probably best if
you do not so you can fix typos and not break builds (look into `git commit
--amend` for fixing commit typos or adding skipped files).

1. `git status` shows you your current repo status
2. `git pull --rebase` to check
3. `git push`

## Creating Branches

1. `git checkout master` ensures you are on the master branch
2. `git checkout -b my-new-branch-with-descriptive-name` will create a new
   branch and check it out (switch to it).
3. `git push origin my-new-branch-with-descriptive-name` will push the branch
   up to GitHub. This is not necessary unless you want to share your changes
   with us.

## Merging Branches

Try to merge commits into _master_ sooner rather than later to avoid hairy
merges. Here's how you do it from shell:

1. `git checkout master`
2. `git merge --no-ff my-new-branch-with-descriptive-name` will merge your
   branch into _master_.
3. `git branch -d my-new-branch-with-descriptive-name` will delete your
   topic branch.

# Database

We are storing just the text SQL in `data/*.sql` instead of the binary
`.sqlite` file. This allows us to do text-diffs between schema and data, and
as a result, we have more control.

- `rake db:schema` if you want to commit schema changes
- `rake db:data` if you want to commit data changes
- `rake db:dump` for both schema and data
- `rake db:setup` to load the schema and data

If you'd like to run the import, you need to install two gems first:

    sudo gem install sqlite3 sequel --no-ri --no-rdoc

Then run `rake -rrubygems import_courses`.
