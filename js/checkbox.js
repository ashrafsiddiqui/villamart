var fieldName='';
var formName="";

function fieldSName(val,formN){
     fieldName = val;
	 formName=formN
}

function selectall(){
  var i=document.eval(formName).elements.length;
  var e=document.eval(formName).elements;
  var name=new Array();
  var value=new Array();
  var j=0;
  for(var k=0;k<i;k++)
  {
    if(document.eval(formName).elements[k].name==fieldName)
	{
      if(document.eval(formName).elements[k].checked==true){
	    value[j]=document.eval(formName).elements[k].value;
		j++;
	  }
	}
  }
  checkSelect();
}
function selectCheck(obj)
{
 var i=document.eval(formName).elements.length; 
  for(var k=0;k<i;k++)
  {
    if(document.eval(formName).elements[k].name==fieldName)
	{
      document.eval(formName).elements[k].checked=obj;
	}
  }
  selectall();
}

function selectallMe()
{
  if(document.eval(formName).allCheck.checked==true)
  {
   selectCheck(true);
  }
  else
  {
	selectCheck(false);
  }
}
function checkSelect()
{
 var i=document.eval(formName).elements.length; 
 var berror=true;
  for(var k=0;k<i;k++)
  {
    if(document.eval(formName).elements[k].name==fieldName)
	{
      if(document.eval(formName).elements[k].checked==false)
	  {
	    berror=false;
	    break;
	  }
	}
  }
  if(berror==false)
  {
    document.eval(formName).allCheck.checked=false;
  }
  else
  {
    document.eval(formName).allCheck.checked=true;
  }
}