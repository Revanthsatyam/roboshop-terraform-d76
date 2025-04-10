pipeline {

  agent {
    label 'workstation'
  }

  parameters {
    choice(name: 'ENV', choices: ['dev', 'prod'], description: 'Select The Environment')
    choice(name: 'WORKFLOW', choices: ['apply', 'destroy'], description: 'Select Workflow')
  }

  stages {

    stage('Build Infra') {
      when {
        expression { params.WORKFLOW == 'apply' }
      }
      steps {
        sh "make ${params.ENV}"
      }
    }

    stage('Destroy Infra') {
      when {
        expression { params.WORKFLOW == 'destroy' }
      }
      steps {
        sh "make ${params.ENV}-destroy"
      }
    }

  }

  post {
    always {
      cleanWs()
    }
  }

}