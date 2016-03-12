//model
var mongoose = require('mongoose');

var Schema = mongoose.Schema;
var PlantSchema = new mongoose.Schema({
	name:{
		type:String,
		trim:true,
	},
	description:{
		type:String,
		trim:true,
	},
	location:{
		type:String,
		trim:true,
	},
	info:String,
	filename:{
		type:String,
		trim:true,
	},
	mimetype:{
		type:String,
		trim:true,
	},
	originalname:{
		type:String,
		trim:true,
	},

	created_at:Date,
	updated_at:Date,
});

mongoose.model('plants',PlantSchema);