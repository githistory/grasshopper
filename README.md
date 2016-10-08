Grasshopper is a web <-> ssh bridge that lets you hop to a ssh server from a web interface.

Run
---

Pull the repo and
```
npm install
bower install
npm start
```
Then visit `http://localhost:3456`

Usage
-----

You'll be greeted with a dialog asking you for login info on first visit. The info is then remembered in local storage. Subsequent visits will auto connect.

You can change the login info via query param such as

```
http://localhost:3456/?host=192.168.0.121&port=2222&username=anotheruser
```

This will be very handy when you wanna automate connecting to a bunch of hosts which you use the same password / privateKey to access. For example, you might have a monitoring system that lists a bunch of hosts on your network and you wanna allow users to login to those hosts via clicking on them. You can give the hosts urls like

```
https://grasshopper.domain.name/?host=192.168.0.121&username=userA
https://grasshopper.domain.name/?host=192.168.0.122&username=userA
https://grasshopper.domain.name/?host=192.168.0.123&username=userB
https://grasshopper.domain.name/?host=192.168.0.124&username=userB
```

