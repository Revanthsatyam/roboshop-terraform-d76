PARAMETERS="catalogue.prod.DOCUMENTDB,DOCUMENTDB"
for i in $PARAMETERS; do
  aws_ssm_pm_1=$(echo "$i" | awk -F , '{print $1}')
  aws_ssm_pm_2=$(echo "$i" | awk -F , '{print $2}')
  echo "$aws_ssm_pm_1 $aws_ssm_pm_2"
done