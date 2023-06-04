const io = require("socket.io")(3000, {
    origin:true
});

io.on("connection", socket => {
    console.log(`connected ${socket.id}`);
    socket.on("msg", message => {
        console.log(`message: ${message}`);
    });
});
