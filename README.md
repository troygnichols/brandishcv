# brandishcv.net

Example rails app for displaying your credentials in public, for when it's time to go around begging for a job.

### Where it's at
http://brandishcv.net

### What it does

Really simple.  Lets you put your CV on a website where everyone can see it.
Anybody can read anybody else's CV, but (of course) you can only edit your own.

### How to use it

1. Go to the [home page][1] and click "Get Started" to create an account
2. Click 'Edit your CV'
3. Type in some markdown
4. Click save.
5. Show your accomplishments to the world, so that somebody will hire you.

### How it works

Pretty straightforward rails app with a mysql database.

- `has_secure_password` for authentication
- [declarative authorization][2] for access control
- [pagedown/wmd][3] for editing markdown in the the browser
- [redcarpet][4] for rendering markdown on the server
- deployed on Ubuntu linux with [phusion passenger][5] and apache2


  [1]: http://brandishcv.net/
  [2]: https://github.com/stffn/declarative_authorization/
  [3]: http://code.google.com/p/pagedown/
  [4]: https://github.com/vmg/redcarpet
  [5]: https://www.phusionpassenger.com/