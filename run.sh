PARAMETERS="catalogue.prod.DOCUMENTDB,DOCUMENTDB"
for i in $PARAMETERS; do
  echo $i | awk -F "," '{print $1}'
done