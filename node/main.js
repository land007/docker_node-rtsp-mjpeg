/**
 * Created by Andrew D.Laptev<a.d.laptev@gmail.com> on 30.03.15.
 */
const port = 80;
const app = require('express')()
	, server = require('http').Server(app)
	, io = require('socket.io')(server)
	, rtsp = require('rtsp-ffmpeg')
	;
// use rtsp = require('rtsp-ffmpeg') instead if you have install the package
server.listen(port, function(){
	console.log('Listening on localhost:' + port);
});

var CAMLIST = (process.env['CAMLIST'] || 'rtsp://admin:Admin123@192.168.0.241:554/h264/ch1/main/av_stream').split(',');
var WH =  process.env['WH'] || '1024x576';

//var cams = [
//		'rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov'
//		, 'rtsp://192.168.68.111/h264main'
//		, 'udp://localhost:1234'
//	].map(function(uri, i) {
//		var stream = new rtsp.FFMpeg({input: uri, resolution: '320x240', quality: 3});
var cams = CAMLIST.map(function(uri, i) {
		var stream = new rtsp.FFMpeg({input: uri, resolution: WH, quality: 3});
		stream.on('start', function() {
			console.log('stream ' + i + ' started');
		});
		stream.on('stop', function() {
			console.log('stream ' + i + ' stopped');
		});
		return stream;
	});

cams.forEach(function(camStream, i) {
	var ns = io.of('/cam' + i);
	ns.on('connection', function(wsocket) {
		console.log('connected to /cam' + i);
		var pipeStream = function(data) {
			wsocket.emit('data', data);
		};
		camStream.on('data', pipeStream);

		wsocket.on('disconnect', function() {
			console.log('disconnected from /cam' + i);
			camStream.removeListener('data', pipeStream);
		});
	});
});

io.on('connection', function(socket) {
	socket.emit('start', cams.length);
});

app.get('/', function (req, res) {
	res.sendFile(__dirname + '/index.html');
});

console.log('server start');