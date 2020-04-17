#!/bin/bash
rm index.html
echo '
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta http-equiv="content-type" content="text/html;charset=utf-8">
<body>		
<style>
.center {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 50%;
}

</style>
' >> index.html;
for a in */; 
		do echo " <a href='/${a}' class='center'>${a}</a>" >> index.html; 
		pushd "$a"
		echo '
		<style>
		.center {
		  display: block;
		  margin-left: auto;
		  margin-right: auto;
		  width: 50%;
		}

		</style>
		' > index.html;
		for a in `ls *.jpg`; 
			do echo " <img src='$a' class='center'>" >> index.html; 
			done
		popd

done

echo '
 </body>
' >> index.html

#sleep 1 && open http://zk.liu:8000  &
python -m http.server

 
