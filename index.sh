#!/usr/bin/env node
const minimist = require('minimist')
const chalk = require('chalk');
var request = require('request');

const args = minimist(process.argv.slice(2))

console.log(args._[0])

var dateNow = new Date();
var dd = dateNow.getDate();
var monthSingleDigit = dateNow.getMonth() + 1,
    mm = monthSingleDigit < 10 ? '0' + monthSingleDigit : monthSingleDigit;
var yy = dateNow.getFullYear().toString();

var date1= args._[1];
var date2= args._[2];

var Spinner = require('cli-spinner').Spinner;
var spinner = new Spinner('processing.. %s');
spinner.setSpinnerString('|/-\\');
spinner.start();

request.get("https://www.quandl.com/api/v3/datasets/NSE/"+args._[0]+"/data.json?api_key=z-TzdmrxwT1H4x8oPVuM",(error,response,body) => {
	if(error)
		{
			console.log(error);
		}  
  var obj=JSON.parse(body).dataset_data.data;
   
  var size=obj.length;
  flag=0;
 
 spinner.stop()
 
  for(var i=0;i<size;i++)
  {
  	if(obj[i][0]>=date1 && obj[i][0]<=date2){
  		    if(flag==0){
  		    console.log(chalk.blue('\ndate open high low last close trade_quantity turnover(in lacs)'))
  		     }
  			console.log(chalk.green(obj[i][0])+" "+chalk.yellow(obj[i][1])+" "+chalk.green(obj[i][2])+" "+chalk.yellow(obj[i][2])+" "+chalk.green(obj[i][3])+" "+chalk.yellow(obj[i][4])+" "+chalk.green(obj[i][5])+" "+chalk.yellow(obj[i][6])+" "+chalk.green(obj[i][7]))
  			flag=1;
  		
  	
        }
  }
  if(flag==0)
  	console.log(chalk.red('\ndata between '+date1+' and '+date2+' is not available'));

 
});

