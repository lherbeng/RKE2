pipeline {
    agent { label 'agent1' }

    environment {
        REPO_URL = 'https://github.com/lherbeng/RKE2.git'
        BASE_DIR = 'infra/loadbalancer'

        INSTALL_SCRIPT_PATH = "${BASE_DIR}/scripts/install_nginx.sh"
        UNINSTALL_SCRIPT_PATH = "${BASE_DIR}/scripts/uninstall_nginx.sh"
        SSL_SCRIPT_PATH = "${BASE_DIR}/ssl/generate_ssl.sh"
        SSL_LOG_SCRIPT_PATH = "${BASE_DIR}/ssl/generate_ssl_with_logs.sh"
        NGINX_CONFIG = "${BASE_DIR}/nginx/nginx.conf"
    }

    parameters {
        choice(
            name: 'ACTION',
            choices: ['install', 'uninstall'],
            description: 'Choose whether to install or uninstall LoadBalancer'
        )
        booleanParam(
            name: 'ENABLE_SSL',
            defaultValue: false,
            description: 'Enable basic SSL installation'
        )
        booleanParam(
            name: 'ENABLE_SSL_WITH_LOGS',
            defaultValue: false,
            description: 'Enable SSL installation with logs (recommended for debugging)'
        )
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out repository...'
                git url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Install NGINX') {
            when {
                expression { params.ACTION == 'install' }
            }
            steps {
                echo 'Installing NGINX...'

                sh "chmod +x ${INSTALL_SCRIPT_PATH}"
                sh "${INSTALL_SCRIPT_PATH}"

                sh """
                    if [ -f /etc/nginx/nginx.conf ]; then
                        sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
                    fi
                    sudo cp ${NGINX_CONFIG} /etc/nginx/nginx.conf
                """
            }
        }

        stage('SSL Setup') {
            when {
                expression { params.ACTION == 'install' && (params.ENABLE_SSL || params.ENABLE_SSL_WITH_LOGS) }
            }
            steps {
                script {
                    def selectedScript = params.ENABLE_SSL_WITH_LOGS
                        ? SSL_LOG_SCRIPT_PATH
                        : SSL_SCRIPT_PATH

                    echo "Running SSL script: ${selectedScript}"

                    sh """
                        sudo mkdir -p /etc/nginx/ssl
                        chmod +x ${selectedScript}
                        sudo bash ${selectedScript}
                    """

                    sh """
                        echo "Validating SSL files..."
                        ls -lah /etc/nginx/ssl || true

                        if [ ! -f /etc/nginx/ssl/lgesite.com.crt ] || [ ! -f /etc/nginx/ssl/lgesite.com.key ]; then
                            echo "ERROR: SSL cert or key missing!" >&2
                            exit 1
                        fi
                    """
                }
            }
        }

        stage('Restart NGINX') {
            when {
                expression { params.ACTION == 'install' }
            }
            steps {
                sh """
                    sudo nginx -t
                    sudo systemctl restart nginx
                """
            }
        }

        stage('Uninstall NGINX') {
            when {
                expression { params.ACTION == 'uninstall' }
            }
            steps {
                echo 'Uninstalling NGINX...'
                sh "chmod +x ${UNINSTALL_SCRIPT_PATH}"
                sh "${UNINSTALL_SCRIPT_PATH}"
            }
        }
    }

    post {
        success {
            echo "Pipeline SUCCESS: ${params.ACTION} completed"
        }
        failure {
            echo "Pipeline FAILED: ${params.ACTION} encountered an error"
        }
        always {
            cleanWs()
        }
    }
}