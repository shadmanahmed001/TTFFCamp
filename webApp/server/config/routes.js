var plants = require('./../controllers/plants.js');

module.exports = function(app){
	//root
	app.get('/',function(req,res){
		res.render('index');
	});

	app.get('/new',function(req,res){
		res.render('new');
	});

	app.get('/edit/:id',function(req,res){
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
	app.get('/plants/:id',function(req,res){
		plants.show(req,res);
	});

	//update plant
	app.post('/updatePlant/:id',function(req,res){
		plants.update(req,res);
	})

	//remove plant
	app.post('/removePlant/:id',function(req,res){
		plants.remove(req,res);
	})



}

