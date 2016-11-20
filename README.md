# README

* This is an example to use test when refactorize
* note about how is structured in git this application  
  The following branch are created:  
  master: where the application lays whith uggly code without refactory  
  strategy: where the application is refactorized with stategy pattern lays  
  So to see the code once refactorized, run
  <pre>
    git checkout strategy
  <pre>

* Gem
  we use:  
* * rspec for testing  
* * byebug for debugging  
* * reek for quality code check

* ruby version
  ruby 2.3.0p0  
  rvm

* pre-commit for git

  These indications come from [tips-for-using-a-git-pre-commit-hook](http://codeinthehole.com/writing/tips-for-using-a-git-pre-commit-hook/).  
  When we run a commit, this script will be run to get the assurance that our commit is 'clean'.  
  We verify if there is no string forgotten or space at the end of line (except the 'md' files) and our test suites run softly.  
  We could run the suites test there but with bdd/tdd discipline is not usefull.

  This script lays in the 'script' directory of our application.  
  In order to install it, we have to run (on the root of our application):
  <pre>
  ln -s ../../script/pre-commit.sh .git/hooks/pre-commit
  </pre>
  NB: symlinks are resolved by git as relative

  In the case we don't want the pre-hook to be trigger, we have to run our commit with the option '--no-verify':
  <pre>
  git commit --no-verify <files>
  </pre>
