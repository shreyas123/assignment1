Assignment 1 [![Build Status](https://travis-ci.org/shreyas123/assignment1.png?branch=master)](https://travis-ci.org/shreyas123/assignment1)
------------

Write a program that crawls a given website (up to 3 levels deep, maximum 50 pages) and counts all input elements (<input…) per page. The counts per page are for the inputs on that page plus all the inputs of the pages it refers to. Performance is a key factor so do a few optimizations 
for performance, like concurrent processing of the web pages.

Solution
--------

Please do the git clone of the repo.

Perform bundle 
<pre>
  bundle 
</pre>

You can run the app using 

<pre>
ruby app/main.rb
</pre>

You can run the specs using 

<pre>
rake spec 
</pre>

or 

<pre>
rspec spec
</pre>