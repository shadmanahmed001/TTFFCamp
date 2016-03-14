var plants = require('./../controllers/plants.js');
var multer = require('multer');

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
		var plant_id = req.body.id;
		var info = {
			id:plant_id,
			filename:req.file.filename,
			mimetype:req.file.mimetype,
			originalname:req.file.originalname,
		}
		console.log(info);
		plants.upload(info,res);

		res.redirect("/all");
	})

	app.get('/printToFile',function(req,res){
		plants.printToFile(req,res);
	})



}

