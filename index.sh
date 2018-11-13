#!/usr/bin/env node
const minimist = require('minimist')
const chalk = require('chalk');
require('date-utils') 
const args = minimist(process.argv.slice(2))
console.log(args._[0])
const ora = require('ora');
 
const obj = new ora({interval: 80, // optional
    frames: ['-', '+', '-']});

 obj.start()
 setTimeout(() => {
 	obj.clear()
    obj.render()
}, 10);
var request = require('request');
var dateNow = new Date();
var dd = dateNow.getDate();
var monthSingleDigit = dateNow.getMonth() + 1,
    mm = monthSingleDigit < 10 ? '0' + monthSingleDigit : monthSingleDigit;
var yy = dateNow.getFullYear().toString();

var today = yy + '-' + mm + '-' + dd;
console.log(today)
request.get("https://www.quandl.com/api/v3/datasets/NSE/"+args._[0]+"/data.json?end_date="+today+"&start-date="+today+"&api_key=z-TzdmrxwT1H4x8oPVuM",(error,response,body) => {
	if(error)
		{
			console.log(error);
		}
    console.log(JSON.parse(body));
});
obj.stop()
