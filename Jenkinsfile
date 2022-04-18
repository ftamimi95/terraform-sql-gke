pipeline {
    
    agent {
            label 'master'
        }
    tools {
        terraform 'terraform-1-1-7'
    }
    parameters {
        string(name: 'GCP_PROJECT_ID', defaultValue: 'astute-veld-344810', description: 'GCP Project ID',)
        string(name: 'CLOUD_SQL_NAME', defaultValue: 'sql-db-test', description: 'Cloud SQL Instance name',)
        string(name: 'GCP_REGION', defaultValue: 'us-central1', description: 'GCP Region',)
        string(name: 'INSTANCE_TYPE', defaultValue: 'REGIONAL', description: 'Instance type or tier',)
        string(name: 'GCP_ZONE', defaultValue: 'us-central1-a', description: 'Zone selection if needed',)
    }
    stages {
        
        stage('Clone Repo'){
            steps{
                // git branch: 'terraform-test-branch', url: 'https://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@github.com/ftamimi95/terraform-gcp-cloud-sql-jenkins.git'
            
                sh 'ls -ltr'
            }
        }
        
        stage('GCloud Login'){
            steps{
                withCredentials([file(credentialsId: 'terraform-svc-test', variable: 'GC_KEY')]) {
                sh("gcloud auth activate-service-account --key-file=${GC_KEY}")
                }   
            }
        }
        
        // stage('plan-test'){
        //     steps{
        //         // sh 'cd ${workspace}/example/'
        //         sh 'pwd'
        //         sh 'terraform plan -f example.tf'
        //     }
        // }
        
        stage('Terraform DB Plan') {
            steps   {
                script {
                    sh 'terraform --version'
                    sh 'terraform -chdir=db init'
                    sh '''terraform -chdir=db validate && terraform plan -out tfplan \
                    --var 'project_id=astute-veld-344810' \
                    --var 'name=sql-db-test-4' \
                    --var 'region=us-east1'\
                    --var 'disk_size=10' \
                    --var 'zone=us-east1-b' \
                    --var 'database_version=MYSQL_8_0' '''
                } 
            }
        }
        stage('Terraform DB Apply') {
            steps   {
                script {
                    sh 'terraform --version'
                    sh 'terraform -chdir=db apply --input=false --auto-approve tfplan'
                } 
            }
        }
        stage('Terraform GKE cluster Plan') {
            steps   {
                script {
                    sh 'terraform --version'
                    sh 'terraform -chdir=gke-cluster init'
                    sh '''terraform -chdir=gke-cluster validate && terraform plan -out tfplan \
                    --var 'project_id=astute-veld-344810' \
                    --var 'name=sql-db-test-4' \
                    --var 'region=us-east1'\
                    --var 'disk_size=10' \
                    --var 'zone=us-east1-b' \
                    --var 'database_version=MYSQL_8_0' '''
                    
                } 
            }
        }
        stage('Terraform GKE cluster Apply') {
            steps   {
                script {
                    sh 'terraform --version'
                    sh 'terraform -chdir=gke-cluster apply --input=false --auto-approve tfplan'
                } 
            }
        }
        stage('Terraform kubernetes app Plan') {
            steps   {
                script {
                    sh 'terraform --version'
                    sh 'terraform -chdir=kubernetes init'
                    sh '''terraform -chdir=kubernetes validate && terraform plan -out tfplan \
                    --var 'project_id=astute-veld-344810' \
                    --var 'name=sql-db-test-4' \
                    --var 'region=us-east1'\
                    --var 'disk_size=10' \
                    --var 'zone=us-east1-b' \
                    --var 'database_version=MYSQL_8_0' '''
                } 
            }
        }
    }
    stage('Terraform kubernetes app Apply') {
            steps   {
                script {
                    sh 'terraform --version'
                    sh 'terraform -chdir=kubernetes apply --chdir=kubernetes --input=false --auto-approve tfplan'
                } 
            }
        }
    post {
        // Clean after build
        always {
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true,
                    patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                               [pattern: '.propsfile', type: 'EXCLUDE']])
        }
    }
}