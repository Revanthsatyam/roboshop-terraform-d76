pipeline {

  agent {
    label 'workstation'
  }

  parameters {
    string(name: 'ENV', defaultValue: '', description: 'Select The Environment')
    choice(name: 'WORKFLOW', choices: ['apply', 'destroy'], description: 'Select Workflow')
  }

  stages {

    stage('Build Infra') {
      when {
        expression { params.WORKFLOW == 'apply' }
      }
      steps {
        sh "make ${ENV}"
      }
    }

    stage('Destroy Infra') {
      when {
        expression { params.WORKFLOW == 'destroy' }
      }
      steps {
        sh "make ${ENV}-destroy"
      }
    }

  }

  post {
    always {
      cleanWs()
    }
  }

}