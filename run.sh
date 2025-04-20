PARAMETERS="catalogue.prod.DOCUMENTDB,DOCUMENTDB"
for i in $PARAMETERS; do
  aws_ssm_pm_1=$(echo "$i" | awk -F , '{print $1}')
  aws_ssm_pm_2=$(echo "$i" | awk -F , '{print $2}')
  aws_parameter=$(aws ssm get-parameter --name "${aws_ssm_pm_1}" --with-decryption --query "Parameter.Value" --output text)
  export abc=123
done