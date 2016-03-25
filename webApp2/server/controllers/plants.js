// var mongoose = require('mongoose');
// var Plant = mongoose.model('plants');
var fs = require('fs');


function get_all(callback){
	fs.readFile('allPlants.json', 'utf8', function(err, data){
		var plants = JSON.parse(data);
		return callback(plants);
	})
}

function get_archived(callback){
	fs.readFile('archivedPlants.json', 'utf8', function(err, data){
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
		getArchived:function(req,res){
			get_archived(function(data){
				res.render('arc_results', {results: data});
			})
		},
		add:function(req,res){
			var newPlant = {
				name:(req.body.name !="")?req.body.name:"untitled",
				description:req.body.description,
				location:req.body.location,
				moreFact:req.body.moreFact,
				origin:req.body.origin,
				whenToPlant:req.body.whenToPlant,
				coolFact:req.body.coolFact,
				imgStr1:req.body.imgStr1,
				imgStr2:req.body.imgStr2,
				imgStr3:req.body.imgStr3,
				imgStr4:req.body.imgStr4,
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

		},

		remove:function(req,res){
			delete_by_id(req.params.name, function(data){
				res.redirect("/all");
			})

		},
		update:function(req,res){
			// console.log('1')
			var updated_plant = {
				name: req.body.name,
				description: req.body.description,
				location: req.body.location,
				origin: req.body.origin,
				whenToPlant: req.body.whenToPlant,
				coolFact: req.body.coolFact,
				moreFact: req.body.moreFact,
				created_at:req.body.created_at,
				updated_at: Date(),
				imgStr1 : (req.body.imgStr1 !== '')?req.body.imgStr1:req.body.original_imgStr1,
				imgStr2 : (req.body.imgStr2 !== '')?req.body.imgStr2:req.body.original_imgStr2,
				imgStr3 : (req.body.imgStr3 !== '')?req.body.imgStr3:req.body.original_imgStr3,
				imgStr4 : (req.body.imgStr4 !== '')?req.body.imgStr4:req.body.original_imgStr4,

			}

			edit_by_id(req.body.name, updated_plant, function(data){
				res.redirect('/all');
			})
			
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
				res.render("show",{plant:data});
			})
		},
		toPrintPage:function(req,res){
			get_by_id(req.params.name, function(data){
				res.render('print', {plant: data});
			})
		},

		archive:function(req,res){
			//back up data in case of crash
			fs.createReadStream('allPlants.json').pipe(fs.createWriteStream('allPlants_copy.json'));
			var arc_plant;
			var name = req.params.name;
			var arc_flag = false;
			fs.readFile('allPlants.json', 'utf8', function(err, data){
				var plants = JSON.parse(data);
				for(var plant in plants){
					if(plants[plant].name == name){
						arc_plant = (JSON.parse(JSON.stringify(plants[plant])));
						arc_flag = true;
						if(arc_flag){
							plants.splice(plant, 1);
							 fs.writeFile('allPlants.json', JSON.stringify(plants, null, 4), function(err){
							 	fs.readFile('archivedPlants.json', 'utf8', function(err, data){
									var arc_plants = JSON.parse(data);
									arc_plants.push(arc_plant);
									fs.writeFile('archivedPlants.json', JSON.stringify(arc_plants, null, 4), function(err){
										
									})
								})
							 })
						}
					}
				}
			})
			res.redirect("/all");
			

		},
		restore:function(req,res){
			fs.createReadStream('allPlants.json').pipe(fs.createWriteStream('allPlants_copy.json'));
			var restored_plant;
			var name = req.params.name;
			var res_flag = false;
			fs.readFile('archivedPlants.json', 'utf8', function(err, data){
				var plants = JSON.parse(data);
				for(var plant in plants){
					if(plants[plant].name == name){
							restored_plant = (JSON.parse(JSON.stringify(plants[plant])));
							res_flag = true;
						if(res_flag){
							plants.splice(plant, 1);
						 	fs.writeFile('archivedPlants.json', JSON.stringify(plants, null, 4), function(err){
						 		fs.readFile('allPlants.json', 'utf8', function(err, data){
									var res_plants = JSON.parse(data);
									res_plants.push(restored_plant);
									fs.writeFile('allPlants.json', JSON.stringify(res_plants, null, 4), function(err){
										
									})
								})
						 	})
							
						}	
					 	
					}
				}
			})
			res.redirect("/getArchived");
			
		},

	}//return
})()
