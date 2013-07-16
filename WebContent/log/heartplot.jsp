<%@ page language="Java" import="java.sql.*,java.util.Date"%>   
<jsp:useBean id="db" scope="request" class="com.icu.plot.DbBean"/> 
<jsp:setProperty name="db" property="*" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>VITAL DISPLAY CHART</title>
        <script type="text/javascript" src="../js/jquery.min.js"></script>
		<script type="text/javascript" src="../js/jquery.jqplot.min.js"></script>
		<script type="text/javascript" src="../js/plugins/jqplot.json2.min.js"></script>
		<script type="text/javascript" src="../js/plugins/jqplot.canvasTextRenderer.min.js"></script>
		<script type="text/javascript" src="../js/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
		<script type="text/javascript" src="../js/plugins/jqplot.dateAxisRenderer.min.js"></script>
		<script type="text/javascript" src="../js/plugins/jqplot.highlighter.min.js"></script>
		<script type="text/javascript" src="../js/plugins/jqplot.enhancedLegendRenderer.min.js"></script>
		<link rel="stylesheet" type="text/css" href="../js/jquery.jqplot.min.css" />
<script type="text/javascript">	
setTimeout(function(){

	location.reload();
},5*1000);

$(document).ready(function(){
	//alert("haiii");
	//var line1 = [['2013-07-02 18:34:22',27], ['2013-07-02 18:34:52',32]]; 
	  var line2=$.parseJSON(document.getElementById("testdata").value);

	  var mydata = [[]];
	  for(var i=0; i<line2.length; i++) {
		  	mydata[0].push([line2[i].time,line2[i].valueint]);
		}
		
	//	alert(line1);
		//alert(mydata);
        
	  	  var plot3 = $.jqplot('chart', mydata, {
	      title:'VITALS CHART-HEART RATE', 
	      axesDefaults: {
		        labelRenderer: $.jqplot.CanvasAxisLabelRenderer
		      },
	      axes:{
	        xaxis:{
	          renderer:$.jqplot.DateAxisRenderer,
	          label:'TIME',
	          tickOptions:{formatString:'%d/%m/%y\n%I:%M:%S %p'}
	          //tickInterval:'30 second'
	        },

           yaxis:{
                 label: 'HEART-RATE'
               }
          
	      },
	      series:[{lineWidth:4,markerOptions:{style:'square'}}]
	  });
	});
</script>
<body>
<center>
<input type="hidden" id ="test" value='[{"time":"2013-07-02 18:33:52","valueint":25.000},{"time":"2013-07-02 18:34:22","valueint":24.000},{"time":"2013-07-02 18:34:52","valueint":25.000}]'>
                                 

<%

//Connection con=db.connect();
ResultSet rs=null;
String time=null;
String val=null;
StringBuffer lSbrValue = new StringBuffer("[");
int count = 0; 
rs=db.execSQL("select * from (select creation_time,respiration from bed_side_monitor_tpro where patient_id='b01' ORDER BY creation_time DESC LIMIT 10)A ORDER BY creation_time ASC");
while(rs.next())
{
	time=rs.getString(1);
	val=rs.getString(2);
	
	
	if(count>0)
	{
		lSbrValue.append(",");
	}
	lSbrValue.append("{").append("\"time\"").append(":").append("\"").append(time).append("\",")
	.append("\"valueint\"").append(":").append(val)
	.append("}");
	count = count+1; 
}
	
lSbrValue.append("]");
db.close();
//System.out.println(lSbrValue.toString());
%>

<input type="hidden" id="testdata" value='<%=lSbrValue.toString()%>'>

<div id="chart" style="height:500px; width:500px;"></div>
</center>
</body>
</html>