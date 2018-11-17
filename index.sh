#!/usr/bin/env node
const minimist = require('minimist')
const chalk = require('chalk');
"use strict";
var csv = require("csv-query");
require('date-utils') 

const args = minimist(process.argv.slice(2))
console.log(args._[0])
const ora = require('ora');
 
const obj = new ora({interval: 80, // optional
    frames: ['-', '+', '-']});

 obj.start()
var request = require('request');
var dateNow = new Date();
var dd = dateNow.getDate();
var monthSingleDigit = dateNow.getMonth() + 1,
    mm = monthSingleDigit < 10 ? '0' + monthSingleDigit : monthSingleDigit;
var yy = dateNow.getFullYear().toString();

var date1= args._[1];
var date2= args._[2];

request.get("https://www.quandl.com/api/v3/datasets/NSE/"+args._[0]+"/data.json?api_key=z-TzdmrxwT1H4x8oPVuM",(error,response,body) => {
	if(error)
		{
			console.log(error);
		}  
  var obj=JSON.parse(body).dataset_data.data;
   
  var size=obj.length;
  flag=0;
  
  for(var i=0;i<size;i++)
  {
  	if(obj[i][0]>=date1 && obj[i][0]<=date2){
  		    if(flag==0){
  		    console.log('date open high low last close trade_quantity turnover(in lacs)')
  		}
  			console.log(obj[i][0]+" "+obj[i][1]+" "+obj[i][2]+" "+obj[i][2]+" "+obj[i][3]+" "+obj[i][4]+" "+obj[i][5]+" "+obj[i][6]+" "+obj[i][7])
  			flag=1;
  		
  	
}
  }
  if(flag==0)
  	console.log('data between '+date1+' and '+date2+' is not available');

 
});
obj.stop()
