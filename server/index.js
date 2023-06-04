const io = require("socket.io")(3000, {
    origin:true
});

var robot = require("robotjs");

io.on("connection", socket => {
    console.log(`connected ${socket.id}`);
    socket.on("msg", message => {
        console.log(`message: ${message}`);
        coords = message.split(',');
        robot.dragMouse(coords[0],coords[1]);
    });
});
