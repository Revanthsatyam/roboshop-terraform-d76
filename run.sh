PARAMETERS="catalogue.prod.DOCUMENTDB,DOCUMENTDB"
for i in $PARAMETERS; do
  aws_ssm_pm_1=$(echo "$i" | awk -F , '{print $1}')
  echo "$aws_ssm_pm_1"
done