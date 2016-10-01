A boilerplate for building web apps with pure coffee-script

Run
---

```
git clone https://github.com/githistory/coffee-stack.git
cd coffee-stack
npm install
bower install
npm start
```

Usage
-----

Put your static assets in `assets` folder and you're good to go.

For example, a `GET` request to `http://localhost:3456/assets/css/app.css` will trigger the server to read content in `assets/css/app.coffee`, compile it and return the corresponding css. Likewise for html and js.

Vendor assets are served without transpilation on `/vendor/{path}` where `path` is the path into `bower_components` under project root.
