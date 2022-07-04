const express = require("express");
const app = express();
const port = 4040;


app.get("/", (req, res) => {
    res.status(200);
    res.set({
        'Accept-Patch': 'text/html;charset=utf-8',
        'Allow': 'GET, HEAD',
        'Cache-Control': 'no-cache',
        'Content-Language': 'en',
        'Content-Type': 'text/html'
    })
    res.sendFile(__dirname + "/index.html");
})
app.get("/index", (req, res) => {
    res.status(200);
    res.set({
        'Accept-Patch': 'text/html;charset=utf-8',
        'Allow': 'GET, HEAD',
        'Cache-Control': 'no-cache',
        'Content-Language': 'en',
        'Content-Type': 'text/html'
    })
    res.sendFile(__dirname + "/index.html");
})


app.get("/home", (req, res) => {
    res.status(200);
    res.set({
        'Accept-Patch': 'text/html;charset=utf-8',
        'Allow': 'GET, HEAD',
        'Cache-Control': 'no-cache',
        'Content-Language': 'en'
    })
    res.sendFile(__dirname + "/home.html");
})


app.get("/home.html", (req, res) => {
    res.status(200);
    res.set({
        'Accept-Patch': 'text/html;charset=utf-8',
        'Allow': 'GET, HEAD',
        'Cache-Control': 'no-cache',
        'Content-Language': 'en'
    })
    res.sendFile(__dirname + "/home.html");
})


app.get("/about", (req, res) => {
    res.status(200);
    res.set({
        'Accept-Patch': 'text/html;charset=utf-8',
        'Allow': 'GET, HEAD',
        'Cache-Control': 'no-cache',
        'Content-Language': 'en'
    })
    res.sendFile(__dirname + "/about.html");
})


app.get("/about.html", (req, res) => {
    res.status(200);
    res.set({
        'Accept-Patch': 'text/html;charset=utf-8',
        'Allow': 'GET, HEAD',
        'Cache-Control': 'no-cache',
        'Content-Language': 'en'
    })
    res.sendFile(__dirname + "/about.html");
})

app.get("/getmoved", (req, res) => {
    res.status(301);
    res.set({
        'Accept-Patch': 'text/html;charset=utf-8',
        'Allow': 'GET, HEAD',
        'Cache-Control': 'no-cache',
        'Content-Language': 'en'
    })
    res.redirect("https://www.google.com");
})
app.get("/getmoved.html", (req, res) => {
    res.status(301);
    res.set({
        'Accept-Patch': 'text/html;charset=utf-8',
        'Allow': 'GET, HEAD',
        'Cache-Control': 'no-cache',
        'Content-Language': 'en'
    })
    res.redirect("https://www.google.com");
})

app.get('*', (req, res) => {
    res.status(404);
    res.set({
        'Accept-Patch': 'text/html;charset=utf-8',
        'Allow': 'GET, HEAD',
        'Cache-Control': 'no-cache',
        'Content-Language': 'en'
    })
    res.sendFile(__dirname + "/404page.html");
});
app.listen(port, () => { console.log(`app listening at http://localhost:${port}`) });