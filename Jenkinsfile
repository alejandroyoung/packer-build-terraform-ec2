pipeline {
    agent { 
        node {
            label 'Packer'
        }
    }
    options {
        ansiColor('xterm')
    }
    stages {
        stage ('Start') {
            steps {
                echo "start"
            }
        }    
        stage('Clean Workspace') {
            steps {
                dir("${WORKSPACE}") {
                    deleteDir()
                }
            }
        }
        stage('Download Code') {
            steps {
                dir ("${WORKSPACE}/packer"){
                    git branch: 'develop', credentialsId:'GithubToken', url: "https://github.com/sce81/pkr-build-${NAME}.git"
                }
            }
        }
        stage('Packer Build'){
            steps {
                script{
                    dir ("${WORKSPACE}/packer"){
                        sh "set +e; packer build -var 'jenkins_build_id=${env.BUILD_NUMBER}' -var 'app_version=${env.APP_VERSION}' . ; echo \$? > status"
                        def exitCode = readFile('status').trim()
                        echo "Packer Build Exit Code: ${exitCode}"
                            if (exitCode == "0") {
                                currentBuild.result = 'SUCCESS'
                            }
                            if (exitCode != "0") {
                                currentBuild.result = 'FAILURE'
                            }
                    }
                }
            }
        }
        stage('Cleanup') {
            steps {
                dir("${WORKSPACE}") {
                    deleteDir()
                }
            }
        }
    }
}