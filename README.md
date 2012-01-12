This set of shim files enables the git [Tower.app](http://www.git-tower.com/) application to use [kdiff3](http://kdiff3.sourceforge.net/) as a diff and merge tool.

Kdiff3 isn't the most "mac-like" application, but it's my favorite merge tool out there as it has full 3-way merging in a 4 pane layout.

Clone this repository and run the install script to install the plist file and shim shell script in the appropriate directory.

    cd /tmp
    git clone git@github.com:tednaleid/git-tower-kdiff3-shim.git 
    cd git-tower-kdiff3-shim
    ./install.sh
    
The shim script assumes that you've downloaded the [kdiff3.app file](http://kdiff3.sourceforge.net/) and have it in your applications directory.  If you've gotten kdiff3 through some other means (such as [homebrew](http://mxcl.github.com/homebrew/)), you'll want to modify the script accordingly.
    