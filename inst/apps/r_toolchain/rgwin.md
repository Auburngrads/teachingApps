---
output: html_document
---

### To install Git on personally-owned Windows machines...

1. Go to [GitHub.com](https://github.com/) and sign up for an account 

    a. Choose a username 

    b. Add an email address (don't use your afit.edu address as your primary, you can add it as a secondary address later)

    c. Enter a password

2. After logging in, search for `Auburngrads/test-repo` to find the `test-repo` repository created by `Auburngrads`

3. On the `test-repo` page click <img src='media/images/fork.png' style='vertical-align: top; height: 30px;'> to fork a copy of the repo to your account
<a name='git'></a>

## Install & Configure Git

1. With the `installr` package, Git may be installed from within R by running `installr::install_git()` 

2. Without the `installr` package Git can be installed from <a target=" " href="https://git-scm.com/">HERE</a>

3. Once the install completes, close and re-open RStudio

    a. Open the 'Tools' menu and select 'Global Options'

    b. In 'Global Options' select 'Git/SVN'

    c. If the 'Git Executable' window is blank click 'Browse' and navigate to `C:\Program Files\Git\bin\bin.exe` click OK

    d. If the path to `git.exe` is already listed in the 'Git Executable' window, Git has been installed correctly

4. Next, we'll make sure Git is configured 

    a. Search your machine for the 'Git Bash' application, open the application and type the following two lines

    b. `git config --global user.name your.github.username`

    c. `git config --global user.email your.github.email`

    d. Close Git Bash

5. Finally, let's set up the SSH connection between RStudio and GitHub

    a. Open 'Tools' $\rightarrow$ 'Global Options' $\rightarrow$ 'Git/SVN'

    b. Toward the bottom of the 'Git/SVN' dialog click 'Create RSA Key'

    c. After the RSA Key appears click 'Close'

    d. Click 'View Public Key' and copy the text in the window

    e. Return to your GitHub.com account page and click the drop-down arrow next to your account avatar (upper-right corner) $\rightarrow$ select 'Settings'

    f. Under 'Settings' select 'SSH and GPG Keys'

    g. Select 'New SSH Key' $\rightarrow$ choose a name for the key, like `personal machine`

    h. Paste the public key in the window and select 'Add SSH Key'

## Creating & Linking RProjects

1. Click <img src='media/images/project.png' style='vertical-align: top; height: 30px;'> and select 'New Project'

2. At the menu select 'Version Control' and then 'Git'

3. Enter the repository url

    a. If you've set-up SSH enter the url as `git@github.com:your.user.name/test-repo.git`

    b. If you have not set up SSH enter the url as `https://github.com/your.user.name/test-repo.git`

4. Select 'OK' and Git will clone the `test-repo` to your machine

5. Once the project opens, edit and commit the changes to the `README.md` file

    a. Add your initials to the list of initials and save the file

    b. Find the project tabs <img src='media/images/git.png' style='vertical-align:top; height:30px;'> in the upper-right pane of RStudio

    c. Select the 'Git' tab

    d. The `README.md` file should be listed as a changed file

    e. Click the checkbox next to the filename and then click 'Commit'

    f. In the Commit dialog, enter a short message in the window detailing the changes you made and click `Commit`

6. Now that the changes have been committed they need to be `Pushed` so that their online counterparts match

    a. Close the `Commit` dialog and press `Push`

    b. A window may appear asking for a username and password - ignore this.

    c. After the `Push` is complete a message will appear indicating that the changes have been syned to the Master branch

7. Submit a <quote>Pull-Request</quote> to sync the changes in your version of `test-repo` to my version of `test-repo`

    a. Navigate to the `test-repo` repository page under your account

    b. Select Pull requests $\rightarrow$ 'New Pull Request'

    c. Git will perform a `Diff` to determine which files have been changed

    d. As only the README.md file is changed between the two repos this should be the only file listed.

    e. Select 'Create Pull Request'

8. Once the pull request is finished - so is the process to build R/RStudio toolchain for data science
