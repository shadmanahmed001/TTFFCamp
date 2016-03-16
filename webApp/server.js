var express = require('express');
var app = express();
var bodyParser = require('body-parser');
app.use(bodyParser.json());
var path = require('path');
var fs = require("fs");
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static(__dirname+"/public"));
app.set('views',path.join(__dirname,'./views'));
app.set('view engine','ejs');

require('./server/config/mongoose.js');
require('./server/config/routes.js')(app);

var server = app.listen(8000,function(){
	console.log('listening on port 8000...');
})

var io = require('socket.io').listen(server);


io.on('connection', function(socket){
 fs.readFile(__dirname + '/public/uploads/5261d6f75deb841be35338a9524f4c17', function(err, buf){

   socket.emit('image', { image: true, buffer: buf.toString('base64') });
   console.log('image file is initialized');
 });
});

