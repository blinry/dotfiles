Motivation and Core Idea
========================

Previously, I had my dotfiles separated into categories, with public and private branches, and symlinked them from `$HOME`. That approach certainly had some elegance, but, as old Einstein said, we should make things as simple as possible (but not simpler!).

Now, my home directory simply *is* the Git repository. No layers, no unnecessary complexity. Basic personal variables are set in `.secrets`, right now just name and email. For other personal stuff, “.local” files or folders are used. For example, public aliases are in `.aliases`, aliases I don't want you to see are in `.aliases.local`, which isn't version controlled. Personal scripts live in `.bin.local/`, and so on.

Setup
=====

1. Create an empty Git repository in your home directory and add this repository as a remote:

        cd
        git init
        git remote add origin git@github.com:blinry/dotfiles.git
    
    If you don't have a GitHub account and SSH keys set up, use this (read-only) URL instead:
    
        git remote add origin git://github.com/blinry/dotfiles.git

2. Now fetch from the remote and check it out:

        git fetch
        git checkout -b master origin/master

    If you get errors about untracked files that would get overwritten, move them to a backup directory and try again. You can merge them later.

3. Execute the almighty setup script. It will set up the Vim bundles.

        .meta/setup

4. Create your `.secrets` file:

        cp .secrets.example .secrets

    Set the variables to your liking.

5. Relogin! You're done.
