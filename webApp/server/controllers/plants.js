var mongoose = require('mongoose');
var Plant = mongoose.model('plants');

module.exports = (function(){
	return{
		index:function(req,res){
			Plant.find({},function(err,output){
				if(err){
					console.log(err);
				}else{
					res.render('results',{results:output});
				}
			})
		},
		add:function(req,res){
			var newPlant = new Plant({
				name:req.body.name,
				description:req.body.description,
				location:req.body.description,
				info:req.body.info,
				created_at:Date(),
				updated_at:Date(),
			});
			newPlant.save(function(err,output){
				if(err){
					console.log(err);
				}else{
					console.log('add plant successfully.');
					res.redirect("/new");
				}
			})
		},
		show:function(req,res){
			Plant.findOne({_id:req.params.id },function(err,output){
				if(err){
					console.log(err);
				}else{
					res.json(output);
				}
			})
		},
		remove:function(req,res){
			Plant.remove({_id:req.params.id },function(err,status){
				if(err){
					console.log(err);
				}else{
					console.log('remove successfully');
					res.redirect("/all");
				}
			})
		},
		update:function(req,res){
			Plant.findOne({_id:req.params.id },function (err, doc){
			  doc.name = req.body.name;
			  doc.description = req.body.description;
			  doc.location = req.body.location;
			  doc.info = req.body.info;
			  doc.updated_at = Date();
			  doc.save();
			  res.redirect("/all");
			});
		},
		edit:function(req,res){
			Plant.findOne({_id:req.params.id },function(err,output){
				if(err){
					console.log(err);
				}else{
					res.render("edit",{plant:output});
				}
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

	}
})()