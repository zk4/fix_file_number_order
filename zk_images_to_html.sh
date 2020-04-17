#!/bin/bash
rm index.html
echo '
<style>
.center {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 50%;
}

</style>
' >> index.html;
for a in `ls *.jpg`; do echo " <img src='$a' class='center'>" >> index.html; done

sleep 1 && open http://zk.liu:8000  &
python -m http.server

 
