# The Resume Brandisher

Example rails app for displaying your credentials in public, for when it's time to go around begging for a job.

### Deployed at
[http://cv.tgn.io](http://cv.tgn.io)

### What it does

Lets you put your CV or resume on a website where everyone can see it.
Anybody can read anybody else's CV, you can only edit your own.

### How to use it

1. Go to the [home page][1] and create an account
2. Click 'Edit your CV'
3. Type in some markdown
4. Click save.
5. Show your accomplishments to the world, so that somebody will hire you.

### Technology used

- `has_secure_password` for authentication
- [declarative authorization][2] for access control
- [pagedown/wmd][3] for editing markdown in the the browser
- [redcarpet][4] for rendering markdown on the server
- [pandoc][6] for creating PDF and MS Word docs
- deployed on Ubuntu linux with [unicorn][5] and nginx


  [1]: http://cv.tgn.io/
  [2]: https://github.com/stffn/declarative_authorization/
  [3]: http://code.google.com/p/pagedown/
  [4]: https://github.com/vmg/redcarpet
  [5]: http://unicorn.bogomips.org/
  [6]: http://pandoc.org/
