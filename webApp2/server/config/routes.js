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
		res.end();
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

	app.post('/upload', multer({ dest: './public/uploads/'}).single('upl'), function(req,res){
		console.log(req.body); //form fields
		/* example output:
		{ title: 'abc' }
		 */
		console.log(req.file); //form files
		/* example output:
	            { fieldname: 'upl',
	              originalname: 'grumpy.png',
	              encoding: '7bit',
	              mimetype: 'image/png',
	              destination: './uploads/',
	              filename: '436ec561793aa4dc475a88e84776b1b9',
	              path: 'uploads/436ec561793aa4dc475a88e84776b1b9',
	              size: 277056 }
	 	*/
		var plant_name = req.body.name;
		var info = {
			id:plant_name,
			filename:req.file.filename,
			mimetype:req.file.mimetype,
			originalname:req.file.originalname,
		}
		console.log(info);
		plants.upload(info,res);

		res.redirect("/all");
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
