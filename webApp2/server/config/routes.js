var plants = require('./../controllers/plants.js');
var multer = require('multer');
var fs = require('fs');

module.exports = function(app){
	//root
	app.get('/',function(req,res){
		res.render('index');
	});

	app.get('/new',function(req,res){
		res.render('new');
	});

	app.get('/edit/:name',function(req,res){
		plants.edit(req,res);
	});


	//add plants
	app.post('/plants',function(req,res){
		plants.add(req,res);
	});

	//get all plants
	app.get('/all',function(req,res){
		plants.index(req,res);
	});

	//get plant by id
	app.get('/plants/:name',function(req,res){
		//console.log(req.params.id);
		plants.show(req,res);
		//plants.show(req,res);
	});

	//update plant
	app.post('/updatePlant/:name',function(req,res){
		plants.update(req,res);
	})

	//remove plant
	app.post('/removePlant/:name',function(req,res){
		// console.log(res);
		plants.remove(req,res);
	})


	//try to encode img as base64 string
	// app.post('/saveImg',function(req,res){
	// 	plants.saveImg(req,res);

	// })

	app.get('/printToFile',function(req,res){
		plants.printToFile(req,res);
	})

	app.get('/getAllPlants',function(req,res){
		plants.getAllPlants(req,res);
	})



}
