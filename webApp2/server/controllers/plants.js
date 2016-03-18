// var mongoose = require('mongoose');
// var Plant = mongoose.model('plants');
var fs = require('fs');

//
function get_all(callback){
	fs.readFile('allPlants.json', 'utf8', function(err, data){
		var plants = JSON.parse(data);
		return callback(plants);
	})
}

function create(new_plant, callback){
	fs.readFile('allPlants.json', 'utf8', function(err, data){
		var plants = JSON.parse(data);
		plants.push(new_plant);
		fs.writeFile('allPlants.json', JSON.stringify(plants, null, 4), function(err){
			return callback(plants);
		})
	})
}

function create_unique(new_plant, callback){
	fs.readFile('allPlants.json', 'utf8', function(err, data){
		var plants = JSON.parse(data);
		for(var plant in plants){
			if(plants[plant].name == new_plant.name){
				return callback(null);
			}
		}
		plants.push(new_plant);
		fs.writeFile('allPlants.json', JSON.stringify(plants, null, 4), function(err){
			return callback(plants);
		})
	})
}

function get_by_id(name, callback){
	fs.readFile('allPlants.json', 'utf8', function(err, data){
		var plants = JSON.parse(data);
		for(var plant in plants){
			if(plants[plant].name == name){
				return callback(plants[plant])
			}
		}
		return callback(null);
	})
}

function delete_by_id(name, callback){
	fs.readFile('allPlants.json', 'utf8', function(err, data){
		var plants = JSON.parse(data);
		for(var plant in plants){
			if(plants[plant].name == name){
			 plants.splice(plant, 1);
			 fs.writeFile('allPlants.json', JSON.stringify(plants, null, 4), function(err){
				 return callback(plants);
			 })
			}
		}
		// return callback(null);
	})
}

function edit_by_id(name, edit, callback){
	fs.readFile('allPlants.json', 'utf8', function(err, data){
		var plants = JSON.parse(data);
		for(var plant in plants){
			if(plants[plant].name == name){
				plants[plant] = edit;
				fs.writeFile('allPlants.json', JSON.stringify(plants, null, 4), function(err){
					return callback(plants)
				})
			}
		}
		// console.log('5');
		// return callback(null);
	})
}

function add_img_by_id(name, data, callback){
	fs.readFile('allPlants.json', 'utf8', function(err, data){
		var plants = JSON.parse(data);
		for(var plant in plants){
			if(plants[plant].name == name){
				var edit_plant = plants[plant];
				for(var e in data){
					edit_plant[e] = data[e];
				}
				fs.writeFile('allPlants.json', JSON.stringify(plants, null, 4), function(err){
					return callback(plants)
				})
			}
		}
		return callback(null);
	})
}

function better_update_by_id(name, data, callback){
	fs.readFile('allPlants.json', 'utf8', function(err, data){
		var plants = JSON.parse(data);
		for(var plant in plants){
			if(plants[plant].name == name){
				var edit_plant = plants[plant];
				for(var e in data){
					edit_plant[e] = data[e];
				}
				fs.writeFile('allPlants.json', JSON.stringify(plants, null, 4), function(err){
					return callback(plants)
				})
			}
		}
		return callback(null);
	})
}

module.exports = (function(){
	return{
		index:function(req,res){
			get_all(function(data){
				res.render('results', {results: data});
			})
			// Plant.find({},function(err,output){
			// 	if(err){
			// 		console.log(err);
			// 	}else{
			// 		res.render('results',{results:output});
			// 	}
			// })
		},
		add:function(req,res){
			var newPlant = {
				name:req.body.name,
				description:req.body.description,
				location:req.body.location,
				moreFact:req.body.moreFact,
				origin:req.body.origin,
				whenToPlant:req.body.whenToPlant,
				coolFact:req.body.coolFact,
				imgStr:req.body.imgStr,
				created_at:Date(),
				updated_at:Date(),
			};

			create_unique(newPlant, function(data){
				if(data == null){
					console.log('problem');
					res.render('new', {error: 'You must add a unique plant name!'})
				}else{
					res.redirect('/new');
				}
			})
			// var newPlant = new Plant({
			// 	name:req.body.name,
			// 	description:req.body.description,
			// 	location:req.body.location,
			// 	moreFact:req.body.moreFact,
			// 	origin:req.body.origin,
			// 	whenToPlant:req.body.whenToPlant,
			// 	coolFact:req.body.coolFact,
			// 	imgStr:req.body.imgStr,
			// 	created_at:Date(),
			// 	updated_at:Date(),
			// });
			// newPlant.save(function(err,output){
			// 	if(err){
			// 		console.log(err);
			// 	}else{
			// 		console.log('add plant successfully.');
			// 		res.redirect("/new");
			// 	}
			// })
		},
		// show:function(req,res){
		// 	Plant.findOne({_id:req.params.id },function(err,output){
		// 		if(err){
		// 			console.log(err);
		// 		}else{
		// 			res.json(output);
		// 		}
		// 	})
		// },
		remove:function(req,res){
			delete_by_id(req.params.name, function(data){
				res.redirect("/all");
			})
			// Plant.remove({_id:req.params.id },function(err,status){
			// 	if(err){
			// 		console.log(err);
			// 	}else{
			// 		console.log('remove successfully');
			// 		res.redirect("/all");
			// 	}
			// })
		},
		update:function(req,res){
			console.log('1')
			var updated_plant = {
				name: req.body.name,
				description: req.body.description,
				location: req.body.location,
				origin: req.body.origin,
				whenToPlant: req.body.whenToPlant,
				coolFact: req.body.coolFact,
				moreFact: req.body.moreFact,
				created_at:req.body.created_at,
				updated_at: Date()
			}
			if(req.body.imgStr !== ''){
				// console.log('2')
				updated_plant.imgStr = req.body.imgStr;
				edit_by_id(req.body.name, updated_plant, function(data){
					// console.log('3')
					res.redirect('/all');
				})
			}else{
				updated_plant.imgStr = req.body.original_imgStr;
				edit_by_id(req.body.name, updated_plant, function(data){
					// console.log('3')
					res.redirect('/all');
				})
			}
		},
		edit:function(req,res){
			get_by_id(req.params.name, function(data){
				res.render('edit', {plant: data});
			})

		},
		upload:function(info,res){
			Plant.findOne({_id:info.id },function (err, doc){
			  doc.filename = info.filename;
			  doc.mimetype = info.mimetype;
			  doc.originalname = info.originalname;
			  doc.updated_at = Date();
			  doc.save();
			});
		},
		printToFile:function(req,res){
			Plant.find({},function(err,output){
				if(err){
					console.log(err);
				}else{
					var outputFilename = 'allPlants.json';
					fs.writeFile(outputFilename, JSON.stringify(output, null, 4), function(err) {
					    if(err) {
					      console.log(err);
					    } else {
					      console.log("JSON saved to " + outputFilename);
					      res.redirect("/all");
					    }
					});
				}
			})
		},
		getAllPlants:function(req,res){
			console.log('success!!');
			get_all(function(data){
				res.json(data);
			})
		},
		show:function(req,res){
			get_by_id(req.params.name, function(data){
				res.json(data);
			})
		},

	}
})()
